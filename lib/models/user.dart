class User {
  final String id;
  final String name;
  final String email;
  final int currentLevel;
  final int totalPoints;
  final int streak;
  final DateTime lastActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.currentLevel = 1,
    this.totalPoints = 0,
    this.streak = 0,
    required this.lastActive,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'currentLevel': currentLevel,
    'totalPoints': totalPoints,
    'streak': streak,
    'lastActive': lastActive.toIso8601String(),
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
  };

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json['id'] as String,
    name: json['name'] as String,
    email: json['email'] as String,
    currentLevel: json['currentLevel'] as int? ?? 1,
    totalPoints: json['totalPoints'] as int? ?? 0,
    streak: json['streak'] as int? ?? 0,
    lastActive: DateTime.parse(json['lastActive'] as String),
    createdAt: DateTime.parse(json['createdAt'] as String),
    updatedAt: DateTime.parse(json['updatedAt'] as String),
  );

  User copyWith({
    String? id,
    String? name,
    String? email,
    int? currentLevel,
    int? totalPoints,
    int? streak,
    DateTime? lastActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => User(
    id: id ?? this.id,
    name: name ?? this.name,
    email: email ?? this.email,
    currentLevel: currentLevel ?? this.currentLevel,
    totalPoints: totalPoints ?? this.totalPoints,
    streak: streak ?? this.streak,
    lastActive: lastActive ?? this.lastActive,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
}