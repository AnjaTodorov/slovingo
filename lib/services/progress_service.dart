import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:slovingo/models/progress.dart';

class ProgressService {
  static const String _progressKey = 'progress_data';

  Future<List<Progress>> getAllProgress(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    final progressJson = prefs.getString(_progressKey);
    if (progressJson == null) return [];
    
    try {
      final List<dynamic> decoded = jsonDecode(progressJson);
      final allProgress = decoded.map((json) => Progress.fromJson(json)).toList();
      return allProgress.where((p) => p.userId == userId).toList();
    } catch (e) {
      return [];
    }
  }

  Future<Progress?> getProgressByLevel(String userId, String levelId) async {
    final allProgress = await getAllProgress(userId);
    try {
      return allProgress.firstWhere((p) => p.levelId == levelId);
    } catch (e) {
      return null;
    }
  }

  Future<void> saveProgress(Progress progress) async {
    final prefs = await SharedPreferences.getInstance();
    final progressJson = prefs.getString(_progressKey);
    
    List<Progress> allProgress = [];
    if (progressJson != null) {
      try {
        final List<dynamic> decoded = jsonDecode(progressJson);
        allProgress = decoded.map((json) => Progress.fromJson(json)).toList();
      } catch (e) {
        allProgress = [];
      }
    }
    
    final existingIndex = allProgress.indexWhere(
      (p) => p.userId == progress.userId && p.levelId == progress.levelId
    );
    
    if (existingIndex != -1) {
      allProgress[existingIndex] = progress;
    } else {
      allProgress.add(progress);
    }
    
    final updatedJson = allProgress.map((p) => p.toJson()).toList();
    await prefs.setString(_progressKey, jsonEncode(updatedJson));
  }

  Future<Map<String, dynamic>> getStatistics(String userId) async {
    final allProgress = await getAllProgress(userId);
    
    final completedLevels = allProgress.where((p) => p.completed).length;
    final totalAttempts = allProgress.fold<int>(0, (sum, p) => sum + p.attempts);
    final averageScore = allProgress.isEmpty 
        ? 0 
        : allProgress.fold<int>(0, (sum, p) => sum + p.score) / allProgress.length;
    
    return {
      'completedLevels': completedLevels,
      'totalAttempts': totalAttempts,
      'averageScore': averageScore.round(),
    };
  }
}