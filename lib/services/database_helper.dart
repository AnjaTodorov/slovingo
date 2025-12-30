import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('slovingo.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'TEXT PRIMARY KEY';
    const textType = 'TEXT NOT NULL';
    const integerType = 'INTEGER NOT NULL';

    await db.execute('''
      CREATE TABLE users (
        id $idType,
        name $textType,
        email $textType,
        currentLevel $integerType,
        totalPoints $integerType,
        streak $integerType,
        lastActive $textType,
        createdAt $textType,
        updatedAt $textType
      )
    ''');

    await db.execute('''
      CREATE TABLE words (
        id $idType,
        slovenian $textType,
        english $textType,
        example $textType,
        difficulty $integerType,
        levelId $textType,
        createdAt $textType,
        updatedAt $textType
      )
    ''');

    await db.execute('''
      CREATE TABLE levels (
        id $idType,
        levelNumber $integerType,
        title $textType,
        description $textType,
        isLocked $integerType,
        wordIds $textType,
        requiredScore $integerType,
        createdAt $textType,
        updatedAt $textType
      )
    ''');

    await db.execute('''
      CREATE TABLE quizzes (
        id $idType,
        levelId $textType,
        question $textType,
        options $textType,
        correctAnswer $textType,
        type $textType,
        createdAt $textType,
        updatedAt $textType
      )
    ''');

    await db.execute('''
      CREATE TABLE progress (
        id $idType,
        userId $textType,
        levelId $textType,
        score $integerType,
        completed $integerType,
        attempts $integerType,
        lastAttempt $textType,
        createdAt $textType,
        updatedAt $textType
      )
    ''');

    await db.execute('''
      CREATE TABLE translations (
        id $idType,
        sourceText $textType,
        translatedText $textType,
        sourceLang $textType,
        targetLang $textType,
        timestamp $textType
      )
    ''');

    await db.execute('''
      CREATE TABLE chat_messages (
        id $idType,
        userId $textType,
        message $textType,
        isUser $integerType,
        timestamp $textType,
        createdAt $textType
      )
    ''');
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
  
}
