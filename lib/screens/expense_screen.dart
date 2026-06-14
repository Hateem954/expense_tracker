import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/providers/expense_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({super.key});

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  final ExpenseService service = ExpenseService();

  void _showExpenseSheet({DocumentSnapshot? doc}) {
    final isEdit = doc != null;

    final amountController = TextEditingController(
      text: isEdit ? doc!["amount"].toString() : "",
    );
    final descriptionController = TextEditingController(
      text: isEdit ? doc!["description"] ?? "" : "",
    );

    String category = isEdit ? doc!["category"] : "Food";
    String paymentMethod = isEdit ? doc!["paymentMethod"] : "Cash";

    DateTime date = isEdit
        ? (doc!["date"] as Timestamp).toDate()
        : DateTime.now();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateModal) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                left: 16.w,
                right: 16.w,
                top: 20.h,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      isEdit ? "Edit Expense" : "Add Expense",
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    TextField(
                      controller: amountController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: "Amount"),
                    ),

                    DropdownButtonFormField(
                      value: category,
                      items: ["Food", "Transport", "Shopping", "Bills", "Other"]
                          .map(
                            (e) => DropdownMenuItem(value: e, child: Text(e)),
                          )
                          .toList(),
                      onChanged: (value) {
                        setStateModal(() {
                          category = value!;
                        });
                      },
                      decoration: const InputDecoration(labelText: "Category"),
                    ),

                    DropdownButtonFormField(
                      value: paymentMethod,
                      items: ["Cash", "Card", "Bank", "JazzCash", "Easypaisa"]
                          .map(
                            (e) => DropdownMenuItem(value: e, child: Text(e)),
                          )
                          .toList(),
                      onChanged: (value) {
                        setStateModal(() {
                          paymentMethod = value!;
                        });
                      },
                      decoration: const InputDecoration(
                        labelText: "Payment Method",
                      ),
                    ),

                    TextField(
                      controller: descriptionController,
                      decoration: const InputDecoration(
                        labelText: "Description",
                      ),
                    ),

                    SizedBox(height: 20.h),

                    ElevatedButton(
                      onPressed: () async {
                        if (amountController.text.isEmpty) return;

                        if (isEdit) {
                          await service.updateExpense(doc!.id, {
                            "amount":
                                double.tryParse(amountController.text) ?? 0,
                            "category": category,
                            "paymentMethod": paymentMethod,
                            "description": descriptionController.text,
                            "date": date,
                          });
                        } else {
                          await service.addExpense(
                            amount: double.tryParse(amountController.text) ?? 0,
                            category: category,
                            paymentMethod: paymentMethod,
                            description: descriptionController.text,
                            date: date,
                          );
                        }

                        Navigator.pop(context);
                      },
                      child: Text(isEdit ? "Update" : "Save"),
                    ),

                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),

      appBar: AppBar(title: const Text("Expense Manager"), centerTitle: true),

      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff1D2433),
        onPressed: () => _showExpenseSheet(),
        child: const Icon(Icons.add),
      ),

      body: StreamBuilder<QuerySnapshot>(
        stream: service.getExpenses(),

        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text("Something went wrong with Firestore"),
            );
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No Expenses Found"));
          }

          final docs = snapshot.data!.docs;

          double total = docs.fold(
            0,
            (sum, doc) => sum + (doc["amount"] as num).toDouble(),
          );

          return Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              children: [
                /// TOTAL CARD
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20.w),
                  decoration: BoxDecoration(
                    color: const Color(0xff1D2433),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Total Expenses",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16.sp,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        "Rs ${total.toStringAsFixed(0)}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20.h),

                Expanded(
                  child: ListView.builder(
                    itemCount: docs.length,
                    itemBuilder: (context, index) {
                      final data = docs[index];

                      return Container(
                        margin: EdgeInsets.only(bottom: 12.h),
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  data["category"],
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "Rs ${data["amount"]}",
                                  style: const TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 5.h),

                            Text(data["description"] ?? ""),

                            SizedBox(height: 10.h),

                            Row(
                              children: [
                                Text(data["paymentMethod"]),
                                const Spacer(),
                                Text(
                                  (data["date"] as Timestamp)
                                      .toDate()
                                      .toString()
                                      .split(" ")[0],
                                ),
                              ],
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Colors.blue,
                                  ),
                                  onPressed: () => _showExpenseSheet(doc: data),
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  onPressed: () =>
                                      service.deleteExpense(data.id),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
