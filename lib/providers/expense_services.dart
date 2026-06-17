// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class ExpenseService {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   String? get _uid => _auth.currentUser?.uid;

//   CollectionReference? get _ref {
//     if (_uid == null) return null;

//     return _firestore.collection("users").doc(_uid).collection("expenses");
//   }

//   Future<void> addExpense({
//     required double amount,
//     required String category,
//     required String paymentMethod,
//     required String description,
//     required DateTime date,
//   }) async {
//     if (_ref == null) return;

//     await _ref!.add({
//       "amount": amount,
//       "category": category,
//       "paymentMethod": paymentMethod,
//       "description": description,
//       "date": date,
//       "createdAt": FieldValue.serverTimestamp(),
//     });
//   }

//   Future<void> updateExpense(String id, Map<String, dynamic> data) async {
//     if (_ref == null) return;
//     await _ref!.doc(id).update(data);
//   }

//   Future<void> deleteExpense(String id) async {
//     if (_ref == null) return;
//     await _ref!.doc(id).delete();
//   }

//   Stream<QuerySnapshot>? getExpenses() {
//     if (_ref == null) return null;
//     return _ref!.orderBy("date", descending: true).snapshots();
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ExpenseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? get uid => _auth.currentUser?.uid;

  CollectionReference<Map<String, dynamic>> get expenseRef =>
      _firestore.collection("users").doc(uid).collection("expenses");

  CollectionReference<Map<String, dynamic>> get budgetRef =>
      _firestore.collection("users").doc(uid).collection("budgets");

  // ADD EXPENSE
  Future<void> addExpense({
    required double amount,
    required String category,
    required String paymentMethod,
    required String description,
    required DateTime date,
  }) async {
    if (uid == null) return;

    final normalizedCategory = category.trim();

    await expenseRef.add({
      "amount": amount,
      "category": normalizedCategory,
      "paymentMethod": paymentMethod,
      "description": description,
      "date": date,
      "createdAt": FieldValue.serverTimestamp(),
    });

    await _updateBudgetSpent(normalizedCategory, amount);
  }

  // UPDATE EXPENSE (SAFE DELTA FIX)
  Future<void> updateExpense(
    String id,
    Map<String, dynamic> newData,
    String oldCategory,
    double oldAmount,
  ) async {
    if (uid == null) return;

    final newCategory = newData["category"].toString().trim();
    final newAmount = (newData["amount"] as num).toDouble();

    await expenseRef.doc(id).update(newData);

    // remove old
    await _updateBudgetSpent(oldCategory, -oldAmount);

    // add new
    await _updateBudgetSpent(newCategory, newAmount);
  }

  // DELETE EXPENSE (SAFE FIX)
  Future<void> deleteExpense(String id, String category, double amount) async {
    if (uid == null) return;

    await expenseRef.doc(id).delete();

    await _updateBudgetSpent(category, -amount);
  }

  // 🔥 FIXED: ATOMIC UPDATE (NO MORE WRONG VALUES)
  Future<void> _updateBudgetSpent(String category, double delta) async {
    final budgets = await budgetRef
        .where("category", isEqualTo: category.trim())
        .get();

    for (var doc in budgets.docs) {
      await doc.reference.update({"spent": FieldValue.increment(delta)});
    }
  }

  Stream<QuerySnapshot> getExpenses() {
    return expenseRef.orderBy("date", descending: true).snapshots();
  }
}
