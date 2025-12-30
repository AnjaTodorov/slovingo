import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:slovingo/models/chat_message.dart';
import 'package:flutter/foundation.dart';

class ChatService {
  static const String _chatKey = 'chat_messages';
  static const String _apiKeyKey = 'openai_api_key';

  Future<String?> getApiKey() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_apiKeyKey);
  }

  Future<List<ChatMessage>> getChatHistory(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    final chatJson = prefs.getString(_chatKey);
    if (chatJson == null) return [];
    
    try {
      final List<dynamic> decoded = jsonDecode(chatJson);
      final allMessages = decoded.map((json) => ChatMessage.fromJson(json)).toList();
      return allMessages.where((m) => m.userId == userId).toList();
    } catch (e) {
      return [];
    }
  }

  Future<void> saveMessage(ChatMessage message) async {
    final prefs = await SharedPreferences.getInstance();
    final chatJson = prefs.getString(_chatKey);
    
    List<ChatMessage> messages = [];
    if (chatJson != null) {
      try {
        final List<dynamic> decoded = jsonDecode(chatJson);
        messages = decoded.map((json) => ChatMessage.fromJson(json)).toList();
      } catch (e) {
        messages = [];
      }
    }
    
    messages.add(message);
    
    final updatedJson = messages.map((m) => m.toJson()).toList();
    await prefs.setString(_chatKey, jsonEncode(updatedJson));
  }

  Future<String> sendMessage(String userId, String userMessage) async {
    final apiKey = await getApiKey();
    
    if (apiKey == null || apiKey.isEmpty) {
      return 'Prosim, nastavite API ključ v nastavitvah.';
    }

    final userMsg = ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      userId: userId,
      message: userMessage,
      isUser: true,
      timestamp: DateTime.now(),
      createdAt: DateTime.now(),
    );
    await saveMessage(userMsg);

    try {
      final chatHistory = await getChatHistory(userId);
      final recentMessages = chatHistory.length > 10 
          ? chatHistory.sublist(chatHistory.length - 10) 
          : chatHistory;
      
      final messages = [
        {
          'role': 'system',
          'content': 'You are a friendly and patient Slovenian language tutor. Help users learn Slovenian by answering their questions, correcting their mistakes gently, and providing clear explanations. Use both English and Slovenian in your responses to help learners understand better.'
        },
        ...recentMessages.map((m) => {
          'role': m.isUser ? 'user' : 'assistant',
          'content': m.message,
        }),
      ];

      final response = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
        body: jsonEncode({
          'model': 'gpt-3.5-turbo',
          'messages': messages,
          'temperature': 0.7,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final aiResponse = data['choices'][0]['message']['content'].trim();
        
        final aiMsg = ChatMessage(
          id: (DateTime.now().millisecondsSinceEpoch + 1).toString(),
          userId: userId,
          message: aiResponse,
          isUser: false,
          timestamp: DateTime.now(),
          createdAt: DateTime.now(),
        );
        await saveMessage(aiMsg);
        
        return aiResponse;
      } else {
        debugPrint('Chat error: ${response.statusCode} ${response.body}');
        return 'Napaka pri komunikaciji. Preverite API ključ.';
      }
    } catch (e) {
      debugPrint('Chat exception: $e');
      return 'Napaka pri povezavi s strežnikom.';
    }
  }

  Future<void> clearHistory(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    final chatJson = prefs.getString(_chatKey);
    if (chatJson == null) return;
    
    try {
      final List<dynamic> decoded = jsonDecode(chatJson);
      final allMessages = decoded.map((json) => ChatMessage.fromJson(json)).toList();
      final otherUserMessages = allMessages.where((m) => m.userId != userId).toList();
      
      final updatedJson = otherUserMessages.map((m) => m.toJson()).toList();
      await prefs.setString(_chatKey, jsonEncode(updatedJson));
    } catch (e) {
      debugPrint('Error clearing chat history: $e');
    }
  }
}