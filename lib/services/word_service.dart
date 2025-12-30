import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:math';
import 'package:slovingo/models/word.dart';

class WordService {
  static const String _wordsKey = 'words_data';
  static const String _wordOfDayKey = 'word_of_day';
  static const String _lastWordDateKey = 'last_word_date';

  Future<void> _initSampleData() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(_wordsKey)) {
      final now = DateTime.now();
      final sampleWords = [
        // Level 1 - Basic Greetings
        Word(id: 'w1', slovenian: 'Živjo', english: 'Hello', example: 'Živjo, kako si?', difficulty: 1, levelId: 'level_1', createdAt: now, updatedAt: now),
        Word(id: 'w2', slovenian: 'Hvala', english: 'Thank you', example: 'Hvala za pomoč.', difficulty: 1, levelId: 'level_1', createdAt: now, updatedAt: now),
        Word(id: 'w3', slovenian: 'Prosim', english: 'Please/You\'re welcome', example: 'Prosim te, pomagaj mi.', difficulty: 1, levelId: 'level_1', createdAt: now, updatedAt: now),
        Word(id: 'w4', slovenian: 'Dober dan', english: 'Good day', example: 'Dober dan, gospod!', difficulty: 1, levelId: 'level_1', createdAt: now, updatedAt: now),
        Word(id: 'w5', slovenian: 'Nasvidenje', english: 'Goodbye', example: 'Nasvidenje, prijatelj!', difficulty: 1, levelId: 'level_1', createdAt: now, updatedAt: now),
        Word(id: 'w6', slovenian: 'Ja', english: 'Yes', example: 'Ja, strinjam se.', difficulty: 1, levelId: 'level_1', createdAt: now, updatedAt: now),
        Word(id: 'w7', slovenian: 'Ne', english: 'No', example: 'Ne, ne morem.', difficulty: 1, levelId: 'level_1', createdAt: now, updatedAt: now),
        
        // Level 2 - Family
        Word(id: 'w8', slovenian: 'Družina', english: 'Family', example: 'Moja družina je velika.', difficulty: 1, levelId: 'level_2', createdAt: now, updatedAt: now),
        Word(id: 'w9', slovenian: 'Mama', english: 'Mom', example: 'Moja mama je prijazna.', difficulty: 1, levelId: 'level_2', createdAt: now, updatedAt: now),
        Word(id: 'w10', slovenian: 'Oče', english: 'Father', example: 'Moj oče je učitelj.', difficulty: 1, levelId: 'level_2', createdAt: now, updatedAt: now),
        Word(id: 'w11', slovenian: 'Brat', english: 'Brother', example: 'Imam mlajšega brata.', difficulty: 1, levelId: 'level_2', createdAt: now, updatedAt: now),
        Word(id: 'w12', slovenian: 'Sestra', english: 'Sister', example: 'Moja sestra študira.', difficulty: 1, levelId: 'level_2', createdAt: now, updatedAt: now),
        Word(id: 'w13', slovenian: 'Babica', english: 'Grandmother', example: 'Babica pripravlja kosilo.', difficulty: 1, levelId: 'level_2', createdAt: now, updatedAt: now),
        Word(id: 'w14', slovenian: 'Dedek', english: 'Grandfather', example: 'Dedek bere časopis.', difficulty: 1, levelId: 'level_2', createdAt: now, updatedAt: now),
        
        // Level 3 - Food & Drink
        Word(id: 'w15', slovenian: 'Hrana', english: 'Food', example: 'Ta hrana je okusna.', difficulty: 2, levelId: 'level_3', createdAt: now, updatedAt: now),
        Word(id: 'w16', slovenian: 'Voda', english: 'Water', example: 'Potrebujem kozarec vode.', difficulty: 2, levelId: 'level_3', createdAt: now, updatedAt: now),
        Word(id: 'w17', slovenian: 'Kruh', english: 'Bread', example: 'Kupil bom svež kruh.', difficulty: 2, levelId: 'level_3', createdAt: now, updatedAt: now),
        Word(id: 'w18', slovenian: 'Mleko', english: 'Milk', example: 'Pijem mleko vsak dan.', difficulty: 2, levelId: 'level_3', createdAt: now, updatedAt: now),
        Word(id: 'w19', slovenian: 'Kava', english: 'Coffee', example: 'Zjutraj pijem kavo.', difficulty: 2, levelId: 'level_3', createdAt: now, updatedAt: now),
        Word(id: 'w20', slovenian: 'Sadje', english: 'Fruit', example: 'Rad imam sveže sadje.', difficulty: 2, levelId: 'level_3', createdAt: now, updatedAt: now),
        Word(id: 'w21', slovenian: 'Meso', english: 'Meat', example: 'Ne jem mesa.', difficulty: 2, levelId: 'level_3', createdAt: now, updatedAt: now),
        
        // Level 4 - Colors
        Word(id: 'w22', slovenian: 'Barva', english: 'Color', example: 'Katera barva ti je všeč?', difficulty: 2, levelId: 'level_4', createdAt: now, updatedAt: now),
        Word(id: 'w23', slovenian: 'Rdeča', english: 'Red', example: 'Imam rdečo majico.', difficulty: 2, levelId: 'level_4', createdAt: now, updatedAt: now),
        Word(id: 'w24', slovenian: 'Modra', english: 'Blue', example: 'Nebo je modro.', difficulty: 2, levelId: 'level_4', createdAt: now, updatedAt: now),
        Word(id: 'w25', slovenian: 'Zelena', english: 'Green', example: 'Trava je zelena.', difficulty: 2, levelId: 'level_4', createdAt: now, updatedAt: now),
        Word(id: 'w26', slovenian: 'Rumena', english: 'Yellow', example: 'Sonce je rumeno.', difficulty: 2, levelId: 'level_4', createdAt: now, updatedAt: now),
        Word(id: 'w27', slovenian: 'Črna', english: 'Black', example: 'Nosim črne čevlje.', difficulty: 2, levelId: 'level_4', createdAt: now, updatedAt: now),
        Word(id: 'w28', slovenian: 'Bela', english: 'White', example: 'Sneg je bel.', difficulty: 2, levelId: 'level_4', createdAt: now, updatedAt: now),
        
        // Level 5 - Numbers
        Word(id: 'w29', slovenian: 'Ena', english: 'One', example: 'Imam eno jabolko.', difficulty: 2, levelId: 'level_5', createdAt: now, updatedAt: now),
        Word(id: 'w30', slovenian: 'Dva', english: 'Two', example: 'Dva plus dva je štiri.', difficulty: 2, levelId: 'level_5', createdAt: now, updatedAt: now),
        Word(id: 'w31', slovenian: 'Tri', english: 'Three', example: 'Imam tri mačke.', difficulty: 2, levelId: 'level_5', createdAt: now, updatedAt: now),
        Word(id: 'w32', slovenian: 'Štiri', english: 'Four', example: 'Miza ima štiri noge.', difficulty: 2, levelId: 'level_5', createdAt: now, updatedAt: now),
        Word(id: 'w33', slovenian: 'Pet', english: 'Five', example: 'Na roki imam pet prstov.', difficulty: 2, levelId: 'level_5', createdAt: now, updatedAt: now),
        Word(id: 'w34', slovenian: 'Deset', english: 'Ten', example: 'Deset minut čakanja.', difficulty: 2, levelId: 'level_5', createdAt: now, updatedAt: now),
        Word(id: 'w35', slovenian: 'Sto', english: 'Hundred', example: 'Imam sto evrov.', difficulty: 2, levelId: 'level_5', createdAt: now, updatedAt: now),
        
        // Level 6 - Weather
        Word(id: 'w36', slovenian: 'Vreme', english: 'Weather', example: 'Kakšno je vreme danes?', difficulty: 3, levelId: 'level_6', createdAt: now, updatedAt: now),
        Word(id: 'w37', slovenian: 'Sonce', english: 'Sun', example: 'Sonce sije.', difficulty: 3, levelId: 'level_6', createdAt: now, updatedAt: now),
        Word(id: 'w38', slovenian: 'Dež', english: 'Rain', example: 'Pada dež.', difficulty: 3, levelId: 'level_6', createdAt: now, updatedAt: now),
        Word(id: 'w39', slovenian: 'Sneg', english: 'Snow', example: 'Pozimi pada sneg.', difficulty: 3, levelId: 'level_6', createdAt: now, updatedAt: now),
        Word(id: 'w40', slovenian: 'Veter', english: 'Wind', example: 'Danes piha veter.', difficulty: 3, levelId: 'level_6', createdAt: now, updatedAt: now),
        Word(id: 'w41', slovenian: 'Oblak', english: 'Cloud', example: 'Na nebu so oblaki.', difficulty: 3, levelId: 'level_6', createdAt: now, updatedAt: now),
        Word(id: 'w42', slovenian: 'Hladno', english: 'Cold', example: 'Danes je hladno.', difficulty: 3, levelId: 'level_6', createdAt: now, updatedAt: now),
        
        // Level 7 - Places
        Word(id: 'w43', slovenian: 'Mesto', english: 'City', example: 'Ljubljana je glavno mesto.', difficulty: 3, levelId: 'level_7', createdAt: now, updatedAt: now),
        Word(id: 'w44', slovenian: 'Hiša', english: 'House', example: 'Imam lepo hišo.', difficulty: 3, levelId: 'level_7', createdAt: now, updatedAt: now),
        Word(id: 'w45', slovenian: 'Šola', english: 'School', example: 'Otroci hodijo v šolo.', difficulty: 3, levelId: 'level_7', createdAt: now, updatedAt: now),
        Word(id: 'w46', slovenian: 'Bolnišnica', english: 'Hospital', example: 'Zdravnik dela v bolnišnici.', difficulty: 3, levelId: 'level_7', createdAt: now, updatedAt: now),
        Word(id: 'w47', slovenian: 'Trgovina', english: 'Store', example: 'V trgovini kupujem hrano.', difficulty: 3, levelId: 'level_7', createdAt: now, updatedAt: now),
        Word(id: 'w48', slovenian: 'Park', english: 'Park', example: 'V parku se igrajo otroci.', difficulty: 3, levelId: 'level_7', createdAt: now, updatedAt: now),
        Word(id: 'w49', slovenian: 'Gozd', english: 'Forest', example: 'V gozdu rastejo drevesa.', difficulty: 3, levelId: 'level_7', createdAt: now, updatedAt: now),
        
        // Level 8 - Time
        Word(id: 'w50', slovenian: 'Čas', english: 'Time', example: 'Koliko je ura?', difficulty: 3, levelId: 'level_8', createdAt: now, updatedAt: now),
        Word(id: 'w51', slovenian: 'Dan', english: 'Day', example: 'Lep dan ti želim.', difficulty: 3, levelId: 'level_8', createdAt: now, updatedAt: now),
        Word(id: 'w52', slovenian: 'Teden', english: 'Week', example: 'Naslednji teden grem na morje.', difficulty: 3, levelId: 'level_8', createdAt: now, updatedAt: now),
        Word(id: 'w53', slovenian: 'Mesec', english: 'Month', example: 'Januar je prvi mesec.', difficulty: 3, levelId: 'level_8', createdAt: now, updatedAt: now),
        Word(id: 'w54', slovenian: 'Leto', english: 'Year', example: 'Srečno novo leto!', difficulty: 3, levelId: 'level_8', createdAt: now, updatedAt: now),
        Word(id: 'w55', slovenian: 'Danes', english: 'Today', example: 'Danes je lep dan.', difficulty: 3, levelId: 'level_8', createdAt: now, updatedAt: now),
        Word(id: 'w56', slovenian: 'Jutri', english: 'Tomorrow', example: 'Jutri imam izpit.', difficulty: 3, levelId: 'level_8', createdAt: now, updatedAt: now),
        
        // Additional general words
        Word(id: 'w57', slovenian: 'Ljubezen', english: 'Love', example: 'Ljubezen je pomembna.', difficulty: 3, levelId: 'level_9', createdAt: now, updatedAt: now),
        Word(id: 'w58', slovenian: 'Prijatelj', english: 'Friend', example: 'On je moj najboljši prijatelj.', difficulty: 3, levelId: 'level_9', createdAt: now, updatedAt: now),
        Word(id: 'w59', slovenian: 'Srečen', english: 'Happy', example: 'Sem zelo srečen danes.', difficulty: 3, levelId: 'level_9', createdAt: now, updatedAt: now),
        Word(id: 'w60', slovenian: 'Žalosten', english: 'Sad', example: 'Zakaj si žalosten?', difficulty: 3, levelId: 'level_9', createdAt: now, updatedAt: now),
        Word(id: 'w61', slovenian: 'Učiti se', english: 'To learn', example: 'Rad se učim slovenščino.', difficulty: 3, levelId: 'level_9', createdAt: now, updatedAt: now),
        Word(id: 'w62', slovenian: 'Govoriti', english: 'To speak', example: 'Znam govoriti slovensko.', difficulty: 3, levelId: 'level_9', createdAt: now, updatedAt: now),
        Word(id: 'w63', slovenian: 'Razumeti', english: 'To understand', example: 'Ali me razumeš?', difficulty: 3, levelId: 'level_9', createdAt: now, updatedAt: now),
        
        // Level 10 - Advanced
        Word(id: 'w64', slovenian: 'Potovanje', english: 'Travel', example: 'Rad imam potovanja.', difficulty: 4, levelId: 'level_10', createdAt: now, updatedAt: now),
        Word(id: 'w65', slovenian: 'Kultura', english: 'Culture', example: 'Slovenska kultura je bogata.', difficulty: 4, levelId: 'level_10', createdAt: now, updatedAt: now),
        Word(id: 'w66', slovenian: 'Zgodovina', english: 'History', example: 'Zgodovina je zanimiva.', difficulty: 4, levelId: 'level_10', createdAt: now, updatedAt: now),
        Word(id: 'w67', slovenian: 'Znanost', english: 'Science', example: 'Študiram naravoslovne znanosti.', difficulty: 4, levelId: 'level_10', createdAt: now, updatedAt: now),
        Word(id: 'w68', slovenian: 'Umetnost', english: 'Art', example: 'V galeriji vidim umetnost.', difficulty: 4, levelId: 'level_10', createdAt: now, updatedAt: now),
        Word(id: 'w69', slovenian: 'Knjiga', english: 'Book', example: 'Berem dobro knjigo.', difficulty: 4, levelId: 'level_10', createdAt: now, updatedAt: now),
        Word(id: 'w70', slovenian: 'Glasba', english: 'Music', example: 'Poslušam slovensko glasbo.', difficulty: 4, levelId: 'level_10', createdAt: now, updatedAt: now),
      ];
      
      final wordsJson = sampleWords.map((w) => w.toJson()).toList();
      await prefs.setString(_wordsKey, jsonEncode(wordsJson));
    }
  }

  Future<List<Word>> getAllWords() async {
    await _initSampleData();
    final prefs = await SharedPreferences.getInstance();
    final wordsJson = prefs.getString(_wordsKey);
    if (wordsJson == null) return [];
    
    final List<dynamic> decoded = jsonDecode(wordsJson);
    return decoded.map((json) => Word.fromJson(json)).toList();
  }

  Future<List<Word>> getWordsByLevel(String levelId) async {
    final allWords = await getAllWords();
    return allWords.where((w) => w.levelId == levelId).toList();
  }

  Future<Word?> getWordOfDay() async {
    await _initSampleData();
    final prefs = await SharedPreferences.getInstance();
    final lastDate = prefs.getString(_lastWordDateKey);
    final today = DateTime.now().toIso8601String().split('T')[0];
    
    if (lastDate != today) {
      final allWords = await getAllWords();
      if (allWords.isEmpty) return null;
      
      final random = Random(DateTime.now().day);
      final wordOfDay = allWords[random.nextInt(allWords.length)];
      
      await prefs.setString(_wordOfDayKey, jsonEncode(wordOfDay.toJson()));
      await prefs.setString(_lastWordDateKey, today);
      return wordOfDay;
    }
    
    final wordJson = prefs.getString(_wordOfDayKey);
    if (wordJson == null) return null;
    return Word.fromJson(jsonDecode(wordJson));
  }
}