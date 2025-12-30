import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:slovingo/models/user.dart';

class UserService {
  static const String _userKey = 'current_user';

  Future<void> _initSampleData() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(_userKey)) {
      final sampleUser = User(
        id: 'user_1',
        name: 'Učenec',
        email: 'ucenec@slovingo.si',
        currentLevel: 1,
        totalPoints: 0,
        streak: 0,
        lastActive: DateTime.now(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      await prefs.setString(_userKey, jsonEncode(sampleUser.toJson()));
    }
  }

  Future<User?> getCurrentUser() async {
    await _initSampleData();
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString(_userKey);
    if (userJson == null) return null;
    return User.fromJson(jsonDecode(userJson));
  }

  Future<void> updateUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userKey, jsonEncode(user.toJson()));
  }

  Future<void> updateUserProgress(int level, int points) async {
    final user = await getCurrentUser();
    if (user != null) {
      final updatedUser = user.copyWith(
        currentLevel: level,
        totalPoints: user.totalPoints + points,
        lastActive: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      await updateUser(updatedUser);
    }
  }

  Future<void> updateStreak() async {
    final user = await getCurrentUser();
    if (user != null) {
      final now = DateTime.now();
      final lastActive = user.lastActive;
      final difference = now.difference(lastActive).inDays;
      
      int newStreak = user.streak;
      if (difference == 1) {
        newStreak++;
      } else if (difference > 1) {
        newStreak = 1;
      }

      final updatedUser = user.copyWith(
        streak: newStreak,
        lastActive: now,
        updatedAt: now,
      );
      await updateUser(updatedUser);
    }
  }
}