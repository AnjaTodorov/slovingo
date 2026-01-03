import 'package:slovingo/models/level.dart';
import 'package:slovingo/services/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class LevelService {
  Future<List<Level>> getAllLevels() async {
    final db = await DatabaseHelper.instance.database;
    final rows = await db.query('levels', orderBy: 'levelNumber ASC');
    return rows.map(Level.fromJson).toList();
  }

  Future<Level?> getLevelById(String id) async {
    final db = await DatabaseHelper.instance.database;
    final rows = await db.query('levels', where: 'id = ?', whereArgs: [id], limit: 1);
    if (rows.isEmpty) return null;
    return Level.fromJson(rows.first);
  }

  Future<void> unlockLevel(String levelId) async {
    final db = await DatabaseHelper.instance.database;
    await db.update(
      'levels',
      {
        'isLocked': 0,
        'updatedAt': DateTime.now().toIso8601String(),
      },
      where: 'id = ?',
      whereArgs: [levelId],
    );
  }

  Future<void> updateLevels(List<Level> levels) async {
    final db = await DatabaseHelper.instance.database;
    final batch = db.batch();
    for (final level in levels) {
      batch.insert(
        'levels',
        level.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit(noResult: true);
  }
}
