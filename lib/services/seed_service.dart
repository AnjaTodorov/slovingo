import 'package:slovingo/services/database_helper.dart';
import 'package:sqflite/sqflite.dart';

Future<void> seedSample() async {
  final db = await DatabaseHelper.instance.database;

  // only seed if empty
  final existing = await db.query('users', limit: 1);
  if (existing.isNotEmpty) return;

  final now = DateTime.now().toIso8601String();

  await db.insert('users', {
    'id': 'user_1',
    'name': 'Test User',
    'email': 'test@example.com',
    'currentLevel': 1,
    'totalPoints': 0,
    'streak': 0,
    'lastActive': now,
    'createdAt': now,
    'updatedAt': now,
  }, conflictAlgorithm: ConflictAlgorithm.replace);

  final levels = [
    {
      'id': 'level_1',
      'levelNumber': 1,
      'title': 'Greetings',
      'description': 'Basic greetings and politeness',
      'isLocked': 0,
      'wordIds': 'w1,w2,w3,w4',
      'requiredScore': 70,
      'createdAt': now,
      'updatedAt': now,
    },
    {
      'id': 'level_2',
      'levelNumber': 2,
      'title': 'Family',
      'description': 'Family members vocabulary',
      'isLocked': 1,
      'wordIds': 'w5,w6,w7,w8',
      'requiredScore': 70,
      'createdAt': now,
      'updatedAt': now,
    },
  ];

  for (final level in levels) {
    await db.insert('levels', level, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  final words = [
    // Level 1
    {
      'id': 'w1',
      'slovenian': 'Zivjo',
      'english': 'Hello',
      'example': 'Zivjo, kako si?',
      'difficulty': 1,
      'levelId': 'level_1',
      'createdAt': now,
      'updatedAt': now,
    },
    {
      'id': 'w2',
      'slovenian': 'Hvala',
      'english': 'Thank you',
      'example': 'Hvala za pomoc.',
      'difficulty': 1,
      'levelId': 'level_1',
      'createdAt': now,
      'updatedAt': now,
    },
    {
      'id': 'w3',
      'slovenian': 'Prosim',
      'english': 'Please / You are welcome',
      'example': 'Prosim, vstopite.',
      'difficulty': 1,
      'levelId': 'level_1',
      'createdAt': now,
      'updatedAt': now,
    },
    {
      'id': 'w4',
      'slovenian': 'Nasvidenje',
      'english': 'Goodbye',
      'example': 'Nasvidenje, se vidimo jutri.',
      'difficulty': 1,
      'levelId': 'level_1',
      'createdAt': now,
      'updatedAt': now,
    },
    // Level 2
    {
      'id': 'w5',
      'slovenian': 'Mama',
      'english': 'Mom',
      'example': 'Moja mama kuha vecerjo.',
      'difficulty': 1,
      'levelId': 'level_2',
      'createdAt': now,
      'updatedAt': now,
    },
    {
      'id': 'w6',
      'slovenian': 'Oce',
      'english': 'Father',
      'example': 'Moj oce je ucitelj.',
      'difficulty': 1,
      'levelId': 'level_2',
      'createdAt': now,
      'updatedAt': now,
    },
    {
      'id': 'w7',
      'slovenian': 'Brat',
      'english': 'Brother',
      'example': 'Imam mlajsega brata.',
      'difficulty': 1,
      'levelId': 'level_2',
      'createdAt': now,
      'updatedAt': now,
    },
    {
      'id': 'w8',
      'slovenian': 'Sestra',
      'english': 'Sister',
      'example': 'Moja sestra je zdravnica.',
      'difficulty': 1,
      'levelId': 'level_2',
      'createdAt': now,
      'updatedAt': now,
    },
  ];

  for (final word in words) {
    await db.insert('words', word, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  final quizzes = [
    {
      'id': 'q1',
      'levelId': 'level_1',
      'question': 'How do you say Hello in Slovene?',
      'options': 'Zivjo;Nasvidenje;Hvala;Prosim',
      'correctAnswer': 'Zivjo',
      'type': 'multipleChoice',
      'createdAt': now,
      'updatedAt': now,
    },
    {
      'id': 'q2',
      'levelId': 'level_1',
      'question': 'Translate: Thank you',
      'options': 'Prosim;Hvala;Zivjo;Ne',
      'correctAnswer': 'Hvala',
      'type': 'translate',
      'createdAt': now,
      'updatedAt': now,
    },
    {
      'id': 'q3',
      'levelId': 'level_2',
      'question': 'Moja ___ je prijazna (My mom is kind)',
      'options': 'mama;sestra;babica;teta',
      'correctAnswer': 'mama',
      'type': 'fillBlank',
      'createdAt': now,
      'updatedAt': now,
    },
  ];

  for (final quiz in quizzes) {
    await db.insert('quizzes', quiz, conflictAlgorithm: ConflictAlgorithm.replace);
  }
}
