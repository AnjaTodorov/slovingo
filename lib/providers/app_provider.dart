import 'package:flutter/material.dart';
import 'package:slovingo/models/user.dart';
import 'package:slovingo/models/level.dart';
import 'package:slovingo/models/quiz.dart';
import 'package:slovingo/models/progress.dart';
import 'package:slovingo/services/user_service.dart';
import 'package:slovingo/services/level_service.dart';
import 'package:slovingo/services/quiz_service.dart';
import 'package:slovingo/services/progress_service.dart';

class AppProvider with ChangeNotifier {
  final UserService _userService = UserService();
  final LevelService _levelService = LevelService();
  final QuizService _quizService = QuizService();
  final ProgressService _progressService = ProgressService();

  User? _currentUser;
  List<Level> _levels = [];
  bool _isLoading = false;

  User? get currentUser => _currentUser;
  List<Level> get levels => _levels;
  bool get isLoading => _isLoading;

  
  Future<void> initialize() async {
    _isLoading = true;
    notifyListeners();

    _currentUser = await _userService.getCurrentUser();
    _levels = await _levelService.getAllLevels();

    _isLoading = false;
    notifyListeners();
  }

  /// Used by QuizScreen._loadQuizzes()
  Future<List<Quiz>> getQuizzesByLevel(String levelId) async {
    return await _quizService.getQuizzesByLevel(levelId);
  }

  /// Used by QuizScreen._finishQuiz()
  int calculateQuizScore(List<String> answers, List<Quiz> quizzes) {
    return _quizService.calculateScore(answers, quizzes);
  }

  /// Used by QuizScreen._finishQuiz() -> provider.completeLevel(levelId, score)
  /// Saves progress, unlocks next level if passed, updates user progress.
  Future<void> completeLevel(String levelId, int score) async {
    if (_currentUser == null) {
      
      _currentUser = await _userService.getCurrentUser();
      if (_currentUser == null) return;
    }

    // Ensure we have levels for unlocking logic
    if (_levels.isEmpty) {
      _levels = await _levelService.getAllLevels();
    }

    final progress = Progress(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      userId: _currentUser!.id,
      levelId: levelId,
      score: score,
      completed: score >= 70,
      attempts: 1,
      lastAttempt: DateTime.now(),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    await _progressService.saveProgress(progress);

    if (score >= 70) {
      final levelIndex = _levels.indexWhere((l) => l.id == levelId);

      // Unlock next level
      if (levelIndex != -1 && levelIndex < _levels.length - 1) {
        await _levelService.unlockLevel(_levels[levelIndex + 1].id);
        _levels = await _levelService.getAllLevels();
      }

      // Update user progress (level/points) 
      await _userService.updateUserProgress(_currentUser!.currentLevel + 1, score);
      _currentUser = await _userService.getCurrentUser();
    }

    notifyListeners();
  }
}
