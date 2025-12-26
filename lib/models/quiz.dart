enum QuizType { multipleChoice, fillBlank, translate }

class Quiz {
  final String id;
  final String levelId;
  final String question;
  final List<String> options;
  final String correctAnswer;
  final QuizType type;
  final DateTime createdAt;
  final DateTime updatedAt;

  Quiz({
    required this.id,
    required this.levelId,
    required this.question,
    required this.options,
    required this.correctAnswer,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'levelId': levelId,
    'question': question,
    'options': options.join('|'),
    'correctAnswer': correctAnswer,
    'type': type.toString().split('.').last,
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
  };

  factory Quiz.fromJson(Map<String, dynamic> json) => Quiz(
    id: json['id'] as String,
    levelId: json['levelId'] as String,
    question: json['question'] as String,
    options: (json['options'] as String).split('|'),
    correctAnswer: json['correctAnswer'] as String,
    type: QuizType.values.firstWhere(
      (e) => e.toString().split('.').last == json['type'],
      orElse: () => QuizType.multipleChoice,
    ),
    createdAt: DateTime.parse(json['createdAt'] as String),
    updatedAt: DateTime.parse(json['updatedAt'] as String),
  );

  Quiz copyWith({
    String? id,
    String? levelId,
    String? question,
    List<String>? options,
    String? correctAnswer,
    QuizType? type,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Quiz(
    id: id ?? this.id,
    levelId: levelId ?? this.levelId,
    question: question ?? this.question,
    options: options ?? this.options,
    correctAnswer: correctAnswer ?? this.correctAnswer,
    type: type ?? this.type,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
}