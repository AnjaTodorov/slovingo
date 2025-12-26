class Translation {
  final String id;
  final String sourceText;
  final String translatedText;
  final String sourceLang;
  final String targetLang;
  final DateTime timestamp;

  Translation({
    required this.id,
    required this.sourceText,
    required this.translatedText,
    required this.sourceLang,
    required this.targetLang,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'sourceText': sourceText,
    'translatedText': translatedText,
    'sourceLang': sourceLang,
    'targetLang': targetLang,
    'timestamp': timestamp.toIso8601String(),
  };

  factory Translation.fromJson(Map<String, dynamic> json) => Translation(
    id: json['id'] as String,
    sourceText: json['sourceText'] as String,
    translatedText: json['translatedText'] as String,
    sourceLang: json['sourceLang'] as String,
    targetLang: json['targetLang'] as String,
    timestamp: DateTime.parse(json['timestamp'] as String),
  );

  Translation copyWith({
    String? id,
    String? sourceText,
    String? translatedText,
    String? sourceLang,
    String? targetLang,
    DateTime? timestamp,
  }) => Translation(
    id: id ?? this.id,
    sourceText: sourceText ?? this.sourceText,
    translatedText: translatedText ?? this.translatedText,
    sourceLang: sourceLang ?? this.sourceLang,
    targetLang: targetLang ?? this.targetLang,
    timestamp: timestamp ?? this.timestamp,
  );
}