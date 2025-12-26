class Progress {
  final String id;
  final String userId;
  final String levelId;
  final int score;
  final bool completed;
  final int attempts;
  final DateTime lastAttempt;
  final DateTime createdAt;
  final DateTime updatedAt;

  Progress({
    required this.id,
    required this.userId,
    required this.levelId,
    this.score = 0,
    this.completed = false,
    this.attempts = 0,
    required this.lastAttempt,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'userId': userId,
    'levelId': levelId,
    'score': score,
    'completed': completed ? 1 : 0,
    'attempts': attempts,
    'lastAttempt': lastAttempt.toIso8601String(),
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
  };

  factory Progress.fromJson(Map<String, dynamic> json) => Progress(
    id: json['id'] as String,
    userId: json['userId'] as String,
    levelId: json['levelId'] as String,
    score: json['score'] as int? ?? 0,
    completed: (json['completed'] is int ? json['completed'] == 1 : json['completed']) as bool,
    attempts: json['attempts'] as int? ?? 0,
    lastAttempt: DateTime.parse(json['lastAttempt'] as String),
    createdAt: DateTime.parse(json['createdAt'] as String),
    updatedAt: DateTime.parse(json['updatedAt'] as String),
  );

  Progress copyWith({
    String? id,
    String? userId,
    String? levelId,
    int? score,
    bool? completed,
    int? attempts,
    DateTime? lastAttempt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Progress(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    levelId: levelId ?? this.levelId,
    score: score ?? this.score,
    completed: completed ?? this.completed,
    attempts: attempts ?? this.attempts,
    lastAttempt: lastAttempt ?? this.lastAttempt,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
}