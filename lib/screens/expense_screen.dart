// import 'dart:async';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:expense_tracker/providers/expense_services.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class ExpenseScreen extends StatefulWidget {
//   const ExpenseScreen({super.key});

//   @override
//   State<ExpenseScreen> createState() => _ExpenseScreenState();
// }

// class _ExpenseScreenState extends State<ExpenseScreen> {
//   final ExpenseService service = ExpenseService();

//   final TextEditingController searchController = TextEditingController();
//   Timer? _debounce;
//   String searchQuery = "";

//   void _showExpenseSheet({DocumentSnapshot? doc}) {
//     final isEdit = doc != null;

//     final amountController = TextEditingController(
//       text: isEdit ? doc!["amount"].toString() : "",
//     );
//     final descriptionController = TextEditingController(
//       text: isEdit ? doc!["description"] ?? "" : "",
//     );

//     String category = isEdit ? doc!["category"] : "Food";
//     String paymentMethod = isEdit ? doc!["paymentMethod"] : "Cash";

//     DateTime date = isEdit
//         ? (doc!["date"] as Timestamp).toDate()
//         : DateTime.now();

//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       builder: (context) {
//         return StatefulBuilder(
//           builder: (context, setStateModal) {
//             return Padding(
//               padding: EdgeInsets.only(
//                 bottom: MediaQuery.of(context).viewInsets.bottom,
//                 left: 16.w,
//                 right: 16.w,
//                 top: 20.h,
//               ),
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     Text(
//                       isEdit ? "Edit Expense" : "Add Expense",
//                       style: TextStyle(
//                         fontSize: 20.sp,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),

//                     TextField(
//                       controller: amountController,
//                       keyboardType: TextInputType.number,
//                       decoration: const InputDecoration(labelText: "Amount"),
//                     ),

//                     DropdownButtonFormField(
//                       value: category,
//                       items: ["Food", "Transport", "Shopping", "Bills", "Other"]
//                           .map(
//                             (e) => DropdownMenuItem(value: e, child: Text(e)),
//                           )
//                           .toList(),
//                       onChanged: (value) {
//                         setStateModal(() {
//                           category = value!;
//                         });
//                       },
//                       decoration: const InputDecoration(labelText: "Category"),
//                     ),

//                     DropdownButtonFormField(
//                       value: paymentMethod,
//                       items: ["Cash", "Card", "Bank", "JazzCash", "Easypaisa"]
//                           .map(
//                             (e) => DropdownMenuItem(value: e, child: Text(e)),
//                           )
//                           .toList(),
//                       onChanged: (value) {
//                         setStateModal(() {
//                           paymentMethod = value!;
//                         });
//                       },
//                       decoration: const InputDecoration(
//                         labelText: "Payment Method",
//                       ),
//                     ),

//                     TextField(
//                       controller: descriptionController,
//                       decoration: const InputDecoration(
//                         labelText: "Description",
//                       ),
//                     ),

//                     SizedBox(height: 20.h),

//                     ElevatedButton(
//                       onPressed: () async {
//                         if (amountController.text.isEmpty) return;

//                         if (isEdit) {
//                           await service.updateExpense(doc!.id, {
//                             "amount":
//                                 double.tryParse(amountController.text) ?? 0,
//                             "category": category,
//                             "paymentMethod": paymentMethod,
//                             "description": descriptionController.text,
//                             "date": date,
//                           });
//                         } else {
//                           await service.addExpense(
//                             amount: double.tryParse(amountController.text) ?? 0,
//                             category: category,
//                             paymentMethod: paymentMethod,
//                             description: descriptionController.text,
//                             date: date,
//                           );
//                         }

//                         Navigator.pop(context);
//                       },
//                       child: Text(isEdit ? "Update" : "Save"),
//                     ),

//                     SizedBox(height: 20.h),
//                   ],
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }

//   // get category icons and colors
//   IconData getCategoryIcon(String category) {
//     switch (category) {
//       case "Food":
//         return Icons.restaurant;
//       case "Transport":
//         return Icons.directions_car;
//       case "Shopping":
//         return Icons.shopping_bag;
//       case "Bills":
//         return Icons.receipt_long;
//       default:
//         return Icons.wallet;
//     }
//   }

//   Color getCategoryColor(String category) {
//     switch (category) {
//       case "Food":
//         return Colors.orange;
//       case "Transport":
//         return Colors.blue;
//       case "Shopping":
//         return Colors.purple;
//       case "Bills":
//         return Colors.red;
//       default:
//         return Colors.green;
//     }
//   }

//   @override
//   void dispose() {
//     searchController.dispose();
//     _debounce?.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xffF5F5F5),

//       // appBar: AppBar(
//       //   automaticallyImplyLeading: false,
//       //   backgroundColor: Colors.transparent,
//       //   title: const Text("Expense Manager"),
//       //   centerTitle: true,
//       // ),
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         elevation: 0,
//         backgroundColor: Colors.transparent,
//         centerTitle: true,
//         title: const Text(
//           "Expense Manager",
//           style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
//         ),
//       ),

//       // floatingActionButton: FloatingActionButton(
//       //   backgroundColor: const Color(0xff1D2433),
//       //   onPressed: () => _showExpenseSheet(),
//       //   child: const Icon(Icons.add),
//       // ),
//       floatingActionButton: FloatingActionButton.extended(
//         backgroundColor: const Color(0xff1D2433),
//         onPressed: () => _showExpenseSheet(),
//         icon: const Icon(Icons.add, color: Colors.white),
//         label: const Text("Add Expense", style: TextStyle(color: Colors.white)),
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: service.getExpenses(),

//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           if (snapshot.hasError) {
//             return const Center(
//               child: Text("Something went wrong with Firestore"),
//             );
//           }

//           if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//             return const Center(child: Text("No Expenses Found"));
//           }

//           // final docs = snapshot.data!.docs;
//           final docs = snapshot.data!.docs.where((doc) {
//             final category = doc["category"].toString().toLowerCase();

//             final description = (doc["description"] ?? "")
//                 .toString()
//                 .toLowerCase();

//             return category.contains(searchQuery) ||
//                 description.contains(searchQuery);
//           }).toList();

//           double total = docs.fold(
//             0,
//             (sum, doc) => sum + (doc["amount"] as num).toDouble(),
//           );

//           return Padding(
//             padding: EdgeInsets.all(16.w),
//             child: Column(
//               children: [
//                 /// TOTAL CARD
//                 Container(
//                   margin: EdgeInsets.only(bottom: 15.h),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(16.r),
//                   ),
//                   child: TextField(
//                     controller: searchController,
//                     // onChanged: (value) {
//                     //   setState(() {
//                     //     searchQuery = value.toLowerCase();
//                     //   });
//                     // },
//                     onChanged: (value) {
//                       if (_debounce?.isActive ?? false) _debounce!.cancel();

//                       _debounce = Timer(const Duration(milliseconds: 500), () {
//                         setState(() {
//                           searchQuery = value.toLowerCase().trim();
//                         });
//                       });
//                     },
//                     decoration: const InputDecoration(
//                       hintText: "Search Expenses",
//                       prefixIcon: Icon(Icons.search),
//                       border: InputBorder.none,
//                     ),
//                   ),
//                 ),

//                 // Container(
//                 //   width: double.infinity,
//                 //   padding: EdgeInsets.all(20.w),
//                 //   decoration: BoxDecoration(
//                 //     color: const Color(0xff1D2433),
//                 //     borderRadius: BorderRadius.circular(20.r),
//                 //   ),
//                 //   child: Column(
//                 //     children: [
//                 //       Text(
//                 //         "Total Expenses",
//                 //         style: TextStyle(
//                 //           color: Colors.white70,
//                 //           fontSize: 16.sp,
//                 //         ),
//                 //       ),
//                 //       SizedBox(height: 10.h),
//                 //       Text(
//                 //         "Rs ${total.toStringAsFixed(0)}",
//                 //         style: TextStyle(
//                 //           color: Colors.white,
//                 //           fontSize: 28.sp,
//                 //           fontWeight: FontWeight.bold,
//                 //         ),
//                 //       ),
//                 //     ],
//                 //   ),
//                 // ),
//                 Container(
//                   width: double.infinity,
//                   padding: EdgeInsets.all(24.w),
//                   decoration: BoxDecoration(
//                     gradient: const LinearGradient(
//                       colors: [Color(0xff1D2433), Color(0xff2F3A52)],
//                     ),
//                     borderRadius: BorderRadius.circular(24.r),
//                   ),
//                   child: Column(
//                     children: [
//                       const Icon(
//                         Icons.account_balance_wallet,
//                         color: Colors.white,
//                         size: 40,
//                       ),
//                       SizedBox(height: 10.h),
//                       Text(
//                         "Total Expenses",
//                         style: TextStyle(
//                           color: Colors.white70,
//                           fontSize: 15.sp,
//                         ),
//                       ),
//                       SizedBox(height: 8.h),
//                       Text(
//                         "Rs ${total.toStringAsFixed(0)}",
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 32.sp,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 20.h),

//                 Expanded(
//                   child: ListView.builder(
//                     itemCount: docs.length,
//                     itemBuilder: (context, index) {
//                       final data = docs[index];

//                       return
//                       //  Container(
//                       //   margin: EdgeInsets.only(bottom: 12.h),
//                       //   padding: EdgeInsets.all(16.w),
//                       //   decoration: BoxDecoration(
//                       //     color: Colors.white,
//                       //     borderRadius: BorderRadius.circular(20.r),
//                       //   ),
//                       //   child: Column(
//                       //     children: [
//                       //       Row(
//                       //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       //         children: [
//                       //           Text(
//                       //             data["category"],
//                       //             style: TextStyle(
//                       //               fontSize: 18.sp,
//                       //               fontWeight: FontWeight.bold,
//                       //             ),
//                       //           ),
//                       //           Text(
//                       //             "Rs ${data["amount"]}",
//                       //             style: const TextStyle(
//                       //               color: Colors.red,
//                       //               fontWeight: FontWeight.bold,
//                       //             ),
//                       //           ),
//                       //         ],
//                       //       ),
//                       //       SizedBox(height: 5.h),
//                       //       Text(data["description"] ?? ""),
//                       //       SizedBox(height: 10.h),
//                       //       Row(
//                       //         children: [
//                       //           Text(data["paymentMethod"]),
//                       //           const Spacer(),
//                       //           Text(
//                       //             (data["date"] as Timestamp)
//                       //                 .toDate()
//                       //                 .toString()
//                       //                 .split(" ")[0],
//                       //           ),
//                       //         ],
//                       //       ),
//                       //       Row(
//                       //         mainAxisAlignment: MainAxisAlignment.end,
//                       //         children: [
//                       //           IconButton(
//                       //             icon: const Icon(
//                       //               Icons.edit,
//                       //               color: Colors.blue,
//                       //             ),
//                       //             onPressed: () => _showExpenseSheet(doc: data),
//                       //           ),
//                       //           IconButton(
//                       //             icon: const Icon(
//                       //               Icons.delete,
//                       //               color: Colors.red,
//                       //             ),
//                       //             onPressed: () =>
//                       //                 service.deleteExpense(data.id),
//                       //           ),
//                       //         ],
//                       //       ),
//                       //     ],
//                       //   ),
//                       // );
//                       Container(
//                         margin: EdgeInsets.only(bottom: 14.h),
//                         padding: EdgeInsets.all(16.w),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(18.r),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black.withOpacity(.05),
//                               blurRadius: 10,
//                               offset: const Offset(0, 4),
//                             ),
//                           ],
//                         ),
//                         child: Column(
//                           children: [
//                             Row(
//                               children: [
//                                 CircleAvatar(
//                                   backgroundColor: getCategoryColor(
//                                     data["category"],
//                                   ).withOpacity(.15),
//                                   child: Icon(
//                                     getCategoryIcon(data["category"]),
//                                     color: getCategoryColor(data["category"]),
//                                   ),
//                                 ),
//                                 SizedBox(width: 12.w),

//                                 Expanded(
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         data["category"],
//                                         style: TextStyle(
//                                           fontSize: 16.sp,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                       Text(
//                                         data["description"] ?? "",
//                                         maxLines: 1,
//                                         overflow: TextOverflow.ellipsis,
//                                         style: TextStyle(
//                                           color: Colors.grey[600],
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),

//                                 Text(
//                                   "- Rs ${data["amount"]}",
//                                   style: TextStyle(
//                                     color: Colors.red,
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 16.sp,
//                                   ),
//                                 ),
//                               ],
//                             ),

//                             SizedBox(height: 12.h),

//                             Row(
//                               children: [
//                                 Container(
//                                   padding: EdgeInsets.symmetric(
//                                     horizontal: 10.w,
//                                     vertical: 5.h,
//                                   ),
//                                   decoration: BoxDecoration(
//                                     color: Colors.grey.shade100,
//                                     borderRadius: BorderRadius.circular(20),
//                                   ),
//                                   child: Text(data["paymentMethod"]),
//                                 ),

//                                 const Spacer(),

//                                 Text(
//                                   (data["date"] as Timestamp)
//                                       .toDate()
//                                       .toString()
//                                       .split(" ")[0],
//                                   style: TextStyle(color: Colors.grey[600]),
//                                 ),
//                               ],
//                             ),

//                             SizedBox(height: 10.h),

//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.end,
//                               children: [
//                                 IconButton(
//                                   icon: const Icon(
//                                     Icons.edit,
//                                     color: Colors.blue,
//                                   ),
//                                   onPressed: () => _showExpenseSheet(doc: data),
//                                 ),
//                                 IconButton(
//                                   icon: const Icon(
//                                     Icons.delete,
//                                     color: Colors.red,
//                                   ),
//                                   onPressed: () async {
//                                     final confirm = await showDialog<bool>(
//                                       context: context,
//                                       builder: (_) => AlertDialog(
//                                         title: const Text("Delete Expense"),
//                                         content: const Text("Are you sure?"),
//                                         actions: [
//                                           TextButton(
//                                             onPressed: () =>
//                                                 Navigator.pop(context, false),
//                                             child: const Text("Cancel"),
//                                           ),
//                                           TextButton(
//                                             onPressed: () =>
//                                                 Navigator.pop(context, true),
//                                             child: const Text("Delete"),
//                                           ),
//                                         ],
//                                       ),
//                                     );

//                                     if (confirm == true) {
//                                       service.deleteExpense(data.id);
//                                     }
//                                   },
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/providers/currency_services.dart';
import 'package:expense_tracker/providers/expense_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({super.key});

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  final ExpenseService service = ExpenseService();
  final TextEditingController searchController = TextEditingController();

  Timer? _debounce;
  String searchQuery = "";

  final user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    // CurrencyService.loadCurrency();
  }

  void _showExpenseSheet({DocumentSnapshot? doc}) {
    final isEdit = doc != null;

    final amountController = TextEditingController(
      text: isEdit ? doc!["amount"].toString() : "",
    );

    final descriptionController = TextEditingController(
      text: isEdit ? (doc!["description"] ?? "") : "",
    );

    String category = isEdit ? doc!["category"] : "Food";
    String paymentMethod = isEdit ? doc!["paymentMethod"] : "Cash";

    DateTime date = isEdit
        ? (doc!["date"] as Timestamp).toDate()
        : DateTime.now();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) {
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
                      onChanged: (value) =>
                          setStateModal(() => category = value!),
                      decoration: const InputDecoration(labelText: "Category"),
                    ),

                    DropdownButtonFormField(
                      value: paymentMethod,
                      items: ["Cash", "Card", "Bank", "JazzCash", "Easypaisa"]
                          .map(
                            (e) => DropdownMenuItem(value: e, child: Text(e)),
                          )
                          .toList(),
                      onChanged: (value) =>
                          setStateModal(() => paymentMethod = value!),
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
                        final amount =
                            double.tryParse(amountController.text) ?? 0;

                        if (isEdit) {
                          await service.updateExpense(doc!.id, {
                            "amount": amount,
                            "category": category,
                            "paymentMethod": paymentMethod,
                            "description": descriptionController.text,
                            "date": date,
                          });
                        } else {
                          await service.addExpense(
                            amount: amount,
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

  IconData getCategoryIcon(String category) {
    switch (category) {
      case "Food":
        return Icons.restaurant;
      case "Transport":
        return Icons.directions_car;
      case "Shopping":
        return Icons.shopping_bag;
      case "Bills":
        return Icons.receipt_long;
      default:
        return Icons.wallet;
    }
  }

  Color getCategoryColor(String category) {
    switch (category) {
      case "Food":
        return Colors.orange;
      case "Transport":
        return Colors.blue;
      case "Shopping":
        return Colors.purple;
      case "Bills":
        return Colors.red;
      default:
        return Colors.green;
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),

      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text(
          "Expense Manager",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xff1D2433),
        onPressed: () => _showExpenseSheet(),
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text("Add Expense", style: TextStyle(color: Colors.white)),
      ),

      body: ValueListenableBuilder<String>(
        valueListenable: CurrencyService.currencyNotifier,
        builder: (context, selectedCurrency, child) {
          return StreamBuilder<QuerySnapshot>(
            stream: service.getExpenses(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Center(child: Text("No Expenses Found"));
              }

              final docs = snapshot.data!.docs.where((doc) {
                final category = doc["category"].toString().toLowerCase();
                final description = (doc["description"] ?? "")
                    .toString()
                    .toLowerCase();

                return category.contains(searchQuery) ||
                    description.contains(searchQuery);
              }).toList();

              double total = docs.fold(
                0,
                (sum, doc) => sum + (doc["amount"] as num).toDouble(),
              );

              final symbol = CurrencyService.getCurrencySymbol(
                selectedCurrency,
              );

              return Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  children: [
                    /// SEARCH
                    Container(
                      margin: EdgeInsets.only(bottom: 15.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: TextField(
                        controller: searchController,
                        onChanged: (value) {
                          if (_debounce?.isActive ?? false) {
                            _debounce!.cancel();
                          }

                          _debounce = Timer(
                            const Duration(milliseconds: 400),
                            () {
                              setState(() {
                                searchQuery = value.toLowerCase().trim();
                              });
                            },
                          );
                        },
                        decoration: const InputDecoration(
                          hintText: "Search Expenses",
                          prefixIcon: Icon(Icons.search),
                          border: InputBorder.none,
                        ),
                      ),
                    ),

                    /// TOTAL
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(24.w),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xff1D2433), Color(0xff2F3A52)],
                        ),
                        borderRadius: BorderRadius.circular(24.r),
                      ),
                      child: Column(
                        children: [
                          const Icon(Icons.wallet, color: Colors.white),
                          SizedBox(height: 10.h),
                          const Text(
                            "Total Expenses",
                            style: TextStyle(color: Colors.white70),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            "$symbol ${total.toStringAsFixed(2)}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 20.h),

                    /// LIST
                    Expanded(
                      child: ListView.builder(
                        itemCount: docs.length,
                        itemBuilder: (context, index) {
                          final data = docs[index];

                          final amount = (data["amount"] as num).toDouble();

                          return Container(
                            margin: EdgeInsets.only(bottom: 14.h),
                            padding: EdgeInsets.all(16.w),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(18.r),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: getCategoryColor(
                                        data["category"],
                                      ).withOpacity(.15),
                                      child: Icon(
                                        getCategoryIcon(data["category"]),
                                        color: getCategoryColor(
                                          data["category"],
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 12.w),

                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            data["category"],
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16.sp,
                                            ),
                                          ),
                                          Text(
                                            data["description"] ?? "",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),

                                    Text(
                                      "- $symbol ${amount.toStringAsFixed(2)}",
                                      style: const TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold,
                                      ),
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
                                      onPressed: () =>
                                          _showExpenseSheet(doc: data),
                                    ),
                                    IconButton(
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                      onPressed: () {
                                        service.deleteExpense(data.id);
                                      },
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
          );
        },
      ),
    );
  }
}
