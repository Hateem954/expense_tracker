import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class IncomeService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addIncome(double amount) async {
    final userId = FirebaseAuth.instance.currentUser!.uid;

    await _db.collection("income_history").add({
      "userId": userId,
      "amount": amount,
      "date": Timestamp.now(),
    });
  }

  Stream<QuerySnapshot> getIncomeHistory() {
    final userId = FirebaseAuth.instance.currentUser!.uid;

    return _db
        .collection("income_history")
        .where("userId", isEqualTo: userId)
        .orderBy("date", descending: true)
        .snapshots();
  }
}
