import 'package:flutter/material.dart';
import 'package:slovingo/models/user.dart';
import 'package:slovingo/models/level.dart';
import 'package:slovingo/models/quiz.dart';
import 'package:slovingo/models/progress.dart';
import 'package:slovingo/models/translation.dart';
import 'package:slovingo/services/user_service.dart';
import 'package:slovingo/services/level_service.dart';
import 'package:slovingo/services/quiz_service.dart';
import 'package:slovingo/services/progress_service.dart';
import 'package:slovingo/services/translation_service.dart';

class AppProvider with ChangeNotifier {
  final UserService _userService = UserService();
  final LevelService _levelService = LevelService();
  final QuizService _quizService = QuizService();
  final ProgressService _progressService = ProgressService();
  final TranslationService _translationService = TranslationService();

  User? _currentUser;
  List<Level> _levels = [];
  bool _isLoading = false;

  // Translation state (used by TranslateScreen)
  List<Translation> _translationHistory = [];

  User? get currentUser => _currentUser;
  List<Level> get levels => _levels;
  bool get isLoading => _isLoading;

  List<Translation> get translationHistory => _translationHistory;

  Future<void> initialize() async {
    _isLoading = true;
    notifyListeners();

    _currentUser = await _userService.getCurrentUser();
    _levels = await _levelService.getAllLevels();
    _translationHistory = await _translationService.getHistory();

    _isLoading = false;
    notifyListeners();
  }

  Future<List<Quiz>> getQuizzesByLevel(String levelId) async {
    return await _quizService.getQuizzesByLevel(levelId);
  }

  int calculateQuizScore(List<String> answers, List<Quiz> quizzes) {
    return _quizService.calculateScore(answers, quizzes);
  }

  Future<void> completeLevel(String levelId, int score) async {
    if (_currentUser == null) {
      _currentUser = await _userService.getCurrentUser();
      if (_currentUser == null) return;
    }

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

      if (levelIndex != -1 && levelIndex < _levels.length - 1) {
        await _levelService.unlockLevel(_levels[levelIndex + 1].id);
        _levels = await _levelService.getAllLevels();
      }

      await _userService.updateUserProgress(_currentUser!.currentLevel + 1, score);
      _currentUser = await _userService.getCurrentUser();
    }

    notifyListeners();
  }



  Future<String> translate(String text, String sourceLang, String targetLang) async {
    final result = await _translationService.translate(text, sourceLang, targetLang);
    _translationHistory = await _translationService.getHistory();
    notifyListeners();
    return result;
  }

  Future<void> saveApiKey(String apiKey) async {
    await _translationService.saveApiKey(apiKey);
  }

  Future<String?> getApiKey() async {
    return await _translationService.getApiKey();
  }
}
