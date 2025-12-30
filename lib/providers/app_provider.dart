import 'package:flutter/material.dart';
import 'package:slovingo/models/user.dart';
import 'package:slovingo/models/level.dart';
import 'package:slovingo/models/word.dart';
import 'package:slovingo/models/quiz.dart';
import 'package:slovingo/models/progress.dart';
import 'package:slovingo/models/translation.dart';
import 'package:slovingo/models/chat_message.dart';
import 'package:slovingo/services/user_service.dart';
import 'package:slovingo/services/level_service.dart';
import 'package:slovingo/services/word_service.dart';
import 'package:slovingo/services/quiz_service.dart';
import 'package:slovingo/services/progress_service.dart';
import 'package:slovingo/services/translation_service.dart';
import 'package:slovingo/services/chat_service.dart';

class AppProvider with ChangeNotifier {
  final UserService _userService = UserService();
  final LevelService _levelService = LevelService();
  final WordService _wordService = WordService();
  final QuizService _quizService = QuizService();
  final ProgressService _progressService = ProgressService();
  final TranslationService _translationService = TranslationService();
  final ChatService _chatService = ChatService();

  User? _currentUser;
  List<Level> _levels = [];
  List<Word> _words = [];
  Word? _wordOfDay;
  List<Translation> _translationHistory = [];
  List<ChatMessage> _chatMessages = [];
  bool _isLoading = false;
  bool _isChatLoading = false;

  User? get currentUser => _currentUser;
  List<Level> get levels => _levels;
  List<Word> get words => _words;
  Word? get wordOfDay => _wordOfDay;
  List<Translation> get translationHistory => _translationHistory;
  List<ChatMessage> get chatMessages => _chatMessages;
  bool get isLoading => _isLoading;
  bool get isChatLoading => _isChatLoading;

  Future<void> initialize() async {
    _isLoading = true;
    notifyListeners();

    _currentUser = await _userService.getCurrentUser();
    _levels = await _levelService.getAllLevels();
    _words = await _wordService.getAllWords();
    _wordOfDay = await _wordService.getWordOfDay();
    _translationHistory = await _translationService.getHistory();

    if (_currentUser != null) {
      _chatMessages = await _chatService.getChatHistory(_currentUser!.id);
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> updateUserProgress(int level, int points) async {
    await _userService.updateUserProgress(level, points);
    _currentUser = await _userService.getCurrentUser();
    notifyListeners();
  }

  Future<void> updateStreak() async {
    await _userService.updateStreak();
    _currentUser = await _userService.getCurrentUser();
    notifyListeners();
  }

  Future<List<Word>> getWordsByLevel(String levelId) async {
    return await _wordService.getWordsByLevel(levelId);
  }

  Future<List<Quiz>> getQuizzesByLevel(String levelId) async {
    return await _quizService.getQuizzesByLevel(levelId);
  }

  Future<void> completeLevel(String levelId, int score) async {
    if (_currentUser == null) return;

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

      await updateUserProgress(_currentUser!.currentLevel + 1, score);
    }

    notifyListeners();
  }

  Future<Map<String, dynamic>> getUserStatistics() async {
    if (_currentUser == null) return {};
    return await _progressService.getStatistics(_currentUser!.id);
  }

  Future<Progress?> getLevelProgress(String levelId) async {
    if (_currentUser == null) return null;
    return await _progressService.getProgressByLevel(_currentUser!.id, levelId);
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

  Future<void> sendChatMessage(String message) async {
    if (_currentUser == null) return;

    _isChatLoading = true;
    notifyListeners();

    await _chatService.sendMessage(_currentUser!.id, message);
    _chatMessages = await _chatService.getChatHistory(_currentUser!.id);

    _isChatLoading = false;
    notifyListeners();
  }

  Future<void> clearChatHistory() async {
    if (_currentUser == null) return;
    await _chatService.clearHistory(_currentUser!.id);
    _chatMessages = [];
    notifyListeners();
  }

  int calculateQuizScore(List<String> answers, List<Quiz> quizzes) {
    return _quizService.calculateScore(answers, quizzes);
  }
}
