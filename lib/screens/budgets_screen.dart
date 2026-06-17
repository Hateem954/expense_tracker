// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:expense_tracker/providers/currency_services.dart';
// import 'package:expense_tracker/screens/create_budget.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class BudgetScreen extends StatefulWidget {
//   const BudgetScreen({super.key});

//   @override
//   State<BudgetScreen> createState() => _BudgetScreenState();
// }

// class _BudgetScreenState extends State<BudgetScreen> {
//   final user = FirebaseAuth.instance.currentUser;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xffF5F5F7),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               /// TOP ROW
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Container(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 18,
//                       vertical: 13,
//                     ),
//                     decoration: BoxDecoration(
//                       color: Colors.teal.withOpacity(.1),
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: Text(
//                       "Year ${DateTime.now().year}",
//                       style: const TextStyle(
//                         color: Colors.teal,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ),
//                   Spacer(),
//                   GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => const NewBudgetScreen(),
//                         ),
//                       );
//                     },

//                     child: CircleAvatar(
//                       radius: 23,
//                       backgroundColor: Colors.white,
//                       child: Icon(Icons.add, color: Colors.teal.shade400),
//                     ),
//                   ),
//                   SizedBox(width: 10.w),
//                   GestureDetector(
//                     onTap: () {
//                       // Navigator.push(
//                       //   context,
//                       //   MaterialPageRoute(
//                       //     builder: (context) => const NewBudgetScreen(),
//                       //   ),
//                       // );
//                       print("edit icon tapped");
//                     },
//                     child: CircleAvatar(
//                       radius: 23,
//                       backgroundColor: Colors.white,
//                       child: Icon(Icons.edit, color: Colors.teal.shade400),
//                     ),
//                   ),
//                 ],
//               ),

//               const SizedBox(height: 20),

//               const Text(
//                 "Your Budgets",
//                 style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
//               ),

//               const SizedBox(height: 20),

//               /// 🔥 FULLY REACTIVE CURRENCY + FIRESTORE
//               Expanded(
//                 child: ValueListenableBuilder<String>(
//                   valueListenable: CurrencyService.currencyNotifier,
//                   builder: (context, selectedCurrency, child) {
//                     return StreamBuilder<QuerySnapshot>(
//                       stream: FirebaseFirestore.instance
//                           .collection("users")
//                           .doc(user!.uid)
//                           .collection("budgets")
//                           .orderBy("createdAt", descending: true)
//                           .snapshots(),
//                       builder: (context, snapshot) {
//                         if (!snapshot.hasData) {
//                           return const Center(
//                             child: CircularProgressIndicator(),
//                           );
//                         }

//                         final docs = snapshot.data!.docs;

//                         List<Map<String, dynamic>> weekly = [];
//                         List<Map<String, dynamic>> monthly = [];
//                         List<Map<String, dynamic>> yearly = [];

//                         double totalPlanned = 0;
//                         double totalSpent = 0;

//                         for (var doc in docs) {
//                           final data = doc.data() as Map<String, dynamic>;

//                           totalPlanned += (data["amount"] ?? 0).toDouble();
//                           totalSpent += (data["spent"] ?? 0).toDouble();

//                           if (data["type"] == "weekly") {
//                             weekly.add(data);
//                           } else if (data["type"] == "monthly") {
//                             monthly.add(data);
//                           } else if (data["type"] == "yearly") {
//                             yearly.add(data);
//                           }
//                         }

//                         final totalAvailable = totalPlanned - totalSpent;

//                         return SingleChildScrollView(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               /// SUMMARY
//                               Row(
//                                 children: [
//                                   _summaryCard(
//                                     title: "Planned",
//                                     amount:
//                                         "${CurrencyService.getCurrencySymbol(selectedCurrency)} ${totalPlanned.toStringAsFixed(2)}",
//                                     icon: Icons.remove_circle_outline,
//                                   ),
//                                   const SizedBox(width: 12),
//                                   _summaryCard(
//                                     title: "Available",
//                                     amount:
//                                         "${CurrencyService.getCurrencySymbol(selectedCurrency)} ${totalAvailable.toStringAsFixed(2)}",
//                                     icon: Icons.check_circle_outline,
//                                   ),
//                                 ],
//                               ),

//                               const SizedBox(height: 16),

//                               /// STATUS
//                               Container(
//                                 width: double.infinity,
//                                 padding: const EdgeInsets.all(16),
//                                 decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   borderRadius: BorderRadius.circular(16),
//                                 ),
//                                 child: Text(
//                                   totalAvailable >= 0
//                                       ? "You are within your budget! 🎉"
//                                       : "You are over your budget! ⚠️",
//                                   style: const TextStyle(
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                 ),
//                               ),

//                               const SizedBox(height: 20),

//                               _sectionTitle("Weekly"),
//                               ...weekly
//                                   .map((e) => _budgetCard(e, selectedCurrency))
//                                   .toList(),

//                               const SizedBox(height: 20),

//                               _sectionTitle("Monthly"),
//                               ...monthly
//                                   .map((e) => _budgetCard(e, selectedCurrency))
//                                   .toList(),

//                               const SizedBox(height: 20),

//                               _sectionTitle("Yearly"),
//                               ...yearly
//                                   .map((e) => _budgetCard(e, selectedCurrency))
//                                   .toList(),
//                             ],
//                           ),
//                         );
//                       },
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   /// SUMMARY CARD
//   Widget _summaryCard({
//     required String title,
//     required String amount,
//     required IconData icon,
//   }) {
//     return Expanded(
//       child: Container(
//         padding: const EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(16),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   style: const TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 const SizedBox(height: 6),
//                 Text(
//                   amount,
//                   style: const TextStyle(
//                     color: Color(0xff7CC6B2),
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ],
//             ),
//             CircleAvatar(
//               radius: 12,
//               backgroundColor: Colors.grey.shade200,
//               child: Icon(icon, size: 14),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   /// SECTION TITLE
//   Widget _sectionTitle(String title) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 10),
//       child: Text(
//         title,
//         style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
//       ),
//     );
//   }

//   /// BUDGET CARD (FIXED)
//   // Widget _budgetCard(Map<String, dynamic> data, String selectedCurrency) {
//   //   double amount = (data["amount"] ?? 0).toDouble();
//   //   double spent = (data["spent"] ?? 0).toDouble();
//   //   double progress = amount == 0 ? 0 : spent / amount;

//   //   return Container(
//   //     margin: const EdgeInsets.only(bottom: 12),
//   //     decoration: BoxDecoration(
//   //       color: Colors.white,
//   //       borderRadius: BorderRadius.circular(18),
//   //     ),
//   //     child: Column(
//   //       children: [
//   //         ListTile(
//   //           leading: Container(
//   //             width: 46,
//   //             height: 46,
//   //             decoration: BoxDecoration(
//   //               color: Colors.teal,
//   //               borderRadius: BorderRadius.circular(12),
//   //             ),
//   //             child: const Icon(Icons.wallet, color: Colors.white),
//   //           ),
//   //           title: Text(data["category"] ?? ""),
//   //           subtitle: Text(data["type"] ?? ""),
//   //           trailing: Text(
//   //             "${CurrencyService.getCurrencySymbol(selectedCurrency)} ${amount.toStringAsFixed(2)}",
//   //             style: const TextStyle(
//   //               fontWeight: FontWeight.bold,
//   //               color: Colors.teal,
//   //             ),
//   //           ),
//   //         ),
//   //         Padding(
//   //           padding: const EdgeInsets.symmetric(horizontal: 16),
//   //           child: LinearProgressIndicator(
//   //             value: progress > 1 ? 1 : progress,
//   //             minHeight: 6,
//   //             backgroundColor: Colors.grey.shade300,
//   //             color: Colors.teal,
//   //           ),
//   //         ),
//   //         const SizedBox(height: 12),
//   //       ],
//   //     ),
//   //   );
//   // }

//   Widget _budgetCard(Map<String, dynamic> data, String selectedCurrency) {
//     double amount = (data["amount"] ?? 0).toDouble();
//     double spent = (data["spent"] ?? 0).toDouble();

//     if (amount <= 0) amount = 1; // prevent divide error

//     double percent = (spent / amount) * 100;

//     if (percent.isNaN || percent.isInfinite) percent = 0;

//     bool isOver = percent > 100;

//     double progress = percent / 100;
//     if (progress > 1) progress = 1;
//     if (progress < 0) progress = 0;

//     return Container(
//       margin: const EdgeInsets.only(bottom: 12),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(18),
//       ),
//       child: Column(
//         children: [
//           ListTile(
//             leading: Container(
//               width: 46,
//               height: 46,
//               decoration: BoxDecoration(
//                 color: Colors.teal,
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: const Icon(Icons.wallet, color: Colors.white),
//             ),
//             title: Text(data["category"] ?? ""),
//             subtitle: Text(data["type"] ?? ""),
//             trailing: Column(
//               crossAxisAlignment: CrossAxisAlignment.end,
//               children: [
//                 Text(
//                   "${percent.toStringAsFixed(1)}%",
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     color: isOver ? Colors.red : Colors.teal,
//                   ),
//                 ),
//                 Text(
//                   "${CurrencyService.getCurrencySymbol(selectedCurrency)} "
//                   "${spent.toStringAsFixed(2)} / ${amount.toStringAsFixed(2)}",
//                   style: const TextStyle(fontSize: 12),
//                 ),
//               ],
//             ),
//           ),

//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             child: LinearProgressIndicator(
//               value: progress,
//               minHeight: 8,
//               backgroundColor: Colors.grey.shade300,
//               color: isOver ? Colors.red : Colors.teal,
//             ),
//           ),

//           const SizedBox(height: 12),
//         ],
//       ),
//     );
//   }
// }
// oook code hai
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:expense_tracker/providers/currency_services.dart';
// import 'package:expense_tracker/screens/create_budget.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class BudgetScreen extends StatefulWidget {
//   const BudgetScreen({super.key});

//   @override
//   State<BudgetScreen> createState() => _BudgetScreenState();
// }

// class _BudgetScreenState extends State<BudgetScreen> {
//   final user = FirebaseAuth.instance.currentUser;

//   // ✅ EDIT BUDGET AMOUNT
//   Future<void> _editBudgetAmount(String docId, double currentAmount) async {
//     final controller = TextEditingController(text: currentAmount.toString());

//     await showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text("Edit Budget Amount"),
//           content: TextField(
//             controller: controller,
//             keyboardType: TextInputType.number,
//             decoration: const InputDecoration(hintText: "Enter new amount"),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: const Text("Cancel"),
//             ),
//             ElevatedButton(
//               onPressed: () async {
//                 final newAmount =
//                     double.tryParse(controller.text.trim()) ?? currentAmount;

//                 await FirebaseFirestore.instance
//                     .collection("users")
//                     .doc(user!.uid)
//                     .collection("budgets")
//                     .doc(docId)
//                     .update({"amount": newAmount});

//                 if (mounted) Navigator.pop(context);
//               },
//               child: const Text("Update"),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xffF5F5F7),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               /// TOP BAR
//               Row(
//                 children: [
//                   Container(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 18,
//                       vertical: 13,
//                     ),
//                     decoration: BoxDecoration(
//                       color: Colors.teal.withOpacity(.1),
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: Text(
//                       "Year ${DateTime.now().year}",
//                       style: const TextStyle(
//                         color: Colors.teal,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ),
//                   const Spacer(),

//                   GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => const NewBudgetScreen(),
//                         ),
//                       );
//                     },
//                     child: CircleAvatar(
//                       radius: 23,
//                       backgroundColor: Colors.white,
//                       child: Icon(Icons.add, color: Colors.teal.shade400),
//                     ),
//                   ),
//                   SizedBox(),
//                   GestureDetector(
//                     onTap: () {
//                       // Navigator.push(
//                       //   context,
//                       //   MaterialPageRoute(
//                       //     builder: (context) => const NewBudgetScreen(),
//                       //   ),
//                       // );
//                     },
//                     child: CircleAvatar(
//                       radius: 23,
//                       backgroundColor: Colors.white,
//                       child: Icon(Icons.edit, color: Colors.teal.shade400),
//                     ),
//                   ),
//                 ],
//               ),

//               const SizedBox(height: 20),

//               const Text(
//                 "Your Budgets",
//                 style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
//               ),

//               const SizedBox(height: 20),

//               /// STREAM
//               Expanded(
//                 child: ValueListenableBuilder<String>(
//                   valueListenable: CurrencyService.currencyNotifier,
//                   builder: (context, selectedCurrency, child) {
//                     return StreamBuilder<QuerySnapshot>(
//                       stream: FirebaseFirestore.instance
//                           .collection("users")
//                           .doc(user!.uid)
//                           .collection("budgets")
//                           .orderBy("createdAt", descending: true)
//                           .snapshots(),
//                       builder: (context, snapshot) {
//                         if (!snapshot.hasData) {
//                           return const Center(
//                             child: CircularProgressIndicator(),
//                           );
//                         }

//                         final docs = snapshot.data!.docs.map((doc) {
//                           final data = doc.data() as Map<String, dynamic>;
//                           data["id"] = doc.id;
//                           return data;
//                         }).toList();

//                         List<Map<String, dynamic>> weekly = [];
//                         List<Map<String, dynamic>> monthly = [];
//                         List<Map<String, dynamic>> yearly = [];

//                         double totalPlanned = 0;
//                         double totalSpent = 0;

//                         for (var data in docs) {
//                           totalPlanned += (data["amount"] ?? 0).toDouble();
//                           totalSpent += (data["spent"] ?? 0).toDouble();

//                           if (data["type"] == "weekly") {
//                             weekly.add(data);
//                           } else if (data["type"] == "monthly") {
//                             monthly.add(data);
//                           } else {
//                             yearly.add(data);
//                           }
//                         }

//                         double totalAvailable = totalPlanned - totalSpent;

//                         return SingleChildScrollView(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               /// SUMMARY
//                               Row(
//                                 children: [
//                                   _summaryCard(
//                                     title: "Planned",
//                                     amount:
//                                         "${CurrencyService.getCurrencySymbol(selectedCurrency)} ${totalPlanned.toStringAsFixed(2)}",
//                                     icon: Icons.remove_circle_outline,
//                                   ),
//                                   const SizedBox(width: 12),
//                                   _summaryCard(
//                                     title: "Available",
//                                     amount:
//                                         "${CurrencyService.getCurrencySymbol(selectedCurrency)} ${totalAvailable.toStringAsFixed(2)}",
//                                     icon: Icons.check_circle_outline,
//                                   ),
//                                 ],
//                               ),

//                               const SizedBox(height: 20),

//                               _sectionTitle("Weekly"),
//                               ...weekly.map(
//                                 (e) => _budgetCard(e, selectedCurrency),
//                               ),

//                               _sectionTitle("Monthly"),
//                               ...monthly.map(
//                                 (e) => _budgetCard(e, selectedCurrency),
//                               ),

//                               _sectionTitle("Yearly"),
//                               ...yearly.map(
//                                 (e) => _budgetCard(e, selectedCurrency),
//                               ),
//                             ],
//                           ),
//                         );
//                       },
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   /// SUMMARY CARD
//   Widget _summaryCard({
//     required String title,
//     required String amount,
//     required IconData icon,
//   }) {
//     return Expanded(
//       child: Container(
//         padding: const EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(16),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   style: const TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 const SizedBox(height: 6),
//                 Text(
//                   amount,
//                   style: const TextStyle(
//                     color: Colors.teal,
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ],
//             ),
//             CircleAvatar(
//               radius: 12,
//               backgroundColor: Colors.grey.shade200,
//               child: Icon(icon, size: 14),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _sectionTitle(String title) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 10),
//       child: Text(
//         title,
//         style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
//       ),
//     );
//   }

//   /// BUDGET CARD (UPDATED WITH EDIT)
//   Widget _budgetCard(Map<String, dynamic> data, String selectedCurrency) {
//     double amount = (data["amount"] ?? 0).toDouble();
//     double spent = (data["spent"] ?? 0).toDouble();

//     if (amount <= 0) amount = 1;

//     double percent = (spent / amount) * 100;
//     if (percent.isNaN || percent.isInfinite) percent = 0;

//     bool isOver = percent > 100;

//     double progress = percent / 100;
//     if (progress > 1) progress = 1;

//     return GestureDetector(
//       onTap: () {
//         _editBudgetAmount(data["id"], amount);
//       },
//       child: Container(
//         margin: const EdgeInsets.only(bottom: 12),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(18),
//         ),
//         child: Column(
//           children: [
//             ListTile(
//               leading: Container(
//                 width: 46,
//                 height: 46,
//                 decoration: BoxDecoration(
//                   color: Colors.teal,
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: const Icon(Icons.wallet, color: Colors.white),
//               ),
//               title: Text(data["category"] ?? ""),
//               subtitle: Text(data["type"] ?? ""),
//               trailing: Column(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   Text(
//                     "${percent.toStringAsFixed(1)}%",
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       color: isOver ? Colors.red : Colors.teal,
//                     ),
//                   ),
//                   Text(
//                     "${CurrencyService.getCurrencySymbol(selectedCurrency)} "
//                     "${spent.toStringAsFixed(2)} / ${amount.toStringAsFixed(2)}",
//                     style: const TextStyle(fontSize: 12),
//                   ),
//                 ],
//               ),
//             ),

//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               child: LinearProgressIndicator(
//                 value: progress,
//                 minHeight: 8,
//                 backgroundColor: Colors.grey.shade300,
//                 color: isOver ? Colors.red : Colors.teal,
//               ),
//             ),

//             const SizedBox(height: 12),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/providers/currency_services.dart';
import 'package:expense_tracker/screens/create_budget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BudgetScreen extends StatefulWidget {
  const BudgetScreen({super.key});

  @override
  State<BudgetScreen> createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {
  final user = FirebaseAuth.instance.currentUser;

  bool isEditMode = false;

  /// controllers for each budget
  final Map<String, TextEditingController> controllers = {};

  TextEditingController _controller(String id, double amount) {
    if (!controllers.containsKey(id)) {
      controllers[id] = TextEditingController(text: amount.toStringAsFixed(2));
    }
    return controllers[id]!;
  }

  /// SAVE ALL WHEN CHECK ICON CLICKED
  Future<void> _saveAllBudgets(List<QueryDocumentSnapshot> docs) async {
    for (var doc in docs) {
      final controller = controllers[doc.id];
      if (controller == null) continue;

      final newAmount = double.tryParse(controller.text.trim()) ?? 0;

      await FirebaseFirestore.instance
          .collection("users")
          .doc(user!.uid)
          .collection("budgets")
          .doc(doc.id)
          .update({"amount": newAmount});
    }

    // ✅ clear controllers so edit fields reset properly
    controllers.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F7),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              /// TOP BAR
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 13,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.teal.withOpacity(.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "Year ${DateTime.now().year}",
                      style: const TextStyle(
                        color: Colors.teal,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  const Spacer(),

                  /// ADD BUTTON
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const NewBudgetScreen(),
                        ),
                      );
                    },
                    child: const CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(Icons.add, color: Colors.teal),
                    ),
                  ),

                  const SizedBox(width: 10),

                  /// EDIT / SAVE TOGGLE BUTTON
                  GestureDetector(
                    onTap: () async {
                      if (isEditMode) {
                        try {
                          final snapshot = await FirebaseFirestore.instance
                              .collection("users")
                              .doc(user!.uid)
                              .collection("budgets")
                              .get();

                          await _saveAllBudgets(snapshot.docs);

                          // ✅ clear controllers after save (IMPORTANT FIX)
                          controllers.clear();

                          if (!mounted) return;

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Budget updated successfully"),
                              backgroundColor: Colors.green,
                              duration: Duration(seconds: 2),
                            ),
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Failed to update budget: $e"),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      }

                      setState(() {
                        isEditMode = !isEditMode;
                      });
                    },
                    child: CircleAvatar(
                      backgroundColor: isEditMode
                          ? Colors.green.shade100
                          : Colors.white,
                      child: Icon(
                        isEditMode ? Icons.check : Icons.edit,
                        color: Colors.teal,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Your Budgets",
                  style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
                ),
              ),

              const SizedBox(height: 20),

              /// STREAM
              Expanded(
                child: ValueListenableBuilder<String>(
                  valueListenable: CurrencyService.currencyNotifier,
                  builder: (context, selectedCurrency, child) {
                    return StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection("users")
                          .doc(user!.uid)
                          .collection("budgets")
                          .orderBy("createdAt", descending: true)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        final docs = snapshot.data!.docs;

                        List<Map<String, dynamic>> weekly = [];
                        List<Map<String, dynamic>> monthly = [];
                        List<Map<String, dynamic>> yearly = [];

                        double totalPlanned = 0;
                        double totalSpent = 0;

                        for (var doc in docs) {
                          final data = doc.data() as Map<String, dynamic>;

                          totalPlanned += (data["amount"] ?? 0).toDouble();
                          totalSpent += (data["spent"] ?? 0).toDouble();

                          if (data["type"] == "weekly") {
                            weekly.add({...data, "id": doc.id});
                          } else if (data["type"] == "monthly") {
                            monthly.add({...data, "id": doc.id});
                          } else {
                            yearly.add({...data, "id": doc.id});
                          }
                        }

                        double totalAvailable = totalPlanned - totalSpent;

                        return SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /// SUMMARY
                              Row(
                                children: [
                                  _summaryCard(
                                    title: "Planned",
                                    amount:
                                        "${CurrencyService.getCurrencySymbol(selectedCurrency)} ${totalPlanned.toStringAsFixed(2)}",
                                    icon: Icons.remove_circle_outline,
                                  ),
                                  const SizedBox(width: 12),
                                  _summaryCard(
                                    title: "Available",
                                    amount:
                                        "${CurrencyService.getCurrencySymbol(selectedCurrency)} ${totalAvailable.toStringAsFixed(2)}",
                                    icon: Icons.check_circle_outline,
                                  ),
                                ],
                              ),

                              const SizedBox(height: 20),

                              _sectionTitle("Weekly"),
                              ...weekly.map(
                                (e) => _budgetCard(e, selectedCurrency),
                              ),

                              _sectionTitle("Monthly"),
                              ...monthly.map(
                                (e) => _budgetCard(e, selectedCurrency),
                              ),

                              _sectionTitle("Yearly"),
                              ...yearly.map(
                                (e) => _budgetCard(e, selectedCurrency),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// SUMMARY CARD
  Widget _summaryCard({
    required String title,
    required String amount,
    required IconData icon,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  amount,
                  style: const TextStyle(
                    color: Colors.teal,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            CircleAvatar(
              radius: 12,
              backgroundColor: Colors.grey.shade200,
              child: Icon(icon, size: 14),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
      ),
    );
  }

  /// BUDGET CARD (EDIT MODE SUPPORT)
  Widget _budgetCard(Map<String, dynamic> data, String selectedCurrency) {
    final id = data["id"];
    double amount = (data["amount"] ?? 0).toDouble();
    double spent = (data["spent"] ?? 0).toDouble();

    if (amount <= 0) amount = 1;

    double percent = (spent / amount) * 100;
    bool isOver = percent > 100;

    double progress = percent / 100;
    if (progress > 1) progress = 1;

    final controller = _controller(id, amount);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          ListTile(
            leading: Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: Colors.teal,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.wallet, color: Colors.white),
            ),
            title: Text(data["category"] ?? ""),
            subtitle: Text(data["type"] ?? ""),

            /// RIGHT SIDE
            trailing: isEditMode
                ? SizedBox(
                    width: 80,
                    child: TextField(
                      controller: controller,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "${percent.toStringAsFixed(1)}%",
                        style: TextStyle(
                          color: isOver ? Colors.red : Colors.teal,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "${CurrencyService.getCurrencySymbol(selectedCurrency)} "
                        "${spent.toStringAsFixed(2)} / ${amount.toStringAsFixed(2)}",
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              backgroundColor: Colors.grey.shade300,
              color: isOver ? Colors.red : Colors.teal,
            ),
          ),

          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
