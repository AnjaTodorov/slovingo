import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slovingo/models/translation.dart';

class TranslationService {
  static const String _apiKeyKey = 'gemini_api_key';

  Future<void> saveApiKey(String apiKey) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_apiKeyKey, apiKey);
  }

  Future<String?> getApiKey() async {
    final envKey = dotenv.env['GEMINI_API_KEY'];
    if (envKey != null && envKey.isNotEmpty && envKey != 'paste_key_here') {
      return envKey;
    }
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_apiKeyKey);
  }

  Future<String> translate(String text, String sourceLang, String targetLang) async {
    final apiKey = await getApiKey();
    final uid = FirebaseAuth.instance.currentUser?.uid;
    
    if (apiKey == null || apiKey.isEmpty) {
      return 'Prosim, nastavite API kljuŽ? v nastavitvah.';
    }

    try {
      final response = await http.post(
        Uri.parse('https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent?key=$apiKey'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'contents': [
            {
              'role': 'user',
              'parts': [
                {
                  'text': 'Translate the following from $sourceLang to $targetLang. Only return the translation, nothing else:\n$text'
                }
              ]
            }
          ]
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final translatedText = (data['candidates']?[0]?['content']?['parts']?[0]?['text'] ?? '').toString().trim();
        
        if (translatedText.isEmpty) {
          return 'Napaka: prazen prevod.';
        }
        
        if (uid != null) {
          await _saveToHistory(
            uid: uid,
            translation: Translation(
              id: DateTime.now().millisecondsSinceEpoch.toString(),
              sourceText: text,
              translatedText: translatedText,
              sourceLang: sourceLang,
              targetLang: targetLang,
              timestamp: DateTime.now(),
            ),
          );
        }
        
        return translatedText;
      } else {
        debugPrint('Translation error: ${response.statusCode} ${response.body}');
        return 'Napaka pri prevajanju. Preverite API kljuŽ?.';
      }
    } catch (e) {
      debugPrint('Translation exception: $e');
      return 'Napaka pri povezavi s stre_nikom.';
    }
  }

  Future<void> _saveToHistory({
    required String uid,
    required Translation translation,
  }) async {
    final col = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('translations');
    await col.doc(translation.id).set({
      'sourceText': translation.sourceText,
      'translatedText': translation.translatedText,
      'sourceLang': translation.sourceLang,
      'targetLang': translation.targetLang,
      'timestamp': translation.timestamp,
    });
  }

  Future<List<Translation>> getHistory() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return [];

    final snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('translations')
        .orderBy('timestamp', descending: true)
        .limit(50)
        .get();

    return snap.docs.map((doc) {
      final data = doc.data();
      return Translation(
        id: doc.id,
        sourceText: data['sourceText'] as String? ?? '',
        translatedText: data['translatedText'] as String? ?? '',
        sourceLang: data['sourceLang'] as String? ?? '',
        targetLang: data['targetLang'] as String? ?? '',
        timestamp: (data['timestamp'] as Timestamp?)?.toDate() ?? DateTime.now(),
      );
    }).toList();
  }

  Future<void> clearHistory() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;
    final col = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('translations');
    final snap = await col.get();
    for (final doc in snap.docs) {
      await doc.reference.delete();
    }
  }
}
