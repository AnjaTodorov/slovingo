import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:slovingo/models/translation.dart';
import 'package:flutter/foundation.dart';

class TranslationService {
  static const String _translationsKey = 'translations_history';
  static const String _apiKeyKey = 'openai_api_key';

  Future<void> saveApiKey(String apiKey) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_apiKeyKey, apiKey);
  }

  Future<String?> getApiKey() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_apiKeyKey);
  }

  Future<String> translate(String text, String sourceLang, String targetLang) async {
    final apiKey = await getApiKey();
    
    if (apiKey == null || apiKey.isEmpty) {
      return 'Prosim, nastavite API ključ v nastavitvah.';
    }

    try {
      final response = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
        body: jsonEncode({
          'model': 'gpt-3.5-turbo',
          'messages': [
            {
              'role': 'system',
              'content': 'You are a translator. Translate the given text from $sourceLang to $targetLang. Only provide the translation, nothing else.'
            },
            {
              'role': 'user',
              'content': text
            }
          ],
          'temperature': 0.3,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final translatedText = data['choices'][0]['message']['content'].trim();
        
        await _saveToHistory(Translation(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          sourceText: text,
          translatedText: translatedText,
          sourceLang: sourceLang,
          targetLang: targetLang,
          timestamp: DateTime.now(),
        ));
        
        return translatedText;
      } else {
        debugPrint('Translation error: ${response.statusCode} ${response.body}');
        return 'Napaka pri prevajanju. Preverite API ključ.';
      }
    } catch (e) {
      debugPrint('Translation exception: $e');
      return 'Napaka pri povezavi s strežnikom.';
    }
  }

  Future<void> _saveToHistory(Translation translation) async {
    final prefs = await SharedPreferences.getInstance();
    final historyJson = prefs.getString(_translationsKey);
    
    List<Translation> history = [];
    if (historyJson != null) {
      try {
        final List<dynamic> decoded = jsonDecode(historyJson);
        history = decoded.map((json) => Translation.fromJson(json)).toList();
      } catch (e) {
        history = [];
      }
    }
    
    history.insert(0, translation);
    if (history.length > 50) {
      history = history.sublist(0, 50);
    }
    
    final updatedJson = history.map((t) => t.toJson()).toList();
    await prefs.setString(_translationsKey, jsonEncode(updatedJson));
  }

  Future<List<Translation>> getHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final historyJson = prefs.getString(_translationsKey);
    if (historyJson == null) return [];
    
    try {
      final List<dynamic> decoded = jsonDecode(historyJson);
      return decoded.map((json) => Translation.fromJson(json)).toList();
    } catch (e) {
      return [];
    }
  }

  Future<void> clearHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_translationsKey);
  }
}