import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:slovingo/models/level.dart';

class LevelService {
  static const String _levelsKey = 'levels_data';

  Future<void> _initSampleData() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(_levelsKey)) {
      final now = DateTime.now();
      final sampleLevels = [
        Level(
          id: 'level_1',
          levelNumber: 1,
          title: 'Osnovni pozdrav',
          description: 'Naučite se osnovne pozdrave in vljudnostne izraze',
          isLocked: false,
          wordIds: ['w1', 'w2', 'w3', 'w4', 'w5', 'w6', 'w7'],
          requiredScore: 70,
          createdAt: now,
          updatedAt: now,
        ),
        Level(
          id: 'level_2',
          levelNumber: 2,
          title: 'Družina',
          description: 'Besede o družinskih članih',
          isLocked: true,
          wordIds: ['w8', 'w9', 'w10', 'w11', 'w12', 'w13', 'w14'],
          requiredScore: 70,
          createdAt: now,
          updatedAt: now,
        ),
        Level(
          id: 'level_3',
          levelNumber: 3,
          title: 'Hrana in pijača',
          description: 'Besedišče za hrano in pijačo',
          isLocked: true,
          wordIds: ['w15', 'w16', 'w17', 'w18', 'w19', 'w20', 'w21'],
          requiredScore: 70,
          createdAt: now,
          updatedAt: now,
        ),
        Level(
          id: 'level_4',
          levelNumber: 4,
          title: 'Barve',
          description: 'Naučite se različne barve',
          isLocked: true,
          wordIds: ['w22', 'w23', 'w24', 'w25', 'w26', 'w27', 'w28'],
          requiredScore: 70,
          createdAt: now,
          updatedAt: now,
        ),
        Level(
          id: 'level_5',
          levelNumber: 5,
          title: 'Številke',
          description: 'Šteti v slovenščini',
          isLocked: true,
          wordIds: ['w29', 'w30', 'w31', 'w32', 'w33', 'w34', 'w35'],
          requiredScore: 70,
          createdAt: now,
          updatedAt: now,
        ),
        Level(
          id: 'level_6',
          levelNumber: 6,
          title: 'Vreme',
          description: 'Besede o vremenskih pojavih',
          isLocked: true,
          wordIds: ['w36', 'w37', 'w38', 'w39', 'w40', 'w41', 'w42'],
          requiredScore: 70,
          createdAt: now,
          updatedAt: now,
        ),
        Level(
          id: 'level_7',
          levelNumber: 7,
          title: 'Kraji',
          description: 'Imena krajev in lokacij',
          isLocked: true,
          wordIds: ['w43', 'w44', 'w45', 'w46', 'w47', 'w48', 'w49'],
          requiredScore: 70,
          createdAt: now,
          updatedAt: now,
        ),
        Level(
          id: 'level_8',
          levelNumber: 8,
          title: 'Čas',
          description: 'Besede o času in datumih',
          isLocked: true,
          wordIds: ['w50', 'w51', 'w52', 'w53', 'w54', 'w55', 'w56'],
          requiredScore: 70,
          createdAt: now,
          updatedAt: now,
        ),
        Level(
          id: 'level_9',
          levelNumber: 9,
          title: 'Občutki in dejanja',
          description: 'Glagoli in besede za občutke',
          isLocked: true,
          wordIds: ['w57', 'w58', 'w59', 'w60', 'w61', 'w62', 'w63'],
          requiredScore: 70,
          createdAt: now,
          updatedAt: now,
        ),
        Level(
          id: 'level_10',
          levelNumber: 10,
          title: 'Kultura in učenje',
          description: 'Napredno besedišče za kulturo',
          isLocked: true,
          wordIds: ['w64', 'w65', 'w66', 'w67', 'w68', 'w69', 'w70'],
          requiredScore: 70,
          createdAt: now,
          updatedAt: now,
        ),
      ];
      
      final levelsJson = sampleLevels.map((l) => l.toJson()).toList();
      await prefs.setString(_levelsKey, jsonEncode(levelsJson));
    }
  }

  Future<List<Level>> getAllLevels() async {
    await _initSampleData();
    final prefs = await SharedPreferences.getInstance();
    final levelsJson = prefs.getString(_levelsKey);
    if (levelsJson == null) return [];
    
    final List<dynamic> decoded = jsonDecode(levelsJson);
    return decoded.map((json) => Level.fromJson(json)).toList();
  }

  Future<Level?> getLevelById(String id) async {
    final levels = await getAllLevels();
    try {
      return levels.firstWhere((l) => l.id == id);
    } catch (e) {
      return null;
    }
  }

  Future<void> unlockLevel(String levelId) async {
    final levels = await getAllLevels();
    final updatedLevels = levels.map((level) {
      if (level.id == levelId) {
        return level.copyWith(isLocked: false);
      }
      return level;
    }).toList();
    
    final prefs = await SharedPreferences.getInstance();
    final levelsJson = updatedLevels.map((l) => l.toJson()).toList();
    await prefs.setString(_levelsKey, jsonEncode(levelsJson));
  }

  Future<void> updateLevels(List<Level> levels) async {
    final prefs = await SharedPreferences.getInstance();
    final levelsJson = levels.map((l) => l.toJson()).toList();
    await prefs.setString(_levelsKey, jsonEncode(levelsJson));
  }
}