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
    "Others",
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

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const BudgetScreen()),
    );
  }

  Future<void> _selectCategory() async {
    final result = await showModalBottomSheet<String>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Select Category",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              ...categories.map(
                (category) => ListTile(
                  leading: Icon(_getCategoryIcon(category)),
                  title: Text(category),
                  trailing: selectedCategory == category
                      ? const Icon(Icons.check_circle, color: Colors.teal)
                      : null,
                  onTap: () => Navigator.pop(context, category),
                ),
              ),
            ],
          ),
        );
      },
    );

    if (result != null) {
      setState(() => selectedCategory = result);
    }
  }

  Future<void> _selectType() async {
    final result = await showModalBottomSheet<String>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Budget Interval",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              ...types.map(
                (type) => ListTile(
                  leading: const Icon(Icons.repeat),
                  title: Text(type[0].toUpperCase() + type.substring(1)),
                  trailing: selectedType == type
                      ? const Icon(Icons.check_circle, color: Colors.teal)
                      : null,
                  onTap: () => Navigator.pop(context, type),
                ),
              ),
            ],
          ),
        );
      },
    );

    if (result != null) {
      setState(() => selectedType = result);
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case "Food":
        return Icons.restaurant;
      case "Travel":
        return Icons.flight;
      case "Shopping":
        return Icons.shopping_bag;
      case "Bills":
        return Icons.receipt_long;
      case "Entertainment":
        return Icons.movie;
      case "Health":
        return Icons.favorite;
      default:
        return Icons.category;
    }
  }

  Widget _tile({
    required String title,
    required String subtitle,
    required Color color,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        leading: SizedBox(
          width: 38,
          height: 38,
          child: Container(
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: Colors.white, size: 20),
          ),
        ),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.keyboard_arrow_down),
      ),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Text(
                      "Cancel",
                      style: TextStyle(color: Colors.teal, fontSize: 18),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: saveBudget,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      shape: const StadiumBorder(),
                    ),
                    child: const Text("Save"),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              const Text(
                "New Budget",
                style: TextStyle(fontSize: 38, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 20),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: TextField(
                  controller: amountController,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter amount",
                  ),
                ),
              ),

              const SizedBox(height: 30),

              const Text(
                "Assignment",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 12),

              _tile(
                title: "Category",
                subtitle: selectedCategory,
                icon: _getCategoryIcon(selectedCategory),
                color: Colors.blue,
                onTap: _selectCategory,
              ),

              const Text(
                "Interval",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 12),

              _tile(
                title: "Repeat",
                subtitle:
                    selectedType[0].toUpperCase() + selectedType.substring(1),
                icon: Icons.repeat,
                color: Colors.deepPurple,
                onTap: _selectType,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
