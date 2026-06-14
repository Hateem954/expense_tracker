import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/user_profile_model.dart';

class ProfileService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<void> saveProfile(UserProfileModel profile) async {
    final user = _auth.currentUser;

    if (user == null) return;

    await _firestore
        .collection("users")
        .doc(user.uid)
        .set(profile.toMap(), SetOptions(merge: true));
  }

  static Future<UserProfileModel?> getProfile() async {
    final user = _auth.currentUser;

    if (user == null) return null;

    final doc = await _firestore.collection("users").doc(user.uid).get();

    if (!doc.exists) return null;

    return UserProfileModel.fromMap(doc.data()!);
  }

  static String getCurrentEmail() {
    return FirebaseAuth.instance.currentUser?.email ?? "";
  }
}
