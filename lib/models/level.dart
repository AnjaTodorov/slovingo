class Level {
  final String id;
  final int levelNumber;
  final String title;
  final String description;
  final String levelCategory; // lesson | quiz | test
  final bool isLocked;
  final List<String> wordIds;
  final int requiredScore;
  final DateTime createdAt;
  final DateTime updatedAt;

  Level({
    required this.id,
    required this.levelNumber,
    required this.title,
    required this.description,
    this.levelCategory = 'lesson',
    this.isLocked = true,
    required this.wordIds,
    this.requiredScore = 70,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'levelNumber': levelNumber,
    'title': title,
    'description': description,
    'levelCategory': levelCategory,
    'isLocked': isLocked ? 1 : 0,
    'wordIds': wordIds.join(','),
    'requiredScore': requiredScore,
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
  };

  factory Level.fromJson(Map<String, dynamic> json) => Level(
    id: json['id'] as String,
    levelNumber: json['levelNumber'] as int,
    title: json['title'] as String,
    description: json['description'] as String,
    levelCategory: (json['levelCategory'] as String?) ?? 'lesson',
    isLocked: (json['isLocked'] is int ? json['isLocked'] == 1 : json['isLocked']) as bool,
    wordIds: (json['wordIds'] as String).split(','),
    requiredScore: json['requiredScore'] as int? ?? 70,
    createdAt: DateTime.parse(json['createdAt'] as String),
    updatedAt: DateTime.parse(json['updatedAt'] as String),
  );

  Level copyWith({
    String? id,
    int? levelNumber,
    String? title,
    String? description,
    String? levelCategory,
    bool? isLocked,
    List<String>? wordIds,
    int? requiredScore,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Level(
    id: id ?? this.id,
    levelNumber: levelNumber ?? this.levelNumber,
    title: title ?? this.title,
    description: description ?? this.description,
    levelCategory: levelCategory ?? this.levelCategory,
    isLocked: isLocked ?? this.isLocked,
    wordIds: wordIds ?? this.wordIds,
    requiredScore: requiredScore ?? this.requiredScore,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
}
