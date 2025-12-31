import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:slovingo/models/user.dart';
import 'package:slovingo/models/level.dart';
import 'package:slovingo/models/word.dart';
import 'package:slovingo/models/progress.dart';
import 'package:slovingo/models/translation.dart';
import 'package:slovingo/models/chat_message.dart';
import 'package:slovingo/models/lesson_task.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slovingo/services/level_service.dart';
import 'package:slovingo/services/word_service.dart';
import 'package:slovingo/services/translation_service.dart';
import 'package:slovingo/services/chat_service.dart';
import 'package:slovingo/services/database_helper.dart';
import 'package:slovingo/services/seed_service.dart';
import 'package:slovingo/services/firestore_user_service.dart';
import 'package:slovingo/services/firestore_progress_service.dart';
import 'package:slovingo/services/lesson_task_service.dart';

class AppProvider with ChangeNotifier {
  final FirestoreUserService _fsUserService = FirestoreUserService();
  final FirestoreProgressService _fsProgressService = FirestoreProgressService();
  final LevelService _levelService = LevelService();
  final WordService _wordService = WordService();
  final TranslationService _translationService = TranslationService();
  final ChatService _chatService = ChatService();
  final LessonTaskService _lessonTaskService = LessonTaskService();

  User? _currentUser;
  List<Level> _levels = [];
  List<Word> _words = [];
  Word? _wordOfDay;
  List<Translation> _translationHistory = [];
  List<ChatMessage> _chatMessages = [];
  bool _isLoading = false;
  bool _isChatLoading = false;
  bool _initializing = false;
  bool _initialized = false;
  ThemeMode _themeMode = ThemeMode.system;

  User? get currentUser => _currentUser;
  List<Level> get levels => _levels;
  List<Word> get words => _words;
  Word? get wordOfDay => _wordOfDay;
  List<Translation> get translationHistory => _translationHistory;
  List<ChatMessage> get chatMessages => _chatMessages;
  bool get isLoading => _isLoading;
  bool get isChatLoading => _isChatLoading;
  ThemeMode get themeMode => _themeMode;

  AppProvider() {
    _loadThemeMode();
  }

  Future<void> initialize() async {
    if (_initializing || _initialized) return;
    _initializing = true;
    _isLoading = true;
    notifyListeners();

    await DatabaseHelper.instance.database;
    await seedSample();

    final firebaseUser = fb_auth.FirebaseAuth.instance.currentUser;
    if (firebaseUser == null) {
      _isLoading = false;
      _initializing = false;
      notifyListeners();
      return;
    }

    _currentUser = await _fsUserService.getUser(firebaseUser.uid);

    if (_currentUser == null) {
      final now = DateTime.now();
      final newUser = User(
        id: firebaseUser.uid,
        name: firebaseUser.displayName ?? (firebaseUser.email ?? 'Ucenec'),
        email: firebaseUser.email ?? '',
        currentLevel: 1,
        totalPoints: 0,
        streak: 0,
        lastActive: now,
        createdAt: now,
        updatedAt: now,
      );
      await _fsUserService.upsertUser(newUser);
      _currentUser = newUser;
    } else if ((_currentUser!.name.isEmpty || _currentUser!.name == _currentUser!.email) &&
        (firebaseUser.displayName ?? '').isNotEmpty) {
      final updated = _currentUser!.copyWith(
        name: firebaseUser.displayName,
        updatedAt: DateTime.now(),
      );
      await _fsUserService.upsertUser(updated);
      _currentUser = updated;
    }

    _levels = await _levelService.getAllLevels();
    await _applyUserLocks();
    _words = await _wordService.getAllWords();
    _wordOfDay = await _wordService.getWordOfDay();
    _translationHistory = await _translationService.getHistory();

    if (_currentUser != null) {
      _chatMessages = await _chatService.getChatHistory(_currentUser!.id);
    }

    _isLoading = false;
    _initialized = true;
    _initializing = false;
    notifyListeners();
  }

  Future<void> updateUserProgress(int level, int points) async {
    if (_currentUser == null) return;
    final updated = _currentUser!.copyWith(
      currentLevel: level,
      totalPoints: _currentUser!.totalPoints + points,
      lastActive: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    await _fsUserService.upsertUser(updated);
    _currentUser = updated;
    notifyListeners();
  }

  Future<void> updateStreak() async {
    if (_currentUser == null) return;
    final now = DateTime.now();
    final lastActive = _currentUser!.lastActive;
    final difference = now.difference(lastActive).inDays;

    int newStreak = _currentUser!.streak;
    if (difference == 1) {
      newStreak++;
    } else if (difference > 1) {
      newStreak = 1;
    }

    final updatedUser = _currentUser!.copyWith(
      streak: newStreak,
      lastActive: now,
      updatedAt: now,
    );
    await _fsUserService.upsertUser(updatedUser);
    _currentUser = updatedUser;
    notifyListeners();
  }

  Future<List<Word>> getWordsByLevel(String levelId) async {
    return await _wordService.getWordsByLevel(levelId);
  }

  Future<List<LessonTask>> getTasksByLevel(String levelId) async {
    return await _lessonTaskService.getTasksByLevel(levelId);
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

    await _fsProgressService.saveProgress(progress);

    if (score >= 70) {
      await updateUserProgress(_currentUser!.currentLevel + 1, score);
    }

    await _applyUserLocks();
    notifyListeners();
  }

  Future<Map<String, dynamic>> getUserStatistics() async {
    if (_currentUser == null) return {};
    return await _fsProgressService.getStatistics(_currentUser!.id);
  }

  Future<Progress?> getLevelProgress(String levelId) async {
    if (_currentUser == null) return null;
    return await _fsProgressService.getProgressByLevel(_currentUser!.id, levelId);
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

    // ignore: unused_local_variable
    final response = await _chatService.sendMessage(_currentUser!.id, message);
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

  Future<void> _loadThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString('themeMode');
    if (saved != null) {
      _themeMode = ThemeMode.values.firstWhere(
        (m) => m.name == saved,
        orElse: () => ThemeMode.system,
      );
      notifyListeners();
    }
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    _themeMode = mode;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('themeMode', mode.name);
  }

  Future<void> toggleTheme() async {
    final nextMode = _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    await setThemeMode(nextMode);
  }

  Future<void> _applyUserLocks() async {
    if (_currentUser == null) return;
    final progressList = await _fsProgressService.getAllProgress(_currentUser!.id);
    final progressMap = {
      for (final p in progressList) p.levelId: p,
    };
    _levels = _levels.map((level) {
      if (level.levelNumber == 1) {
        return level.copyWith(isLocked: false);
      }
      final prev = _levels.where((l) => l.levelNumber == level.levelNumber - 1).toList();
      final prevLevel = prev.isNotEmpty ? prev.first : null;
      final prevCompleted = prevLevel != null && (progressMap[prevLevel.id]?.completed ?? false);
      return level.copyWith(isLocked: !prevCompleted);
    }).toList()
      ..sort((a, b) => a.levelNumber.compareTo(b.levelNumber));
    notifyListeners();
  }
}
