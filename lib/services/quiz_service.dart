import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:slovingo/models/quiz.dart';

class QuizService {
  static const String _quizzesKey = 'quizzes_data';

  Future<void> _initSampleData() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(_quizzesKey)) {
      final now = DateTime.now();
      final sampleQuizzes = [
        // Level 1 quizzes
        Quiz(id: 'q1', levelId: 'level_1', question: 'Kako rečete "Hello" v slovenščini?', options: ['Živjo', 'Nasvidenje', 'Hvala', 'Prosim'], correctAnswer: 'Živjo', type: QuizType.multipleChoice, createdAt: now, updatedAt: now),
        Quiz(id: 'q2', levelId: 'level_1', question: 'Prevedite: "Thank you"', options: ['Prosim', 'Hvala', 'Živjo', 'Ne'], correctAnswer: 'Hvala', type: QuizType.translate, createdAt: now, updatedAt: now),
        Quiz(id: 'q3', levelId: 'level_1', question: 'Dober ___ (Good day)', options: ['dan', 'noč', 'veče', 'jutro'], correctAnswer: 'dan', type: QuizType.fillBlank, createdAt: now, updatedAt: now),
        Quiz(id: 'q4', levelId: 'level_1', question: 'Kaj pomeni "Nasvidenje"?', options: ['Goodbye', 'Hello', 'Please', 'Thank you'], correctAnswer: 'Goodbye', type: QuizType.multipleChoice, createdAt: now, updatedAt: now),
        Quiz(id: 'q5', levelId: 'level_1', question: 'Kako rečete "Yes" v slovenščini?', options: ['Ja', 'Ne', 'Morda', 'Ok'], correctAnswer: 'Ja', type: QuizType.multipleChoice, createdAt: now, updatedAt: now),
        
        // Level 2 quizzes
        Quiz(id: 'q6', levelId: 'level_2', question: 'Prevedite: "Family"', options: ['Družina', 'Prijatelj', 'Sosed', 'Človek'], correctAnswer: 'Družina', type: QuizType.translate, createdAt: now, updatedAt: now),
        Quiz(id: 'q7', levelId: 'level_2', question: 'Moja ___ je prijazna (My mom)', options: ['mama', 'sestra', 'babica', 'teta'], correctAnswer: 'mama', type: QuizType.fillBlank, createdAt: now, updatedAt: now),
        Quiz(id: 'q8', levelId: 'level_2', question: 'Kaj pomeni "Brat"?', options: ['Brother', 'Father', 'Sister', 'Friend'], correctAnswer: 'Brother', type: QuizType.multipleChoice, createdAt: now, updatedAt: now),
        Quiz(id: 'q9', levelId: 'level_2', question: 'Kako rečete "Grandmother"?', options: ['Babica', 'Mama', 'Sestra', 'Teta'], correctAnswer: 'Babica', type: QuizType.multipleChoice, createdAt: now, updatedAt: now),
        Quiz(id: 'q10', levelId: 'level_2', question: 'Prevedite: "Grandfather"', options: ['Dedek', 'Oče', 'Stric', 'Brat'], correctAnswer: 'Dedek', type: QuizType.translate, createdAt: now, updatedAt: now),
        
        // Level 3 quizzes
        Quiz(id: 'q11', levelId: 'level_3', question: 'Prevedite: "Water"', options: ['Voda', 'Mleko', 'Kava', 'Čaj'], correctAnswer: 'Voda', type: QuizType.translate, createdAt: now, updatedAt: now),
        Quiz(id: 'q12', levelId: 'level_3', question: 'Ta ___ je okusna (This food)', options: ['hrana', 'voda', 'mama', 'hiša'], correctAnswer: 'hrana', type: QuizType.fillBlank, createdAt: now, updatedAt: now),
        Quiz(id: 'q13', levelId: 'level_3', question: 'Kaj pomeni "Kruh"?', options: ['Bread', 'Milk', 'Water', 'Meat'], correctAnswer: 'Bread', type: QuizType.multipleChoice, createdAt: now, updatedAt: now),
        Quiz(id: 'q14', levelId: 'level_3', question: 'Kako rečete "Coffee"?', options: ['Kava', 'Čaj', 'Sok', 'Mleko'], correctAnswer: 'Kava', type: QuizType.multipleChoice, createdAt: now, updatedAt: now),
        Quiz(id: 'q15', levelId: 'level_3', question: 'Prevedite: "Fruit"', options: ['Sadje', 'Zelenjava', 'Meso', 'Kruh'], correctAnswer: 'Sadje', type: QuizType.translate, createdAt: now, updatedAt: now),
        
        // Level 4 quizzes
        Quiz(id: 'q16', levelId: 'level_4', question: 'Prevedite: "Red"', options: ['Rdeča', 'Modra', 'Zelena', 'Rumena'], correctAnswer: 'Rdeča', type: QuizType.translate, createdAt: now, updatedAt: now),
        Quiz(id: 'q17', levelId: 'level_4', question: 'Nebo je ___ (The sky is blue)', options: ['modro', 'zeleno', 'rdeče', 'rumeno'], correctAnswer: 'modro', type: QuizType.fillBlank, createdAt: now, updatedAt: now),
        Quiz(id: 'q18', levelId: 'level_4', question: 'Kaj pomeni "Zelena"?', options: ['Green', 'Blue', 'Red', 'Yellow'], correctAnswer: 'Green', type: QuizType.multipleChoice, createdAt: now, updatedAt: now),
        Quiz(id: 'q19', levelId: 'level_4', question: 'Kako rečete "Black"?', options: ['Črna', 'Bela', 'Siva', 'Rjava'], correctAnswer: 'Črna', type: QuizType.multipleChoice, createdAt: now, updatedAt: now),
        Quiz(id: 'q20', levelId: 'level_4', question: 'Prevedite: "Yellow"', options: ['Rumena', 'Oranžna', 'Roza', 'Vijolična'], correctAnswer: 'Rumena', type: QuizType.translate, createdAt: now, updatedAt: now),
        
        // Level 5 quizzes
        Quiz(id: 'q21', levelId: 'level_5', question: 'Prevedite: "One"', options: ['Ena', 'Dva', 'Tri', 'Štiri'], correctAnswer: 'Ena', type: QuizType.translate, createdAt: now, updatedAt: now),
        Quiz(id: 'q22', levelId: 'level_5', question: 'Dva plus dva je ___ (Two plus two is four)', options: ['štiri', 'pet', 'tri', 'šest'], correctAnswer: 'štiri', type: QuizType.fillBlank, createdAt: now, updatedAt: now),
        Quiz(id: 'q23', levelId: 'level_5', question: 'Kaj pomeni "Pet"?', options: ['Five', 'Four', 'Six', 'Seven'], correctAnswer: 'Five', type: QuizType.multipleChoice, createdAt: now, updatedAt: now),
        Quiz(id: 'q24', levelId: 'level_5', question: 'Kako rečete "Ten"?', options: ['Deset', 'Dvajset', 'Trideset', 'Sto'], correctAnswer: 'Deset', type: QuizType.multipleChoice, createdAt: now, updatedAt: now),
        Quiz(id: 'q25', levelId: 'level_5', question: 'Prevedite: "Hundred"', options: ['Sto', 'Deset', 'Tisoč', 'Pet'], correctAnswer: 'Sto', type: QuizType.translate, createdAt: now, updatedAt: now),
        
        // Level 6 quizzes
        Quiz(id: 'q26', levelId: 'level_6', question: 'Prevedite: "Sun"', options: ['Sonce', 'Luna', 'Zvezda', 'Oblak'], correctAnswer: 'Sonce', type: QuizType.translate, createdAt: now, updatedAt: now),
        Quiz(id: 'q27', levelId: 'level_6', question: 'Pada ___ (It\'s raining)', options: ['dež', 'sneg', 'toča', 'megla'], correctAnswer: 'dež', type: QuizType.fillBlank, createdAt: now, updatedAt: now),
        Quiz(id: 'q28', levelId: 'level_6', question: 'Kaj pomeni "Sneg"?', options: ['Snow', 'Rain', 'Wind', 'Cloud'], correctAnswer: 'Snow', type: QuizType.multipleChoice, createdAt: now, updatedAt: now),
        Quiz(id: 'q29', levelId: 'level_6', question: 'Kako rečete "Cold"?', options: ['Hladno', 'Toplo', 'Vroče', 'Mrzlo'], correctAnswer: 'Hladno', type: QuizType.multipleChoice, createdAt: now, updatedAt: now),
        Quiz(id: 'q30', levelId: 'level_6', question: 'Prevedite: "Wind"', options: ['Veter', 'Dež', 'Nevihta', 'Sonce'], correctAnswer: 'Veter', type: QuizType.translate, createdAt: now, updatedAt: now),
        
        // Level 7 quizzes
        Quiz(id: 'q31', levelId: 'level_7', question: 'Prevedite: "House"', options: ['Hiša', 'Stanovanje', 'Grad', 'Koča'], correctAnswer: 'Hiša', type: QuizType.translate, createdAt: now, updatedAt: now),
        Quiz(id: 'q32', levelId: 'level_7', question: 'Otroci hodijo v ___ (Children go to school)', options: ['šolo', 'trgovino', 'bolnišnico', 'park'], correctAnswer: 'šolo', type: QuizType.fillBlank, createdAt: now, updatedAt: now),
        Quiz(id: 'q33', levelId: 'level_7', question: 'Kaj pomeni "Trgovina"?', options: ['Store', 'School', 'Hospital', 'Park'], correctAnswer: 'Store', type: QuizType.multipleChoice, createdAt: now, updatedAt: now),
        Quiz(id: 'q34', levelId: 'level_7', question: 'Kako rečete "Park"?', options: ['Park', 'Gozd', 'Vrt', 'Njiva'], correctAnswer: 'Park', type: QuizType.multipleChoice, createdAt: now, updatedAt: now),
        Quiz(id: 'q35', levelId: 'level_7', question: 'Prevedite: "Forest"', options: ['Gozd', 'Drevo', 'Grm', 'Cvet'], correctAnswer: 'Gozd', type: QuizType.translate, createdAt: now, updatedAt: now),
        
        // Level 8 quizzes
        Quiz(id: 'q36', levelId: 'level_8', question: 'Prevedite: "Day"', options: ['Dan', 'Noč', 'Teden', 'Mesec'], correctAnswer: 'Dan', type: QuizType.translate, createdAt: now, updatedAt: now),
        Quiz(id: 'q37', levelId: 'level_8', question: '___ je lep dan (Today is nice)', options: ['Danes', 'Jutri', 'Včeraj', 'Zjutraj'], correctAnswer: 'Danes', type: QuizType.fillBlank, createdAt: now, updatedAt: now),
        Quiz(id: 'q38', levelId: 'level_8', question: 'Kaj pomeni "Jutri"?', options: ['Tomorrow', 'Today', 'Yesterday', 'Week'], correctAnswer: 'Tomorrow', type: QuizType.multipleChoice, createdAt: now, updatedAt: now),
        Quiz(id: 'q39', levelId: 'level_8', question: 'Kako rečete "Month"?', options: ['Mesec', 'Teden', 'Leto', 'Dan'], correctAnswer: 'Mesec', type: QuizType.multipleChoice, createdAt: now, updatedAt: now),
        Quiz(id: 'q40', levelId: 'level_8', question: 'Prevedite: "Year"', options: ['Leto', 'Mesec', 'Desetletje', 'Stoletje'], correctAnswer: 'Leto', type: QuizType.translate, createdAt: now, updatedAt: now),
        
        // Level 9 quizzes
        Quiz(id: 'q41', levelId: 'level_9', question: 'Prevedite: "Happy"', options: ['Srečen', 'Žalosten', 'Jezen', 'Utrujen'], correctAnswer: 'Srečen', type: QuizType.translate, createdAt: now, updatedAt: now),
        Quiz(id: 'q42', levelId: 'level_9', question: 'On je moj najboljši ___ (He is my best friend)', options: ['prijatelj', 'brat', 'učitelj', 'sosed'], correctAnswer: 'prijatelj', type: QuizType.fillBlank, createdAt: now, updatedAt: now),
        Quiz(id: 'q43', levelId: 'level_9', question: 'Kaj pomeni "Govoriti"?', options: ['To speak', 'To learn', 'To understand', 'To write'], correctAnswer: 'To speak', type: QuizType.multipleChoice, createdAt: now, updatedAt: now),
        Quiz(id: 'q44', levelId: 'level_9', question: 'Kako rečete "To learn"?', options: ['Učiti se', 'Govoriti', 'Pisati', 'Brati'], correctAnswer: 'Učiti se', type: QuizType.multipleChoice, createdAt: now, updatedAt: now),
        Quiz(id: 'q45', levelId: 'level_9', question: 'Prevedite: "Love"', options: ['Ljubezen', 'Sovraštvo', 'Prijateljstvo', 'Srečanje'], correctAnswer: 'Ljubezen', type: QuizType.translate, createdAt: now, updatedAt: now),
        
        // Level 10 quizzes
        Quiz(id: 'q46', levelId: 'level_10', question: 'Prevedite: "Travel"', options: ['Potovanje', 'Počitek', 'Delo', 'Šola'], correctAnswer: 'Potovanje', type: QuizType.translate, createdAt: now, updatedAt: now),
        Quiz(id: 'q47', levelId: 'level_10', question: 'Slovenska ___ je bogata (Slovenian culture)', options: ['kultura', 'zgodovina', 'znanost', 'umetnost'], correctAnswer: 'kultura', type: QuizType.fillBlank, createdAt: now, updatedAt: now),
        Quiz(id: 'q48', levelId: 'level_10', question: 'Kaj pomeni "Knjiga"?', options: ['Book', 'Music', 'Art', 'Science'], correctAnswer: 'Book', type: QuizType.multipleChoice, createdAt: now, updatedAt: now),
        Quiz(id: 'q49', levelId: 'level_10', question: 'Kako rečete "Music"?', options: ['Glasba', 'Ples', 'Pesem', 'Zvok'], correctAnswer: 'Glasba', type: QuizType.multipleChoice, createdAt: now, updatedAt: now),
        Quiz(id: 'q50', levelId: 'level_10', question: 'Prevedite: "History"', options: ['Zgodovina', 'Prihodnost', 'Sedanjost', 'Preteklost'], correctAnswer: 'Zgodovina', type: QuizType.translate, createdAt: now, updatedAt: now),
      ];
      
      final quizzesJson = sampleQuizzes.map((q) => q.toJson()).toList();
      await prefs.setString(_quizzesKey, jsonEncode(quizzesJson));
    }
  }

  Future<List<Quiz>> getQuizzesByLevel(String levelId) async {
    await _initSampleData();
    final prefs = await SharedPreferences.getInstance();
    final quizzesJson = prefs.getString(_quizzesKey);
    if (quizzesJson == null) return [];
    
    final List<dynamic> decoded = jsonDecode(quizzesJson);
    final allQuizzes = decoded.map((json) => Quiz.fromJson(json)).toList();
    return allQuizzes.where((q) => q.levelId == levelId).toList();
  }

  int calculateScore(List<String> userAnswers, List<Quiz> quizzes) {
    if (quizzes.isEmpty) return 0;
    
    int correct = 0;
    for (int i = 0; i < quizzes.length && i < userAnswers.length; i++) {
      if (userAnswers[i].toLowerCase().trim() == quizzes[i].correctAnswer.toLowerCase().trim()) {
        correct++;
      }
    }
    
    return ((correct / quizzes.length) * 100).round();
  }
}