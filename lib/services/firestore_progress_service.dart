import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:slovingo/models/progress.dart';

class FirestoreProgressService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> _progressCol(String uid) =>
      _db.collection('users').doc(uid).collection('progress');

  Future<List<Progress>> getAllProgress(String userId) async {
    final snap = await _progressCol(userId).get();
    return snap.docs.map((doc) {
      final data = doc.data();
      return Progress(
        id: '${userId}_${doc.id}',
        userId: userId,
        levelId: doc.id,
        score: data['score'] as int? ?? 0,
        completed: data['completed'] as bool? ?? false,
        attempts: data['attempts'] as int? ?? 0,
        lastAttempt: (data['lastAttempt'] as Timestamp?)?.toDate() ?? DateTime.now(),
        createdAt: DateTime.now(),
        updatedAt: (data['updatedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      );
    }).toList();
  }

  Future<void> saveProgress(Progress progress) async {
    await _progressCol(progress.userId).doc(progress.levelId).set({
      'score': progress.score,
      'completed': progress.completed,
      'attempts': progress.attempts,
      'lastAttempt': progress.lastAttempt,
      'updatedAt': DateTime.now(),
    }, SetOptions(merge: true));
  }

  Future<Progress?> getProgressByLevel(String userId, String levelId) async {
    final doc = await _progressCol(userId).doc(levelId).get();
    if (!doc.exists) return null;
    final data = doc.data()!;
    return Progress(
      id: '${userId}_$levelId',
      userId: userId,
      levelId: levelId,
      score: data['score'] as int? ?? 0,
      completed: data['completed'] as bool? ?? false,
      attempts: data['attempts'] as int? ?? 0,
      lastAttempt: (data['lastAttempt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      createdAt: DateTime.now(),
      updatedAt: (data['updatedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Future<Map<String, dynamic>> getStatistics(String userId) async {
    final snap = await _progressCol(userId).get();
    final docs = snap.docs;
    if (docs.isEmpty) {
      return {'completedLevels': 0, 'totalAttempts': 0, 'averageScore': 0};
    }

    final completedLevels = docs.where((d) => (d.data()['completed'] as bool?) == true).length;
    final totalAttempts = docs.fold<int>(0, (sum, d) => sum + (d.data()['attempts'] as int? ?? 0));
    final averageScore = docs.fold<int>(0, (sum, d) => sum + (d.data()['score'] as int? ?? 0)) ~/ docs.length;

    return {
      'completedLevels': completedLevels,
      'totalAttempts': totalAttempts,
      'averageScore': averageScore,
    };
  }
}
