import 'package:slovingo/models/user.dart';
import 'package:slovingo/services/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class UserService {
  Future<User?> getCurrentUser() async {
    final db = await DatabaseHelper.instance.database;
    final rows = await db.query('users', limit: 1);
    if (rows.isEmpty) return null;
    return User.fromJson(rows.first);
  }

  Future<User?> getUserById(String userId) async {
    final db = await DatabaseHelper.instance.database;
    final rows = await db.query('users', where: 'id = ?', whereArgs: [userId], limit: 1);
    if (rows.isEmpty) return null;
    return User.fromJson(rows.first);
  }

  Future<void> updateUser(User user) async {
    final db = await DatabaseHelper.instance.database;
    await db.insert(
      'users',
      user.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
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
