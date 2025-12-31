import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:slovingo/models/user.dart' as local;

class FirestoreUserService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _users =>
      _db.collection('users');

  Future<local.User?> getUser(String uid) async {
    final doc = await _users.doc(uid).get();
    if (!doc.exists) return null;
    final data = doc.data()!;
    return local.User(
      id: uid,
      name: data['name'] as String? ?? '',
      email: data['email'] as String? ?? '',
      currentLevel: data['level'] as int? ?? 1,
      totalPoints: data['xp'] as int? ?? 0,
      streak: data['streak'] as int? ?? 0,
      lastActive: (data['updatedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      updatedAt: (data['updatedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Future<void> upsertUser(local.User user) async {
    final now = DateTime.now();
    await _users.doc(user.id).set({
      'email': user.email,
      'name': user.name,
      'level': user.currentLevel,
      'xp': user.totalPoints,
      'streak': user.streak,
      'createdAt': user.createdAt,
      'updatedAt': now,
    }, SetOptions(merge: true));
  }
}
