import 'package:sqflite/sqflite.dart';
import 'package:slovingo/services/database_helper.dart';

/// Seeds static content (levels/words/tasks) inside a single transaction.
Future<void> seedSample() async {
  final db = await DatabaseHelper.instance.database;

  await db.transaction((txn) async {
    final now = DateTime.now().toIso8601String();

    // Always reset static tables to ensure fresh data.
    await txn.delete('levels');
    await txn.delete('words');
    await txn.delete('lesson_tasks');

    final levels = [
      // Starter (1 lesson)
      {
        'id': 'starter_1',
        'levelNumber': 1,
        'title': 'Everyday basics',
        'description': 'Starter',
        'levelCategory': 'lesson',
        'isLocked': 0,
        'wordIds': 'w1,w2,w3,w4,w5,w6,w7,w8',
        'requiredScore': 70,
        'createdAt': now,
        'updatedAt': now,
      },
      // Beginner (3 lessons + 1 quiz)
      {
        'id': 'beginner_1',
        'levelNumber': 2,
        'title': 'Greetings & phrases',
        'description': 'Beginner',
        'levelCategory': 'lesson',
        'isLocked': 1,
        'wordIds': 'w9,w10,w11,w12,w13,w14,w15,w16',
        'requiredScore': 70,
        'createdAt': now,
        'updatedAt': now,
      },
      {
        'id': 'beginner_2',
        'levelNumber': 3,
        'title': 'People & family',
        'description': 'Beginner',
        'levelCategory': 'lesson',
        'isLocked': 1,
        'wordIds': 'w17,w18,w19,w20,w21,w22,w23,w24',
        'requiredScore': 70,
        'createdAt': now,
        'updatedAt': now,
      },
      {
        'id': 'beginner_3',
        'levelNumber': 4,
        'title': 'Food & drink',
        'description': 'Beginner',
        'levelCategory': 'lesson',
        'isLocked': 1,
        'wordIds': 'w25,w26,w27,w28,w29,w30,w31,w32',
        'requiredScore': 70,
        'createdAt': now,
        'updatedAt': now,
      },
      {
        'id': 'beginner_quiz',
        'levelNumber': 5,
        'title': 'Beginner Quiz',
        'description': 'Beginner',
        'levelCategory': 'quiz',
        'isLocked': 1,
        'wordIds': '',
        'requiredScore': 70,
        'createdAt': now,
        'updatedAt': now,
      },
      // Intermediate (3 lessons + 1 quiz)
      {
        'id': 'intermediate_1',
        'levelNumber': 6,
        'title': 'Numbers & Time',
        'description': 'Intermediate',
        'levelCategory': 'lesson',
        'isLocked': 1,
        'wordIds': 'w33,w34,w35,w36,w37,w38,w39,w40',
        'requiredScore': 70,
        'createdAt': now,
        'updatedAt': now,
      },
      {
        'id': 'intermediate_2',
        'levelNumber': 7,
        'title': 'Colors & Adjectives',
        'description': 'Intermediate',
        'levelCategory': 'lesson',
        'isLocked': 1,
        'wordIds': 'w41,w42,w43,w44,w45,w46,w47,w48',
        'requiredScore': 70,
        'createdAt': now,
        'updatedAt': now,
      },
      {
        'id': 'intermediate_3',
        'levelNumber': 8,
        'title': 'Places & Directions',
        'description': 'Intermediate',
        'levelCategory': 'lesson',
        'isLocked': 1,
        'wordIds': 'w49,w50,w51,w52,w53,w54,w55,w56',
        'requiredScore': 70,
        'createdAt': now,
        'updatedAt': now,
      },
      {
        'id': 'intermediate_quiz',
        'levelNumber': 9,
        'title': 'Intermediate Quiz',
        'description': 'Intermediate',
        'levelCategory': 'quiz',
        'isLocked': 1,
        'wordIds': '',
        'requiredScore': 70,
        'createdAt': now,
        'updatedAt': now,
      },
      // Upper Intermediate (3 lessons + 1 quiz)
      {
        'id': 'upper_1',
        'levelNumber': 10,
        'title': 'Verbs & Actions',
        'description': 'Upper Intermediate',
        'levelCategory': 'lesson',
        'isLocked': 1,
        'wordIds': 'w57,w58,w59,w60,w61,w62,w63,w64',
        'requiredScore': 70,
        'createdAt': now,
        'updatedAt': now,
      },
      {
        'id': 'upper_2',
        'levelNumber': 11,
        'title': 'Weather & Nature',
        'description': 'Upper Intermediate',
        'levelCategory': 'lesson',
        'isLocked': 1,
        'wordIds': 'w65,w66,w67,w68,w69,w70,w71,w72',
        'requiredScore': 70,
        'createdAt': now,
        'updatedAt': now,
      },
      {
        'id': 'upper_3',
        'levelNumber': 12,
        'title': 'Work & Hobbies',
        'description': 'Upper Intermediate',
        'levelCategory': 'lesson',
        'isLocked': 1,
        'wordIds': 'w73,w74,w75,w76,w77,w78,w79,w80',
        'requiredScore': 70,
        'createdAt': now,
        'updatedAt': now,
      },
      {
        'id': 'upper_quiz',
        'levelNumber': 13,
        'title': 'Upper Intermediate Quiz',
        'description': 'Upper Intermediate',
        'levelCategory': 'quiz',
        'isLocked': 1,
        'wordIds': '',
        'requiredScore': 70,
        'createdAt': now,
        'updatedAt': now,
      },
      // Advanced (3 lessons + 1 quiz)
      {
        'id': 'advanced_1',
        'levelNumber': 14,
        'title': 'Advanced Grammar',
        'description': 'Advanced',
        'levelCategory': 'lesson',
        'isLocked': 1,
        'wordIds': 'w81,w82,w83,w84,w85,w86,w87,w88',
        'requiredScore': 70,
        'createdAt': now,
        'updatedAt': now,
      },
      {
        'id': 'advanced_2',
        'levelNumber': 15,
        'title': 'Culture & Society',
        'description': 'Advanced',
        'levelCategory': 'lesson',
        'isLocked': 1,
        'wordIds': 'w89,w90,w91,w92,w93,w94,w95,w96',
        'requiredScore': 70,
        'createdAt': now,
        'updatedAt': now,
      },
      {
        'id': 'advanced_3',
        'levelNumber': 16,
        'title': 'Business & Formal',
        'description': 'Advanced',
        'levelCategory': 'lesson',
        'isLocked': 1,
        'wordIds': 'w97,w98,w99,w100,w101,w102,w103,w104',
        'requiredScore': 70,
        'createdAt': now,
        'updatedAt': now,
      },
      {
        'id': 'advanced_quiz',
        'levelNumber': 17,
        'title': 'Advanced Quiz',
        'description': 'Advanced',
        'levelCategory': 'quiz',
        'isLocked': 1,
        'wordIds': '',
        'requiredScore': 70,
        'createdAt': now,
        'updatedAt': now,
      },
      // Expert (3 lessons + 1 quiz)
      {
        'id': 'expert_1',
        'levelNumber': 18,
        'title': 'Expert Vocabulary',
        'description': 'Expert',
        'levelCategory': 'lesson',
        'isLocked': 1,
        'wordIds': 'w105,w106,w107,w108,w109,w110,w111,w112',
        'requiredScore': 70,
        'createdAt': now,
        'updatedAt': now,
      },
      {
        'id': 'expert_2',
        'levelNumber': 19,
        'title': 'Literature & Arts',
        'description': 'Expert',
        'levelCategory': 'lesson',
        'isLocked': 1,
        'wordIds': 'w113,w114,w115,w116,w117,w118,w119,w120',
        'requiredScore': 70,
        'createdAt': now,
        'updatedAt': now,
      },
      {
        'id': 'expert_3',
        'levelNumber': 20,
        'title': 'Academic & Scientific',
        'description': 'Expert',
        'levelCategory': 'lesson',
        'isLocked': 1,
        'wordIds': 'w121,w122,w123,w124,w125,w126,w127,w128',
        'requiredScore': 70,
        'createdAt': now,
        'updatedAt': now,
      },
      {
        'id': 'expert_quiz',
        'levelNumber': 21,
        'title': 'Expert Quiz',
        'description': 'Expert',
        'levelCategory': 'quiz',
        'isLocked': 1,
        'wordIds': '',
        'requiredScore': 70,
        'createdAt': now,
        'updatedAt': now,
      },
    ];

    final words = [
      // Starter (8 words)
      {'id': 'w1', 'slovenian': 'Živjo', 'english': 'Hello', 'example': 'Živjo, kako si?', 'difficulty': 1, 'levelId': 'starter_1', 'createdAt': now, 'updatedAt': now},
      {'id': 'w2', 'slovenian': 'Hvala', 'english': 'Thank you', 'example': 'Hvala za pomoč', 'difficulty': 1, 'levelId': 'starter_1', 'createdAt': now, 'updatedAt': now},
      {'id': 'w3', 'slovenian': 'Prosim', 'english': 'Please / You are welcome', 'example': 'Prosim, vstopite.', 'difficulty': 1, 'levelId': 'starter_1', 'createdAt': now, 'updatedAt': now},
      {'id': 'w4', 'slovenian': 'Ja', 'english': 'Yes', 'example': 'Ja, se strinjam.', 'difficulty': 1, 'levelId': 'starter_1', 'createdAt': now, 'updatedAt': now},
      {'id': 'w5', 'slovenian': 'Ne', 'english': 'No', 'example': 'Ne, hvala.', 'difficulty': 1, 'levelId': 'starter_1', 'createdAt': now, 'updatedAt': now},
      {'id': 'w6', 'slovenian': 'Oprostite', 'english': 'Excuse me / Sorry', 'example': 'Oprostite, kje je postaja?', 'difficulty': 1, 'levelId': 'starter_1', 'createdAt': now, 'updatedAt': now},
      {'id': 'w7', 'slovenian': 'Dobrodošli', 'english': 'Welcome', 'example': 'Dobrodošli v Sloveniji!', 'difficulty': 1, 'levelId': 'starter_1', 'createdAt': now, 'updatedAt': now},
      {'id': 'w8', 'slovenian': 'Nasvidenje', 'english': 'Goodbye', 'example': 'Nasvidenje, se vidimo jutri.', 'difficulty': 1, 'levelId': 'starter_1', 'createdAt': now, 'updatedAt': now},
      // Beginner 1 - Greetings (8 words)
      {'id': 'w9', 'slovenian': 'Dobro jutro', 'english': 'Good morning', 'example': 'Dobro jutro vsem.', 'difficulty': 2, 'levelId': 'beginner_1', 'createdAt': now, 'updatedAt': now},
      {'id': 'w10', 'slovenian': 'Dober dan', 'english': 'Good day', 'example': 'Dober dan, gospod.', 'difficulty': 2, 'levelId': 'beginner_1', 'createdAt': now, 'updatedAt': now},
      {'id': 'w11', 'slovenian': 'Dober večer', 'english': 'Good evening', 'example': 'Dober večer, kako ste?', 'difficulty': 2, 'levelId': 'beginner_1', 'createdAt': now, 'updatedAt': now},
      {'id': 'w12', 'slovenian': 'Lahko noč', 'english': 'Good night', 'example': 'Lahko noč, nasvidenje.', 'difficulty': 2, 'levelId': 'beginner_1', 'createdAt': now, 'updatedAt': now},
      {'id': 'w13', 'slovenian': 'Kako si?', 'english': 'How are you?', 'example': 'Hej, kako si danes?', 'difficulty': 2, 'levelId': 'beginner_1', 'createdAt': now, 'updatedAt': now},
      {'id': 'w14', 'slovenian': 'Dobro', 'english': 'Good / Well', 'example': 'Vse je dobro.', 'difficulty': 2, 'levelId': 'beginner_1', 'createdAt': now, 'updatedAt': now},
      {'id': 'w15', 'slovenian': 'Kako vam je ime?', 'english': 'What is your name?', 'example': 'Kako vam je ime?', 'difficulty': 2, 'levelId': 'beginner_1', 'createdAt': now, 'updatedAt': now},
      {'id': 'w16', 'slovenian': 'Pozdravljeni', 'english': 'Greetings', 'example': 'Pozdravljeni, prijetno.', 'difficulty': 2, 'levelId': 'beginner_1', 'createdAt': now, 'updatedAt': now},
      // Beginner 2 - People & Family (8 words)
      {'id': 'w17', 'slovenian': 'Mama', 'english': 'Mom', 'example': 'Moja mama kuha večerjo.', 'difficulty': 2, 'levelId': 'beginner_2', 'createdAt': now, 'updatedAt': now},
      {'id': 'w18', 'slovenian': 'Oče', 'english': 'Father', 'example': 'Moj oče je učitelj.', 'difficulty': 2, 'levelId': 'beginner_2', 'createdAt': now, 'updatedAt': now},
      {'id': 'w19', 'slovenian': 'Brat', 'english': 'Brother', 'example': 'Imam mlajšega brata.', 'difficulty': 2, 'levelId': 'beginner_2', 'createdAt': now, 'updatedAt': now},
      {'id': 'w20', 'slovenian': 'Sestra', 'english': 'Sister', 'example': 'Moja sestra je stara 20 let.', 'difficulty': 2, 'levelId': 'beginner_2', 'createdAt': now, 'updatedAt': now},
      {'id': 'w21', 'slovenian': 'Prijatelj', 'english': 'Friend', 'example': 'On je moj prijatelj.', 'difficulty': 2, 'levelId': 'beginner_2', 'createdAt': now, 'updatedAt': now},
      {'id': 'w22', 'slovenian': 'Dekle', 'english': 'Girl', 'example': 'To dekle je prijazno.', 'difficulty': 2, 'levelId': 'beginner_2', 'createdAt': now, 'updatedAt': now},
      {'id': 'w23', 'slovenian': 'Fant', 'english': 'Boy', 'example': 'Fant je šel v šolo.', 'difficulty': 2, 'levelId': 'beginner_2', 'createdAt': now, 'updatedAt': now},
      {'id': 'w24', 'slovenian': 'Človek', 'english': 'Person', 'example': 'Vsak človek je pomemben.', 'difficulty': 2, 'levelId': 'beginner_2', 'createdAt': now, 'updatedAt': now},
      // Beginner 3 - Food & Drink (8 words)
      {'id': 'w25', 'slovenian': 'Kruh', 'english': 'Bread', 'example': 'Kruh je svež.', 'difficulty': 2, 'levelId': 'beginner_3', 'createdAt': now, 'updatedAt': now},
      {'id': 'w26', 'slovenian': 'Mleko', 'english': 'Milk', 'example': 'Pijem mleko vsak dan.', 'difficulty': 2, 'levelId': 'beginner_3', 'createdAt': now, 'updatedAt': now},
      {'id': 'w27', 'slovenian': 'Čaj', 'english': 'Tea', 'example': 'Rad imam topel čaj.', 'difficulty': 2, 'levelId': 'beginner_3', 'createdAt': now, 'updatedAt': now},
      {'id': 'w28', 'slovenian': 'Kava', 'english': 'Coffee', 'example': 'Dva kavčeka, prosim.', 'difficulty': 2, 'levelId': 'beginner_3', 'createdAt': now, 'updatedAt': now},
      {'id': 'w29', 'slovenian': 'Voda', 'english': 'Water', 'example': 'Daj mi vodo, prosim.', 'difficulty': 2, 'levelId': 'beginner_3', 'createdAt': now, 'updatedAt': now},
      {'id': 'w30', 'slovenian': 'Jabolko', 'english': 'Apple', 'example': 'To jabolko je sladko.', 'difficulty': 2, 'levelId': 'beginner_3', 'createdAt': now, 'updatedAt': now},
      {'id': 'w31', 'slovenian': 'Sladkor', 'english': 'Sugar', 'example': 'Prosim, manj sladkorja.', 'difficulty': 2, 'levelId': 'beginner_3', 'createdAt': now, 'updatedAt': now},
      {'id': 'w32', 'slovenian': 'Sok', 'english': 'Juice', 'example': 'Rad imam pomarančni sok.', 'difficulty': 2, 'levelId': 'beginner_3', 'createdAt': now, 'updatedAt': now},
      // Intermediate - Numbers & Time (8 words) - placeholder content
      {'id': 'w33', 'slovenian': 'Ena', 'english': 'One', 'example': 'Ena, dva, tri.', 'difficulty': 3, 'levelId': 'intermediate_1', 'createdAt': now, 'updatedAt': now},
      {'id': 'w34', 'slovenian': 'Dva', 'english': 'Two', 'example': 'Imam dva avta.', 'difficulty': 3, 'levelId': 'intermediate_1', 'createdAt': now, 'updatedAt': now},
      {'id': 'w35', 'slovenian': 'Tri', 'english': 'Three', 'example': 'Trije prijatelji.', 'difficulty': 3, 'levelId': 'intermediate_1', 'createdAt': now, 'updatedAt': now},
      {'id': 'w36', 'slovenian': 'Ura', 'english': 'Hour / Clock', 'example': 'Koliko je ura?', 'difficulty': 3, 'levelId': 'intermediate_1', 'createdAt': now, 'updatedAt': now},
      {'id': 'w37', 'slovenian': 'Dan', 'english': 'Day', 'example': 'Dober dan!', 'difficulty': 3, 'levelId': 'intermediate_1', 'createdAt': now, 'updatedAt': now},
      {'id': 'w38', 'slovenian': 'Tedenski', 'english': 'Week', 'example': 'Vsak teden.', 'difficulty': 3, 'levelId': 'intermediate_1', 'createdAt': now, 'updatedAt': now},
      {'id': 'w39', 'slovenian': 'Mesec', 'english': 'Month', 'example': 'Ta mesec je januar.', 'difficulty': 3, 'levelId': 'intermediate_1', 'createdAt': now, 'updatedAt': now},
      {'id': 'w40', 'slovenian': 'Leto', 'english': 'Year', 'example': 'To leto bo dobro.', 'difficulty': 3, 'levelId': 'intermediate_1', 'createdAt': now, 'updatedAt': now},
      // Intermediate - Colors & Adjectives (8 words) - placeholder
      {'id': 'w41', 'slovenian': 'Rdeča', 'english': 'Red', 'example': 'Rdeča vrtnica.', 'difficulty': 3, 'levelId': 'intermediate_2', 'createdAt': now, 'updatedAt': now},
      {'id': 'w42', 'slovenian': 'Modra', 'english': 'Blue', 'example': 'Modro nebo.', 'difficulty': 3, 'levelId': 'intermediate_2', 'createdAt': now, 'updatedAt': now},
      {'id': 'w43', 'slovenian': 'Zelena', 'english': 'Green', 'example': 'Zelena trava.', 'difficulty': 3, 'levelId': 'intermediate_2', 'createdAt': now, 'updatedAt': now},
      {'id': 'w44', 'slovenian': 'Velik', 'english': 'Big', 'example': 'Velika hiša.', 'difficulty': 3, 'levelId': 'intermediate_2', 'createdAt': now, 'updatedAt': now},
      {'id': 'w45', 'slovenian': 'Majhen', 'english': 'Small', 'example': 'Majhna sobica.', 'difficulty': 3, 'levelId': 'intermediate_2', 'createdAt': now, 'updatedAt': now},
      {'id': 'w46', 'slovenian': 'Lep', 'english': 'Beautiful', 'example': 'Lepa pesem.', 'difficulty': 3, 'levelId': 'intermediate_2', 'createdAt': now, 'updatedAt': now},
      {'id': 'w47', 'slovenian': 'Dober', 'english': 'Good', 'example': 'Dober dan!', 'difficulty': 3, 'levelId': 'intermediate_2', 'createdAt': now, 'updatedAt': now},
      {'id': 'w48', 'slovenian': 'Nov', 'english': 'New', 'example': 'Nov avto.', 'difficulty': 3, 'levelId': 'intermediate_2', 'createdAt': now, 'updatedAt': now},
      // Intermediate - Places & Directions (8 words) - placeholder
      {'id': 'w49', 'slovenian': 'Hiša', 'english': 'House', 'example': 'Velika hiša.', 'difficulty': 3, 'levelId': 'intermediate_3', 'createdAt': now, 'updatedAt': now},
      {'id': 'w50', 'slovenian': 'Mesto', 'english': 'City', 'example': 'Veliko mesto.', 'difficulty': 3, 'levelId': 'intermediate_3', 'createdAt': now, 'updatedAt': now},
      {'id': 'w51', 'slovenian': 'Cesta', 'english': 'Street', 'example': 'Glavna cesta.', 'difficulty': 3, 'levelId': 'intermediate_3', 'createdAt': now, 'updatedAt': now},
      {'id': 'w52', 'slovenian': 'Levo', 'english': 'Left', 'example': 'Zavij levo.', 'difficulty': 3, 'levelId': 'intermediate_3', 'createdAt': now, 'updatedAt': now},
      {'id': 'w53', 'slovenian': 'Desno', 'english': 'Right', 'example': 'Zavij desno.', 'difficulty': 3, 'levelId': 'intermediate_3', 'createdAt': now, 'updatedAt': now},
      {'id': 'w54', 'slovenian': 'Neposredno', 'english': 'Straight', 'example': 'Pojdi neposredno naprej.', 'difficulty': 3, 'levelId': 'intermediate_3', 'createdAt': now, 'updatedAt': now},
      {'id': 'w55', 'slovenian': 'Daleč', 'english': 'Far', 'example': 'To je daleč.', 'difficulty': 3, 'levelId': 'intermediate_3', 'createdAt': now, 'updatedAt': now},
      {'id': 'w56', 'slovenian': 'Blizu', 'english': 'Near', 'example': 'Blizu sem.', 'difficulty': 3, 'levelId': 'intermediate_3', 'createdAt': now, 'updatedAt': now},
      // Upper Intermediate - Verbs & Actions (8 words) - placeholder
      {'id': 'w57', 'slovenian': 'Hoditi', 'english': 'To walk', 'example': 'Hodim na sprehod.', 'difficulty': 4, 'levelId': 'upper_1', 'createdAt': now, 'updatedAt': now},
      {'id': 'w58', 'slovenian': 'Brati', 'english': 'To read', 'example': 'Rad berem knjige.', 'difficulty': 4, 'levelId': 'upper_1', 'createdAt': now, 'updatedAt': now},
      {'id': 'w59', 'slovenian': 'Pisati', 'english': 'To write', 'example': 'Pišem pismo.', 'difficulty': 4, 'levelId': 'upper_1', 'createdAt': now, 'updatedAt': now},
      {'id': 'w60', 'slovenian': 'Govoriti', 'english': 'To speak', 'example': 'Govorim slovenščino.', 'difficulty': 4, 'levelId': 'upper_1', 'createdAt': now, 'updatedAt': now},
      {'id': 'w61', 'slovenian': 'Videti', 'english': 'To see', 'example': 'Vidim vas.', 'difficulty': 4, 'levelId': 'upper_1', 'createdAt': now, 'updatedAt': now},
      {'id': 'w62', 'slovenian': 'Slišati', 'english': 'To hear', 'example': 'Slišim glasbo.', 'difficulty': 4, 'levelId': 'upper_1', 'createdAt': now, 'updatedAt': now},
      {'id': 'w63', 'slovenian': 'Kuhati', 'english': 'To cook', 'example': 'Kuham večerjo.', 'difficulty': 4, 'levelId': 'upper_1', 'createdAt': now, 'updatedAt': now},
      {'id': 'w64', 'slovenian': 'Učiti', 'english': 'To learn', 'example': 'Učim se slovenščino.', 'difficulty': 4, 'levelId': 'upper_1', 'createdAt': now, 'updatedAt': now},
      // Upper Intermediate - Weather & Nature (8 words) - placeholder
      {'id': 'w65', 'slovenian': 'Vreme', 'english': 'Weather', 'example': 'Kako je vreme?', 'difficulty': 4, 'levelId': 'upper_2', 'createdAt': now, 'updatedAt': now},
      {'id': 'w66', 'slovenian': 'Sonce', 'english': 'Sun', 'example': 'Sonce sije.', 'difficulty': 4, 'levelId': 'upper_2', 'createdAt': now, 'updatedAt': now},
      {'id': 'w67', 'slovenian': 'Dež', 'english': 'Rain', 'example': 'Danes dežuje.', 'difficulty': 4, 'levelId': 'upper_2', 'createdAt': now, 'updatedAt': now},
      {'id': 'w68', 'slovenian': 'Sneg', 'english': 'Snow', 'example': 'Pada sneg.', 'difficulty': 4, 'levelId': 'upper_2', 'createdAt': now, 'updatedAt': now},
      {'id': 'w69', 'slovenian': 'Drevo', 'english': 'Tree', 'example': 'Veliko drevo.', 'difficulty': 4, 'levelId': 'upper_2', 'createdAt': now, 'updatedAt': now},
      {'id': 'w70', 'slovenian': 'Cvet', 'english': 'Flower', 'example': 'Lep cvet.', 'difficulty': 4, 'levelId': 'upper_2', 'createdAt': now, 'updatedAt': now},
      {'id': 'w71', 'slovenian': 'Gora', 'english': 'Mountain', 'example': 'Visoka gora.', 'difficulty': 4, 'levelId': 'upper_2', 'createdAt': now, 'updatedAt': now},
      {'id': 'w72', 'slovenian': 'Reka', 'english': 'River', 'example': 'Hitra reka.', 'difficulty': 4, 'levelId': 'upper_2', 'createdAt': now, 'updatedAt': now},
      // Upper Intermediate - Work & Hobbies (8 words) - placeholder
      {'id': 'w73', 'slovenian': 'Delo', 'english': 'Work', 'example': 'Grem na delo.', 'difficulty': 4, 'levelId': 'upper_3', 'createdAt': now, 'updatedAt': now},
      {'id': 'w74', 'slovenian': 'Šola', 'english': 'School', 'example': 'Hodim v šolo.', 'difficulty': 4, 'levelId': 'upper_3', 'createdAt': now, 'updatedAt': now},
      {'id': 'w75', 'slovenian': 'Učitelj', 'english': 'Teacher', 'example': 'Dober učitelj.', 'difficulty': 4, 'levelId': 'upper_3', 'createdAt': now, 'updatedAt': now},
      {'id': 'w76', 'slovenian': 'Študent', 'english': 'Student', 'example': 'Sem študent.', 'difficulty': 4, 'levelId': 'upper_3', 'createdAt': now, 'updatedAt': now},
      {'id': 'w77', 'slovenian': 'Hobi', 'english': 'Hobby', 'example': 'Kaj je tvoj hobi?', 'difficulty': 4, 'levelId': 'upper_3', 'createdAt': now, 'updatedAt': now},
      {'id': 'w78', 'slovenian': 'Šport', 'english': 'Sport', 'example': 'Rad imam šport.', 'difficulty': 4, 'levelId': 'upper_3', 'createdAt': now, 'updatedAt': now},
      {'id': 'w79', 'slovenian': 'Muzika', 'english': 'Music', 'example': 'Poslušam muziko.', 'difficulty': 4, 'levelId': 'upper_3', 'createdAt': now, 'updatedAt': now},
      {'id': 'w80', 'slovenian': 'Knjiga', 'english': 'Book', 'example': 'Berem knjigo.', 'difficulty': 4, 'levelId': 'upper_3', 'createdAt': now, 'updatedAt': now},
      // Advanced - Grammar (8 words) - placeholder
      {'id': 'w81', 'slovenian': 'Čeprav', 'english': 'Although', 'example': 'Čeprav je dež, grem ven.', 'difficulty': 5, 'levelId': 'advanced_1', 'createdAt': now, 'updatedAt': now},
      {'id': 'w82', 'slovenian': 'Zato', 'english': 'Therefore', 'example': 'Zato sem tu.', 'difficulty': 5, 'levelId': 'advanced_1', 'createdAt': now, 'updatedAt': now},
      {'id': 'w83', 'slovenian': 'Vendar', 'english': 'However', 'example': 'Vendar je težko.', 'difficulty': 5, 'levelId': 'advanced_1', 'createdAt': now, 'updatedAt': now},
      {'id': 'w84', 'slovenian': 'Kakorkoli', 'english': 'Anyway', 'example': 'Kakorkoli, nadaljujmo.', 'difficulty': 5, 'levelId': 'advanced_1', 'createdAt': now, 'updatedAt': now},
      {'id': 'w85', 'slovenian': 'Posledično', 'english': 'Consequently', 'example': 'Posledično je uspelo.', 'difficulty': 5, 'levelId': 'advanced_1', 'createdAt': now, 'updatedAt': now},
      {'id': 'w86', 'slovenian': 'Poleg tega', 'english': 'Besides', 'example': 'Poleg tega je dobro.', 'difficulty': 5, 'levelId': 'advanced_1', 'createdAt': now, 'updatedAt': now},
      {'id': 'w87', 'slovenian': 'Nasprotno', 'english': 'On the contrary', 'example': 'Nasprotno, je dobro.', 'difficulty': 5, 'levelId': 'advanced_1', 'createdAt': now, 'updatedAt': now},
      {'id': 'w88', 'slovenian': 'Vsekakor', 'english': 'Certainly', 'example': 'Vsekakor, to je res.', 'difficulty': 5, 'levelId': 'advanced_1', 'createdAt': now, 'updatedAt': now},
      // Advanced - Culture & Society (8 words) - placeholder
      {'id': 'w89', 'slovenian': 'Kultura', 'english': 'Culture', 'example': 'Slovenska kultura.', 'difficulty': 5, 'levelId': 'advanced_2', 'createdAt': now, 'updatedAt': now},
      {'id': 'w90', 'slovenian': 'Družba', 'english': 'Society', 'example': 'Sodobna družba.', 'difficulty': 5, 'levelId': 'advanced_2', 'createdAt': now, 'updatedAt': now},
      {'id': 'w91', 'slovenian': 'Tradicija', 'english': 'Tradition', 'example': 'Stara tradicija.', 'difficulty': 5, 'levelId': 'advanced_2', 'createdAt': now, 'updatedAt': now},
      {'id': 'w92', 'slovenian': 'Zgodovina', 'english': 'History', 'example': 'Zgodovina Slovenije.', 'difficulty': 5, 'levelId': 'advanced_2', 'createdAt': now, 'updatedAt': now},
      {'id': 'w93', 'slovenian': 'Vlada', 'english': 'Government', 'example': 'Slovenska vlada.', 'difficulty': 5, 'levelId': 'advanced_2', 'createdAt': now, 'updatedAt': now},
      {'id': 'w94', 'slovenian': 'Pravica', 'english': 'Right', 'example': 'Človekove pravice.', 'difficulty': 5, 'levelId': 'advanced_2', 'createdAt': now, 'updatedAt': now},
      {'id': 'w95', 'slovenian': 'Svoboda', 'english': 'Freedom', 'example': 'Svoboda govora.', 'difficulty': 5, 'levelId': 'advanced_2', 'createdAt': now, 'updatedAt': now},
      {'id': 'w96', 'slovenian': 'Demokracija', 'english': 'Democracy', 'example': 'Demokracija deluje.', 'difficulty': 5, 'levelId': 'advanced_2', 'createdAt': now, 'updatedAt': now},
      // Advanced - Business & Formal (8 words) - placeholder
      {'id': 'w97', 'slovenian': 'Posel', 'english': 'Business', 'example': 'Dobro za posel.', 'difficulty': 5, 'levelId': 'advanced_3', 'createdAt': now, 'updatedAt': now},
      {'id': 'w98', 'slovenian': 'Sestanek', 'english': 'Meeting', 'example': 'Imam sestanek.', 'difficulty': 5, 'levelId': 'advanced_3', 'createdAt': now, 'updatedAt': now},
      {'id': 'w99', 'slovenian': 'Pogodba', 'english': 'Contract', 'example': 'Podpisati pogodbo.', 'difficulty': 5, 'levelId': 'advanced_3', 'createdAt': now, 'updatedAt': now},
      {'id': 'w100', 'slovenian': 'Služba', 'english': 'Service / Job', 'example': 'Dobra služba.', 'difficulty': 5, 'levelId': 'advanced_3', 'createdAt': now, 'updatedAt': now},
      {'id': 'w101', 'slovenian': 'Spoštovani', 'english': 'Respected / Dear', 'example': 'Spoštovani gospod.', 'difficulty': 5, 'levelId': 'advanced_3', 'createdAt': now, 'updatedAt': now},
      {'id': 'w102', 'slovenian': 'Uradno', 'english': 'Officially', 'example': 'Uradno obvestilo.', 'difficulty': 5, 'levelId': 'advanced_3', 'createdAt': now, 'updatedAt': now},
      {'id': 'w103', 'slovenian': 'Prijava', 'english': 'Application', 'example': 'Prijava za delo.', 'difficulty': 5, 'levelId': 'advanced_3', 'createdAt': now, 'updatedAt': now},
      {'id': 'w104', 'slovenian': 'Dogovor', 'english': 'Agreement', 'example': 'Skleniti dogovor.', 'difficulty': 5, 'levelId': 'advanced_3', 'createdAt': now, 'updatedAt': now},
      // Expert - Expert Vocabulary (8 words) - placeholder
      {'id': 'w105', 'slovenian': 'Izjemno', 'english': 'Exceptionally', 'example': 'Izjemno dobro.', 'difficulty': 6, 'levelId': 'expert_1', 'createdAt': now, 'updatedAt': now},
      {'id': 'w106', 'slovenian': 'Pomembno', 'english': 'Important', 'example': 'Pomembno je.', 'difficulty': 6, 'levelId': 'expert_1', 'createdAt': now, 'updatedAt': now},
      {'id': 'w107', 'slovenian': 'Zapleten', 'english': 'Complex', 'example': 'Zapletena situacija.', 'difficulty': 6, 'levelId': 'expert_1', 'createdAt': now, 'updatedAt': now},
      {'id': 'w108', 'slovenian': 'Sofisticiran', 'english': 'Sophisticated', 'example': 'Sofisticirana metoda.', 'difficulty': 6, 'levelId': 'expert_1', 'createdAt': now, 'updatedAt': now},
      {'id': 'w109', 'slovenian': 'Nujen', 'english': 'Urgent', 'example': 'Nujna zadeva.', 'difficulty': 6, 'levelId': 'expert_1', 'createdAt': now, 'updatedAt': now},
      {'id': 'w110', 'slovenian': 'Zelo', 'english': 'Very', 'example': 'Zelo dobro.', 'difficulty': 6, 'levelId': 'expert_1', 'createdAt': now, 'updatedAt': now},
      {'id': 'w111', 'slovenian': 'Izredno', 'english': 'Extraordinarily', 'example': 'Izredno pomembno.', 'difficulty': 6, 'levelId': 'expert_1', 'createdAt': now, 'updatedAt': now},
      {'id': 'w112', 'slovenian': 'Poseben', 'english': 'Special', 'example': 'Poseben dan.', 'difficulty': 6, 'levelId': 'expert_1', 'createdAt': now, 'updatedAt': now},
      // Expert - Literature & Arts (8 words) - placeholder
      {'id': 'w113', 'slovenian': 'Literatura', 'english': 'Literature', 'example': 'Slovenska literatura.', 'difficulty': 6, 'levelId': 'expert_2', 'createdAt': now, 'updatedAt': now},
      {'id': 'w114', 'slovenian': 'Umetnost', 'english': 'Art', 'example': 'Moderna umetnost.', 'difficulty': 6, 'levelId': 'expert_2', 'createdAt': now, 'updatedAt': now},
      {'id': 'w115', 'slovenian': 'Pesem', 'english': 'Poem', 'example': 'Lepa pesem.', 'difficulty': 6, 'levelId': 'expert_2', 'createdAt': now, 'updatedAt': now},
      {'id': 'w116', 'slovenian': 'Roman', 'english': 'Novel', 'example': 'Zanimiv roman.', 'difficulty': 6, 'levelId': 'expert_2', 'createdAt': now, 'updatedAt': now},
      {'id': 'w117', 'slovenian': 'Avtor', 'english': 'Author', 'example': 'Slaven avtor.', 'difficulty': 6, 'levelId': 'expert_2', 'createdAt': now, 'updatedAt': now},
      {'id': 'w118', 'slovenian': 'Galerija', 'english': 'Gallery', 'example': 'Umetnostna galerija.', 'difficulty': 6, 'levelId': 'expert_2', 'createdAt': now, 'updatedAt': now},
      {'id': 'w119', 'slovenian': 'Gledališče', 'english': 'Theater', 'example': 'Narodno gledališče.', 'difficulty': 6, 'levelId': 'expert_2', 'createdAt': now, 'updatedAt': now},
      {'id': 'w120', 'slovenian': 'Koncert', 'english': 'Concert', 'example': 'Glazbeni koncert.', 'difficulty': 6, 'levelId': 'expert_2', 'createdAt': now, 'updatedAt': now},
      // Expert - Academic & Scientific (8 words) - placeholder
      {'id': 'w121', 'slovenian': 'Znanost', 'english': 'Science', 'example': 'Naravna znanost.', 'difficulty': 6, 'levelId': 'expert_3', 'createdAt': now, 'updatedAt': now},
      {'id': 'w122', 'slovenian': 'Raziskava', 'english': 'Research', 'example': 'Znanstvena raziskava.', 'difficulty': 6, 'levelId': 'expert_3', 'createdAt': now, 'updatedAt': now},
      {'id': 'w123', 'slovenian': 'Teorija', 'english': 'Theory', 'example': 'Znanstvena teorija.', 'difficulty': 6, 'levelId': 'expert_3', 'createdAt': now, 'updatedAt': now},
      {'id': 'w124', 'slovenian': 'Eksperiment', 'english': 'Experiment', 'example': 'Naučen eksperiment.', 'difficulty': 6, 'levelId': 'expert_3', 'createdAt': now, 'updatedAt': now},
      {'id': 'w125', 'slovenian': 'Analiza', 'english': 'Analysis', 'example': 'Podrobna analiza.', 'difficulty': 6, 'levelId': 'expert_3', 'createdAt': now, 'updatedAt': now},
      {'id': 'w126', 'slovenian': 'Dokaz', 'english': 'Proof', 'example': 'Znanstveni dokaz.', 'difficulty': 6, 'levelId': 'expert_3', 'createdAt': now, 'updatedAt': now},
      {'id': 'w127', 'slovenian': 'Hipoteza', 'english': 'Hypothesis', 'example': 'Znanstvena hipoteza.', 'difficulty': 6, 'levelId': 'expert_3', 'createdAt': now, 'updatedAt': now},
      {'id': 'w128', 'slovenian': 'Metoda', 'english': 'Method', 'example': 'Nova metoda.', 'difficulty': 6, 'levelId': 'expert_3', 'createdAt': now, 'updatedAt': now},
    ];

    // Helper function to generate lesson tasks
    List<Map<String, dynamic>> generateLessonTasks(String levelId, List<Map<String, dynamic>> levelWords, int taskStartId, int difficulty) {
      final tasks = <Map<String, dynamic>>[];
      int taskId = taskStartId;
      
      // Multiple choice questions (5-6)
      for (int i = 0; i < 5 && i < levelWords.length; i++) {
        final word = levelWords[i];
        tasks.add({
          'id': 't$taskId',
          'levelId': levelId,
          'question': 'What does "${word['slovenian']}" mean?',
          'options': '${word['english']}|${levelWords[(i+1)%levelWords.length]['english']}|${levelWords[(i+2)%levelWords.length]['english']}|${levelWords[(i+3)%levelWords.length]['english']}',
          'correctAnswer': word['english'],
          'kind': 'multipleChoice',
          'difficulty': difficulty,
          'explanation': '${word['slovenian']} = ${word['english']}.',
          'createdAt': now,
          'updatedAt': now,
        });
        taskId++;
      }
      
      // Write-in questions (3-4)
      for (int i = 5; i < 8 && i < levelWords.length; i++) {
        final word = levelWords[i];
        tasks.add({
          'id': 't$taskId',
          'levelId': levelId,
          'question': 'Write the Slovenian for "${word['english']}".',
          'options': '',
          'correctAnswer': word['slovenian'],
          'kind': 'writeIn',
          'difficulty': difficulty,
          'explanation': '${word['slovenian']} = ${word['english']}.',
          'createdAt': now,
          'updatedAt': now,
        });
        taskId++;
      }
      
      // True/False questions (3-4)
      for (int i = 0; i < 3 && i < levelWords.length; i++) {
        final word = levelWords[i];
        final isTrue = i % 2 == 0;
        tasks.add({
          'id': 't$taskId',
          'levelId': levelId,
          'question': '"${word['slovenian']}" means "${isTrue ? word['english'] : levelWords[(i+1)%levelWords.length]['english']}".',
          'options': 'True|False',
          'correctAnswer': isTrue ? 'True' : 'False',
          'kind': 'trueFalse',
          'difficulty': difficulty,
          'explanation': '${word['slovenian']} = ${word['english']}.',
          'createdAt': now,
          'updatedAt': now,
        });
        taskId++;
      }
      
      return tasks;
    }

    // Generate lesson tasks for all lessons
    final lessonTasks = <Map<String, dynamic>>[];
    int taskIdCounter = 1;

    // Starter level tasks (12 questions)
    final starterWords = words.where((w) => w['levelId'] == 'starter_1').toList();
    lessonTasks.addAll(generateLessonTasks('starter_1', starterWords, taskIdCounter, 1));
    taskIdCounter += 12;

    // Beginner levels
    final beginner1Words = words.where((w) => w['levelId'] == 'beginner_1').toList();
    lessonTasks.addAll(generateLessonTasks('beginner_1', beginner1Words, taskIdCounter, 2));
    taskIdCounter += 12;

    final beginner2Words = words.where((w) => w['levelId'] == 'beginner_2').toList();
    lessonTasks.addAll(generateLessonTasks('beginner_2', beginner2Words, taskIdCounter, 2));
    taskIdCounter += 12;

    final beginner3Words = words.where((w) => w['levelId'] == 'beginner_3').toList();
    lessonTasks.addAll(generateLessonTasks('beginner_3', beginner3Words, taskIdCounter, 2));
    taskIdCounter += 12;

    // Beginner Quiz (12 questions mixing all beginner words)
    final allBeginnerWords = [...beginner1Words, ...beginner2Words, ...beginner3Words];
    lessonTasks.addAll(generateLessonTasks('beginner_quiz', allBeginnerWords, taskIdCounter, 2));
    taskIdCounter += 12;

    // Intermediate levels
    final intermediate1Words = words.where((w) => w['levelId'] == 'intermediate_1').toList();
    lessonTasks.addAll(generateLessonTasks('intermediate_1', intermediate1Words, taskIdCounter, 3));
    taskIdCounter += 12;

    final intermediate2Words = words.where((w) => w['levelId'] == 'intermediate_2').toList();
    lessonTasks.addAll(generateLessonTasks('intermediate_2', intermediate2Words, taskIdCounter, 3));
    taskIdCounter += 12;

    final intermediate3Words = words.where((w) => w['levelId'] == 'intermediate_3').toList();
    lessonTasks.addAll(generateLessonTasks('intermediate_3', intermediate3Words, taskIdCounter, 3));
    taskIdCounter += 12;

    // Intermediate Quiz
    final allIntermediateWords = [...intermediate1Words, ...intermediate2Words, ...intermediate3Words];
    lessonTasks.addAll(generateLessonTasks('intermediate_quiz', allIntermediateWords, taskIdCounter, 3));
    taskIdCounter += 12;

    // Upper Intermediate levels
    final upper1Words = words.where((w) => w['levelId'] == 'upper_1').toList();
    lessonTasks.addAll(generateLessonTasks('upper_1', upper1Words, taskIdCounter, 4));
    taskIdCounter += 12;

    final upper2Words = words.where((w) => w['levelId'] == 'upper_2').toList();
    lessonTasks.addAll(generateLessonTasks('upper_2', upper2Words, taskIdCounter, 4));
    taskIdCounter += 12;

    final upper3Words = words.where((w) => w['levelId'] == 'upper_3').toList();
    lessonTasks.addAll(generateLessonTasks('upper_3', upper3Words, taskIdCounter, 4));
    taskIdCounter += 12;

    // Upper Intermediate Quiz
    final allUpperWords = [...upper1Words, ...upper2Words, ...upper3Words];
    lessonTasks.addAll(generateLessonTasks('upper_quiz', allUpperWords, taskIdCounter, 4));
    taskIdCounter += 12;

    // Advanced levels
    final advanced1Words = words.where((w) => w['levelId'] == 'advanced_1').toList();
    lessonTasks.addAll(generateLessonTasks('advanced_1', advanced1Words, taskIdCounter, 5));
    taskIdCounter += 12;

    final advanced2Words = words.where((w) => w['levelId'] == 'advanced_2').toList();
    lessonTasks.addAll(generateLessonTasks('advanced_2', advanced2Words, taskIdCounter, 5));
    taskIdCounter += 12;

    final advanced3Words = words.where((w) => w['levelId'] == 'advanced_3').toList();
    lessonTasks.addAll(generateLessonTasks('advanced_3', advanced3Words, taskIdCounter, 5));
    taskIdCounter += 12;

    // Advanced Quiz
    final allAdvancedWords = [...advanced1Words, ...advanced2Words, ...advanced3Words];
    lessonTasks.addAll(generateLessonTasks('advanced_quiz', allAdvancedWords, taskIdCounter, 5));
    taskIdCounter += 12;

    // Expert levels
    final expert1Words = words.where((w) => w['levelId'] == 'expert_1').toList();
    lessonTasks.addAll(generateLessonTasks('expert_1', expert1Words, taskIdCounter, 6));
    taskIdCounter += 12;

    final expert2Words = words.where((w) => w['levelId'] == 'expert_2').toList();
    lessonTasks.addAll(generateLessonTasks('expert_2', expert2Words, taskIdCounter, 6));
    taskIdCounter += 12;

    final expert3Words = words.where((w) => w['levelId'] == 'expert_3').toList();
    lessonTasks.addAll(generateLessonTasks('expert_3', expert3Words, taskIdCounter, 6));
    taskIdCounter += 12;

    // Expert Quiz
    final allExpertWords = [...expert1Words, ...expert2Words, ...expert3Words];
    lessonTasks.addAll(generateLessonTasks('expert_quiz', allExpertWords, taskIdCounter, 6));
    taskIdCounter += 12;

    final batch = txn.batch();
    for (final level in levels) {
      batch.insert('levels', level, conflictAlgorithm: ConflictAlgorithm.replace);
    }
    for (final word in words) {
      batch.insert('words', word, conflictAlgorithm: ConflictAlgorithm.replace);
    }
    for (final task in lessonTasks) {
      batch.insert('lesson_tasks', task, conflictAlgorithm: ConflictAlgorithm.replace);
    }
    await batch.commit(noResult: true);
  });
}