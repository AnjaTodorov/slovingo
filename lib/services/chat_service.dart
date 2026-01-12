import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slovingo/models/chat_message.dart';

class ChatService {
  static const String _apiKeyKey = 'gemini_api_key';

  Future<String?> getApiKey() async {
    final envKey = dotenv.env['GEMINI_API_KEY'];
    if (envKey != null && envKey.isNotEmpty && envKey != 'paste_key_here') {
      return envKey;
    }
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_apiKeyKey);
  }

  Future<List<ChatMessage>> getChatHistory(String userId) async {
    final snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('chat')
        .orderBy('timestamp')
        .get();
    return snap.docs.map((doc) {
      final data = doc.data();
      return ChatMessage(
        id: doc.id,
        userId: userId,
        message: data['message'] as String? ?? '',
        isUser: data['isUser'] as bool? ?? false,
        timestamp: (data['timestamp'] as Timestamp?)?.toDate() ?? DateTime.now(),
        createdAt: (data['timestamp'] as Timestamp?)?.toDate() ?? DateTime.now(),
      );
    }).toList();
  }

  Future<void> saveMessage(String userId, ChatMessage message) async {
    final doc = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('chat')
        .doc(message.id);
    await doc.set({
      'message': message.message,
      'isUser': message.isUser,
      'timestamp': message.timestamp,
    });
  }

  Future<String> sendMessage(String userId, String userMessage) async {
    final apiKey = await getApiKey();
    if (apiKey == null || apiKey.isEmpty) {
      return 'Prosim, nastavite API kljuŽ? v nastavitvah.';
    }

    final userMsg = ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      userId: userId,
      message: userMessage,
      isUser: true,
      timestamp: DateTime.now(),
      createdAt: DateTime.now(),
    );
    await saveMessage(userId, userMsg);

    try {
      final chatHistory = await getChatHistory(userId);
      final recentMessages = chatHistory.length > 10
          ? chatHistory.sublist(chatHistory.length - 10)
          : chatHistory;

      final systemInstruction = 'You are a friendly and patient Slovenian language tutor. Help users learn Slovenian by answering their questions, correcting their mistakes gently, and providing clear explanations. Use both English and Slovenian in your responses to help learners understand better.';

      final contents = recentMessages.map((m) => {
        'role': m.isUser ? 'user' : 'model',
        'parts': [
          {'text': m.message}
        ],
      }).toList();

      final response = await http.post(
        Uri.parse('https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent?key=$apiKey'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'system_instruction': {
            'parts': [
              {'text': systemInstruction}
            ]
          },
          'contents': contents,
          'generationConfig': {'temperature': 0.7},
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final aiResponse = (data['candidates']?[0]?['content']?['parts']?[0]?['text'] ?? '').toString().trim();
        final aiMsg = ChatMessage(
          id: (DateTime.now().millisecondsSinceEpoch + 1).toString(),
          userId: userId,
          message: aiResponse.isEmpty ? 'Oprosti, poskusi znova.' : aiResponse,
          isUser: false,
          timestamp: DateTime.now(),
          createdAt: DateTime.now(),
        );
        await saveMessage(userId, aiMsg);
        return aiMsg.message;
      } else {
        debugPrint('Chat error: ${response.statusCode} ${response.body}');
        return 'Napaka pri komunikaciji. Preverite API kljuŽ?.';
      }
    } catch (e) {
      debugPrint('Chat exception: $e');
      return 'Napaka pri povezavi s stre_nikom.';
    }
  }

  Future<void> clearHistory(String userId) async {
    final col = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('chat');
    final snap = await col.get();
    for (final doc in snap.docs) {
      await doc.reference.delete();
    }
  }
}
