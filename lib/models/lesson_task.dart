enum LessonTaskKind { trueFalse, multipleChoice, writeIn }

class LessonTask {
  final String id;
  final String levelId;
  final String question;
  final List<String> options;
  final String correctAnswer;
  final LessonTaskKind kind;
  final int difficulty;
  final String explanation;
  final DateTime createdAt;
  final DateTime updatedAt;

  LessonTask({
    required this.id,
    required this.levelId,
    required this.question,
    required this.options,
    required this.correctAnswer,
    required this.kind,
    required this.difficulty,
    required this.explanation,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'levelId': levelId,
        'question': question,
        'options': options.join('|'),
        'correctAnswer': correctAnswer,
        'kind': kind.toString().split('.').last,
        'difficulty': difficulty,
        'explanation': explanation,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
      };

  factory LessonTask.fromJson(Map<String, dynamic> json) => LessonTask(
        id: json['id'] as String,
        levelId: json['levelId'] as String,
        question: json['question'] as String,
        options: (json['options'] as String).split('|'),
        correctAnswer: json['correctAnswer'] as String,
        kind: LessonTaskKind.values.firstWhere(
          (e) => e.toString().split('.').last == json['kind'],
          orElse: () => LessonTaskKind.multipleChoice,
        ),
        difficulty: json['difficulty'] as int? ?? 1,
        explanation: json['explanation'] as String? ?? '',
        createdAt: DateTime.parse(json['createdAt'] as String),
        updatedAt: DateTime.parse(json['updatedAt'] as String),
      );
}
