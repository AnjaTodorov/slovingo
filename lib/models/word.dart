class Word {
  final String id;
  final String slovenian;
  final String english;
  final String example;
  final int difficulty;
  final String levelId;
  final DateTime createdAt;
  final DateTime updatedAt;

  Word({
    required this.id,
    required this.slovenian,
    required this.english,
    required this.example,
    required this.difficulty,
    required this.levelId,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'slovenian': slovenian,
    'english': english,
    'example': example,
    'difficulty': difficulty,
    'levelId': levelId,
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
  };

  factory Word.fromJson(Map<String, dynamic> json) => Word(
    id: json['id'] as String,
    slovenian: json['slovenian'] as String,
    english: json['english'] as String,
    example: json['example'] as String,
    difficulty: json['difficulty'] as int,
    levelId: json['levelId'] as String,
    createdAt: DateTime.parse(json['createdAt'] as String),
    updatedAt: DateTime.parse(json['updatedAt'] as String),
  );

  Word copyWith({
    String? id,
    String? slovenian,
    String? english,
    String? example,
    int? difficulty,
    String? levelId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Word(
    id: id ?? this.id,
    slovenian: slovenian ?? this.slovenian,
    english: english ?? this.english,
    example: example ?? this.example,
    difficulty: difficulty ?? this.difficulty,
    levelId: levelId ?? this.levelId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
}