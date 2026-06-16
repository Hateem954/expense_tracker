// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:expense_tracker/screens/budgets_screen.dart';
// import 'package:expense_tracker/screens/home_screen.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class NewBudgetScreen extends StatefulWidget {
//   const NewBudgetScreen({super.key});

//   @override
//   State<NewBudgetScreen> createState() => _NewBudgetScreenState();
// }

// class _NewBudgetScreenState extends State<NewBudgetScreen> {
//   final amountController = TextEditingController();

//   String selectedType = "monthly";
//   String selectedCategory = "Food";

//   final List<String> types = ["weekly", "monthly", "yearly"];
//   final List<String> categories = ["Food", "Travel", "Shopping", "Bills"];

//   // Future<void> saveBudget() async {
//   //   final user = FirebaseAuth.instance.currentUser;
//   //   if (user == null) return;

//   //   await FirebaseFirestore.instance
//   //       .collection("users")
//   //       .doc(user.uid)
//   //       .collection("budgets")
//   //       .add({
//   //         "amount": double.parse(amountController.text),
//   //         "type": selectedType,
//   //         "category": selectedCategory,
//   //         "spent": 0,
//   //         "createdAt": Timestamp.now(),
//   //       });

//   // Navigator.push(
//   //   context,
//   //   MaterialPageRoute(builder: (context) => BudgetScreen()),
//   // );
//   // }

//   Future<void> saveBudget() async {
//     final user = FirebaseAuth.instance.currentUser;
//     if (user == null) return;

//     if (amountController.text.isEmpty) return;

//     await FirebaseFirestore.instance
//         .collection("users")
//         .doc(user.uid)
//         .collection("budgets")
//         .add({
//           "amount": double.parse(amountController.text),
//           "type": selectedType,
//           "category": selectedCategory,
//           "spent": 0,
//           "createdAt": Timestamp.now(),
//         });

//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => BudgetScreen()),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xffF5F5F5),

//       appBar: AppBar(title: const Text("New Budget")),

//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             TextField(
//               controller: amountController,
//               keyboardType: TextInputType.number,
//               decoration: const InputDecoration(
//                 labelText: "Enter Budget Amount",
//               ),
//             ),

//             const SizedBox(height: 20),

//             DropdownButtonFormField(
//               value: selectedType,
//               items: types
//                   .map((e) => DropdownMenuItem(value: e, child: Text(e)))
//                   .toList(),
//               onChanged: (val) {
//                 setState(() => selectedType = val.toString());
//               },
//               decoration: const InputDecoration(labelText: "Budget Type"),
//             ),

//             const SizedBox(height: 20),

//             DropdownButtonFormField(
//               value: selectedCategory,
//               items: categories
//                   .map((e) => DropdownMenuItem(value: e, child: Text(e)))
//                   .toList(),
//               onChanged: (val) {
//                 setState(() => selectedCategory = val.toString());
//               },
//               decoration: const InputDecoration(labelText: "Category"),
//             ),

//             const SizedBox(height: 30),

//             ElevatedButton(
//               onPressed: saveBudget,
//               child: const Text("Save Budget"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/screens/budgets_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewBudgetScreen extends StatefulWidget {
  const NewBudgetScreen({super.key});

  @override
  State<NewBudgetScreen> createState() => _NewBudgetScreenState();
}

class _NewBudgetScreenState extends State<NewBudgetScreen> {
  final amountController = TextEditingController();

  String selectedType = "monthly";
  String selectedCategory = "Shopping";

  final List<String> types = ["weekly", "monthly", "yearly"];

  final List<String> categories = [
    "Food",
    "Travel",
    "Shopping",
    "Bills",
    "Entertainment",
    "Health",
  ];

  Future<void> saveBudget() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) return;

    if (amountController.text.trim().isEmpty) return;

    await FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid)
        .collection("budgets")
        .add({
          "amount": double.parse(amountController.text),
          "type": selectedType,
          "category": selectedCategory,
          "spent": 0,
          "createdAt": Timestamp.now(),
        });

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const BudgetScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F7),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// TOP ACTIONS
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Text(
                      "Cancel",
                      style: TextStyle(
                        color: Colors.teal,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                  ElevatedButton(
                    onPressed: saveBudget,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      shape: const StadiumBorder(),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                    child: const Text(
                      "Save",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              /// TITLE
              const Text(
                "New Budget",
                style: TextStyle(fontSize: 42, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 20),

              /// AMOUNT FIELD
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: TextField(
                  controller: amountController,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  style: const TextStyle(
                    fontSize: 24,
                    // fontWeight: FontWeight.bold,
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "\$100.00",
                  ),
                ),
              ),

              const SizedBox(height: 30),

              /// ASSIGNMENT
              const Text(
                "Assignment",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 12),

              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: ListTile(
                  leading: Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.sell_outlined, color: Colors.white),
                  ),

                  title: const Text("Category", style: TextStyle(fontSize: 18)),

                  trailing: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: selectedCategory,
                      icon: const Icon(Icons.chevron_right),
                      items: categories.map((item) {
                        return DropdownMenuItem(value: item, child: Text(item));
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedCategory = value!;
                        });
                      },
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              /// INTERVAL
              const Text(
                "Interval",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 12),

              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: ListTile(
                  leading: Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.repeat, color: Colors.white),
                  ),

                  title: const Text("Repeat", style: TextStyle(fontSize: 18)),

                  trailing: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: selectedType,
                      icon: const Icon(Icons.chevron_right),
                      items: types.map((item) {
                        return DropdownMenuItem(
                          value: item,
                          child: Text(
                            item[0].toUpperCase() + item.substring(1),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedType = value!;
                        });
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
