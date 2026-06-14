import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ExpenseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? get _uid => _auth.currentUser?.uid;

  CollectionReference? get _ref {
    if (_uid == null) return null;

    return _firestore.collection("users").doc(_uid).collection("expenses");
  }

  Future<void> addExpense({
    required double amount,
    required String category,
    required String paymentMethod,
    required String description,
    required DateTime date,
  }) async {
    if (_ref == null) return;

    await _ref!.add({
      "amount": amount,
      "category": category,
      "paymentMethod": paymentMethod,
      "description": description,
      "date": date,
      "createdAt": FieldValue.serverTimestamp(),
    });
  }

  Future<void> updateExpense(String id, Map<String, dynamic> data) async {
    if (_ref == null) return;
    await _ref!.doc(id).update(data);
  }

  Future<void> deleteExpense(String id) async {
    if (_ref == null) return;
    await _ref!.doc(id).delete();
  }

  Stream<QuerySnapshot>? getExpenses() {
    if (_ref == null) return null;
    return _ref!.orderBy("date", descending: true).snapshots();
  }
}
