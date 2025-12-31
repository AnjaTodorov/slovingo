import 'dart:math';

import 'package:slovingo/models/word.dart';
import 'package:slovingo/services/database_helper.dart';

class WordService {
  Future<List<Word>> getAllWords() async {
    final db = await DatabaseHelper.instance.database;
    final rows = await db.query('words');
    return rows.map(Word.fromJson).toList();
  }

  Future<List<Word>> getWordsByLevel(String levelId) async {
    final db = await DatabaseHelper.instance.database;
    final rows = await db.query('words', where: 'levelId = ?', whereArgs: [levelId]);
    return rows.map(Word.fromJson).toList();
  }

  Future<Word?> getWordOfDay() async {
    final allWords = await getAllWords();
    if (allWords.isEmpty) return null;
    final today = DateTime.now();
    final rng = Random(today.year + today.month + today.day);
    return allWords[rng.nextInt(allWords.length)];
  }
}
