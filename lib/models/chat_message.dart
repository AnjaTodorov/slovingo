class ChatMessage {
  final String id;
  final String userId;
  final String message;
  final bool isUser;
  final DateTime timestamp;
  final DateTime createdAt;

  ChatMessage({
    required this.id,
    required this.userId,
    required this.message,
    required this.isUser,
    required this.timestamp,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'userId': userId,
    'message': message,
    'isUser': isUser ? 1 : 0,
    'timestamp': timestamp.toIso8601String(),
    'createdAt': createdAt.toIso8601String(),
  };

  factory ChatMessage.fromJson(Map<String, dynamic> json) => ChatMessage(
    id: json['id'] as String,
    userId: json['userId'] as String,
    message: json['message'] as String,
    isUser: (json['isUser'] is int ? json['isUser'] == 1 : json['isUser']) as bool,
    timestamp: DateTime.parse(json['timestamp'] as String),
    createdAt: DateTime.parse(json['createdAt'] as String),
  );

  ChatMessage copyWith({
    String? id,
    String? userId,
    String? message,
    bool? isUser,
    DateTime? timestamp,
    DateTime? createdAt,
  }) => ChatMessage(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    message: message ?? this.message,
    isUser: isUser ?? this.isUser,
    timestamp: timestamp ?? this.timestamp,
    createdAt: createdAt ?? this.createdAt,
  );
}