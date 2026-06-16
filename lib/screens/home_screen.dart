// import 'package:expense_tracker/AuthService/activitywrapper.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   int currentIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     return ActivityWrapper(
//       child: Scaffold(
//         backgroundColor: const Color(0xffF5F5F5),

//         body: IndexedStack(
//           index: currentIndex,
//           children: [
//             _homeTab(),
//             _transactionsTab(),
//             _analyticsTab(),
//             _profileTab(),
//           ],
//         ),

//         //       bottomNavigationBar: BottomNavigationBar(
//         //         currentIndex: currentIndex,
//         //         onTap: (index) {
//         //           setState(() {
//         //             currentIndex = index;
//         //           });
//         //         },
//         //         type: BottomNavigationBarType.fixed,
//         //         selectedItemColor: Colors.black,
//         //         unselectedItemColor: Colors.grey,
//         //         backgroundColor: Colors.white,
//         //         elevation: 10,
//         //         items: const [
//         //           BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
//         //           BottomNavigationBarItem(
//         //             icon: Icon(Icons.account_balance_wallet),
//         //             label: "Transactions",
//         //           ),
//         //           BottomNavigationBarItem(
//         //             icon: Icon(Icons.bar_chart),
//         //             label: "Analytics",
//         //           ),
//         //           BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
//         //         ],
//         //       ),
//         //     ),
//         //   );
//         // }
//         bottomNavigationBar: Container(
//           height: 80,
//           decoration: const BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(25),
//               topRight: Radius.circular(25),
//             ),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black12,
//                 blurRadius: 15,
//                 offset: Offset(0, -2),
//               ),
//             ],
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               _navItem(Icons.home_rounded, 0),
//               _navItem(Icons.account_balance_wallet_rounded, 1),

//               const SizedBox(width: 60),

//               _navItem(Icons.analytics_outlined, 2),
//               _navItem(Icons.person_outline, 3),
//             ],
//           ),
//         ),

//         floatingActionButton: Container(
//           height: 70,
//           width: 70,
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             color: const Color(0xff1D2433),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(.2),
//                 blurRadius: 15,
//                 offset: const Offset(0, 5),
//               ),
//             ],
//           ),

//           // child: FloatingActionButton(
//           //   elevation: 10,
//           //   backgroundColor: const Color(0xff1D2433),
//           //   onPressed: () {
//           //     // Add Transaction Screen
//           //   },
//           //   child: const Icon(Icons.add, size: 30, color: Colors.white),
//           // ),
//           child: FloatingActionButton(
//             onPressed: () {
//               // Add Transaction Screen
//             },
//             backgroundColor: const Color(0xff1D2433),
//             elevation: 8,
//             shape: const CircleBorder(),
//             child: const Icon(Icons.add, size: 30, color: Colors.white),
//           ),
//         ),

//         floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//       ),
//     );
//   }

//   Widget _navItem(IconData icon, int index) {
//     final isSelected = currentIndex == index;

//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           currentIndex = index;
//         });
//       },
//       child: Icon(
//         icon,
//         size: isSelected ? 30 : 26,
//         color: isSelected ? Colors.black : Colors.grey,
//       ),
//     );
//   }

//   String getGreeting() {
//     final hour = DateTime.now().hour;

//     if (hour >= 5 && hour < 12) {
//       return "Good Morning";
//     } else if (hour >= 12 && hour < 17) {
//       return "Good Afternoon";
//     } else if (hour >= 17 && hour < 21) {
//       return "Good Evening";
//     } else {
//       return "Good Night";
//     }
//   }

//   Widget _homeTab() {
//     return SafeArea(
//       child: SingleChildScrollView(
//         padding: EdgeInsets.all(20.w),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             /// HEADER
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // Text(
//                     //   "Good Morning!",
//                     //   style: TextStyle(color: Colors.grey, fontSize: 16.sp),
//                     // ),
//                     Text(
//                       "${getGreeting()} 👋",
//                       style: TextStyle(color: Colors.grey, fontSize: 16.sp),
//                     ),
//                     SizedBox(height: 5.h),
//                     Text(
//                       "UserName",
//                       style: TextStyle(
//                         fontSize: 26.sp,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//                 Container(
//                   height: 50.h,
//                   width: 50.w,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     shape: BoxShape.circle,
//                     boxShadow: [
//                       BoxShadow(color: Colors.black12, blurRadius: 10.r),
//                     ],
//                   ),
//                   child: const Icon(Icons.notifications_none),
//                 ),
//               ],
//             ),

//             SizedBox(height: 25.h),

//             /// BALANCE CARD
//             _balanceCard(),

//             SizedBox(height: 25.h),

//             Text(
//               "Transactions Overview",
//               style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
//             ),

//             SizedBox(height: 15.h),

//             /// INCOME + EXPENSE
//             Row(
//               children: [
//                 Expanded(
//                   child: _overviewCard(
//                     icon: Icons.arrow_downward,
//                     color: Colors.green,
//                     title: "Income",
//                     percentage: "+24%",
//                     amount: "₹50,000",
//                   ),
//                 ),
//                 SizedBox(width: 12.w),
//                 Expanded(
//                   child: _overviewCard(
//                     icon: Icons.arrow_upward,
//                     color: Colors.orange,
//                     title: "Expense",
//                     percentage: "-42%",
//                     amount: "₹20,000",
//                   ),
//                 ),
//               ],
//             ),

//             SizedBox(height: 15.h),

//             /// SAVINGS
//             _savingsCard(),

//             SizedBox(height: 30.h),

//             Text(
//               "Analytics Dashboard",
//               style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
//             ),

//             SizedBox(height: 15.h),

//             /// MONTHLY TREND
//             _monthlySpendingChart(),

//             SizedBox(height: 20.h),

//             /// CATEGORY CHART
//             _categoryChart(),

//             SizedBox(height: 30.h),

//             Text(
//               "Recent Transactions",
//               style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
//             ),

//             SizedBox(height: 15.h),

//             _transactionTile(
//               title: "Dribbble Pro",
//               date: "18 Sep 2024",
//               amount: "- ₹145",
//               icon: Icons.design_services,
//             ),

//             _transactionTile(
//               title: "Figma",
//               date: "14 Sep 2024",
//               amount: "- ₹46",
//               icon: Icons.brush,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _balanceCard() {
//     return Container(
//       width: double.infinity,
//       height: 220.h,
//       padding: EdgeInsets.all(24.w),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(30.r),
//         gradient: const LinearGradient(
//           colors: [Color(0xff1D2433), Color(0xff2A3245)],
//         ),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             "₹54,800",
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 34.sp,
//               fontWeight: FontWeight.bold,
//             ),
//           ),

//           SizedBox(height: 5.h),

//           Text(
//             "Balance",
//             style: TextStyle(color: Colors.white70, fontSize: 16.sp),
//           ),

//           SizedBox(height: 40.h),

//           ClipRRect(
//             borderRadius: BorderRadius.circular(10.r),
//             child: LinearProgressIndicator(value: 0.35, minHeight: 8.h),
//           ),

//           const Spacer(),

//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 "**** **** 402",
//                 style: TextStyle(color: Colors.white, fontSize: 18.sp),
//               ),
//               const Icon(Icons.credit_card, color: Colors.orange, size: 35),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _overviewCard({
//     required IconData icon,
//     required Color color,
//     required String title,
//     required String percentage,
//     required String amount,
//   }) {
//     return Container(
//       padding: EdgeInsets.all(16.w),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20.r),
//       ),
//       child: Column(
//         children: [
//           CircleAvatar(
//             backgroundColor: color.withOpacity(.15),
//             child: Icon(icon, color: color),
//           ),
//           SizedBox(height: 10.h),
//           Text(
//             percentage,
//             style: TextStyle(
//               color: color,
//               fontSize: 20.sp,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           Text(title),
//           SizedBox(height: 5.h),
//           Text(amount, style: const TextStyle(fontWeight: FontWeight.bold)),
//         ],
//       ),
//     );
//   }

//   Widget _savingsCard() {
//     return Container(
//       padding: EdgeInsets.all(18.w),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20.r),
//       ),
//       child: Row(
//         children: [
//           CircleAvatar(
//             backgroundColor: Colors.blue.withOpacity(.15),
//             child: const Icon(Icons.savings, color: Colors.blue),
//           ),
//           SizedBox(width: 15.w),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text("Savings", style: TextStyle(fontSize: 16.sp)),
//               Text(
//                 "₹30,000",
//                 style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _monthlySpendingChart() {
//     return Container(
//       height: 250.h,
//       padding: EdgeInsets.all(16.w),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20.r),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             "Monthly Spending Trends",
//             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
//           ),
//           SizedBox(height: 20.h),
//           Expanded(
//             child: BarChart(
//               BarChartData(
//                 borderData: FlBorderData(show: false),
//                 gridData: FlGridData(show: false),
//                 titlesData: FlTitlesData(show: false),
//                 barGroups: [
//                   BarChartGroupData(
//                     x: 0,
//                     barRods: [BarChartRodData(toY: 4000)],
//                   ),
//                   BarChartGroupData(
//                     x: 1,
//                     barRods: [BarChartRodData(toY: 7000)],
//                   ),
//                   BarChartGroupData(
//                     x: 2,
//                     barRods: [BarChartRodData(toY: 5500)],
//                   ),
//                   BarChartGroupData(
//                     x: 3,
//                     barRods: [BarChartRodData(toY: 9000)],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _categoryChart() {
//     return Container(
//       height: 250.h,
//       padding: EdgeInsets.all(16.w),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20.r),
//       ),
//       child: PieChart(
//         PieChartData(
//           sections: [
//             PieChartSectionData(value: 35, color: Colors.orange, title: "Food"),
//             PieChartSectionData(value: 25, color: Colors.blue, title: "Bills"),
//             PieChartSectionData(
//               value: 20,
//               color: Colors.green,
//               title: "Shopping",
//             ),
//             PieChartSectionData(
//               value: 20,
//               color: Colors.purple,
//               title: "Travel",
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _transactionTile({
//     required String title,
//     required String date,
//     required String amount,
//     required IconData icon,
//   }) {
//     return Container(
//       margin: EdgeInsets.only(bottom: 15.h),
//       padding: EdgeInsets.all(16.w),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20.r),
//       ),
//       child: Row(
//         children: [
//           CircleAvatar(radius: 28.r, child: Icon(icon)),
//           SizedBox(width: 15.w),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   style: TextStyle(
//                     fontSize: 18.sp,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 Text(
//                   date,
//                   style: TextStyle(color: Colors.grey, fontSize: 14.sp),
//                 ),
//               ],
//             ),
//           ),
//           Text(
//             amount,
//             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _transactionsTab() {
//     return const Center(child: Text("Transactions"));
//   }

//   Widget _analyticsTab() {
//     return const Center(child: Text("Analytics"));
//   }

//   Widget _profileTab() {
//     return const Center(child: Text("Profile"));
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/AuthService/activitywrapper.dart';
import 'package:expense_tracker/providers/currency_services.dart';
import 'package:expense_tracker/screens/budgets_screen.dart';
import 'package:expense_tracker/screens/currency_screen.dart';
import 'package:expense_tracker/screens/expense_screen.dart';
import 'package:expense_tracker/screens/income_history_screen.dart';
import 'package:expense_tracker/screens/login_screen.dart';
import 'package:expense_tracker/screens/profile_screen.dart';
import 'package:expense_tracker/screens/create_budget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  String selectedCurrency = "PKR";
  String userName = "Loading...";
  double totalIncome = 0;
  @override
  void initState() {
    super.initState();
    _loadCurrency();
    _loadUserName();
    _loadUserData();
  }

  @override
  Widget build(BuildContext context) {
    return ActivityWrapper(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: const Color(0xffF5F5F5),

          body: IndexedStack(
            index: currentIndex,
            children: [
              _homeTab(),
              BudgetScreen(),
              ExpenseScreen(),
              // _analyticsTab(),
              IncomeHistoryScreen(),
              ProfileScreen(),
            ],
          ),

          //       bottomNavigationBar: BottomNavigationBar(
          //         currentIndex: currentIndex,
          //         onTap: (index) {
          //           setState(() {
          //             currentIndex = index;
          //           });
          //         },
          //         type: BottomNavigationBarType.fixed,
          //         selectedItemColor: Colors.black,
          //         unselectedItemColor: Colors.grey,
          //         backgroundColor: Colors.white,
          //         elevation: 10,
          //         items: const [
          //           BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          //           BottomNavigationBarItem(
          //             icon: Icon(Icons.account_balance_wallet),
          //             label: "Transactions",
          //           ),
          //           BottomNavigationBarItem(
          //             icon: Icon(Icons.bar_chart),
          //             label: "Analytics",
          //           ),
          //           BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          //         ],
          //       ),
          //     ),
          //   );
          // }
          bottomNavigationBar: Container(
            height: 80,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 15,
                  offset: Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _navItem(Icons.home_rounded, 0),
                _navItem(Icons.account_balance_wallet_rounded, 1),

                const SizedBox(width: 60),

                _navItem(Icons.analytics_outlined, 3),
                _navItem(Icons.person_outline, 4),
              ],
            ),
          ),

          floatingActionButton: Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xff1D2433),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.2),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),

            // child: FloatingActionButton(
            //   elevation: 10,
            //   backgroundColor: const Color(0xff1D2433),
            //   onPressed: () {
            //     // Add Transaction Screen
            //   },
            //   child: const Icon(Icons.add, size: 30, color: Colors.white),
            // ),
            child: FloatingActionButton(
              heroTag: "home_fab",
              onPressed: () {
                setState(() {
                  currentIndex = 2;
                });
              },
              backgroundColor: const Color(0xff1D2433),
              elevation: 8,
              shape: const CircleBorder(),
              child: const Icon(Icons.add, size: 30, color: Colors.white),
            ),
          ),

          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
        ),
      ),
    );
  }

  void _showProfileMenu() {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Menu",
      barrierColor: Colors.black.withOpacity(0.4),
      transitionDuration: const Duration(milliseconds: 250),
      pageBuilder: (_, __, ___) {
        return Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: EdgeInsets.only(top: 120.h, left: 20.w, right: 20.w),
            child: Material(
              color: Colors.transparent,
              child: Container(
                padding: EdgeInsets.all(15.w),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.95),
                  borderRadius: BorderRadius.circular(20.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // _menuItem(Icons.person, "Profile"),
                    // _menuItem(Icons.account_balance_wallet, "Switch Account"),
                    // _menuItem(Icons.currency_exchange, "Currency"),
                    _menuItem(
                      Icons.currency_exchange,
                      "Currency",
                      onPressed: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const CurrencyScreen(),
                          ),
                        );

                        if (result != null) {
                          _loadCurrency();
                        }
                      },
                    ),
                    _menuItem(Icons.settings, "Settings"),
                    const Divider(),
                    // _menuItem(Icons.logout, "Logout", isDestructive: true),
                    _menuItem(
                      Icons.logout,
                      "Logout",
                      isDestructive: true,
                      onPressed: () async {
                        // clear session
                        final prefs = await SharedPreferences.getInstance();
                        await prefs.remove("uid");

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const LoginScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      transitionBuilder: (_, animation, __, child) {
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween(
              begin: const Offset(0, -0.1),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
      },
    );
  }

  Widget _menuItem(
    IconData icon,
    String title, {
    bool isDestructive = false,
    VoidCallback? onPressed,
  }) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);

        // call external action
        if (onPressed != null) {
          onPressed();
        }
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: Row(
          children: [
            Icon(
              icon,
              size: 22,
              color: isDestructive ? Colors.red : Colors.black87,
            ),
            SizedBox(width: 12.w),
            Text(
              title,
              style: TextStyle(
                fontSize: 16.sp,
                color: isDestructive ? Colors.red : Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _loadUserName() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) return;

    final doc = await FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid)
        .get();

    if (doc.exists) {
      setState(() {
        userName = doc.data()?["name"] ?? "No Name";
      });
    }
  }

  Widget _navItem(IconData icon, int index) {
    final isSelected = currentIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          currentIndex = index;
        });
      },
      child: Icon(
        icon,
        size: isSelected ? 30 : 26,
        color: isSelected ? Colors.black : Colors.grey,
      ),
    );
  }

  String getGreeting() {
    final hour = DateTime.now().hour;

    if (hour >= 5 && hour < 12) {
      return "Good Morning";
    } else if (hour >= 12 && hour < 17) {
      return "Good Afternoon";
    } else if (hour >= 17 && hour < 21) {
      return "Good Evening";
    } else {
      return "Good Night";
    }
  }

  // widget of home page
  Widget _homeTab() {
    return RefreshIndicator(
      onRefresh: _refreshHome,
      child: SafeArea(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// HEADER
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${getGreeting()} 👋",
                        style: TextStyle(color: Colors.grey, fontSize: 16.sp),
                      ),
                      SizedBox(height: 5.h),

                      Text(
                        userName,
                        style: TextStyle(
                          fontSize: 26.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  // SizedBox(width: 60.w),
                  const Spacer(), // 🔥 pushes everything to the right
                  Container(
                    height: 50.h,
                    width: 50.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(color: Colors.black12, blurRadius: 10.r),
                      ],
                    ),
                    child: const Icon(Icons.notifications_none),
                  ),
                  SizedBox(width: 10.w),
                  GestureDetector(
                    onTap: _showProfileMenu,
                    child: Container(
                      height: 50.h,
                      width: 50.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(color: Colors.black12, blurRadius: 10.r),
                        ],
                      ),
                      child: const Icon(Icons.menu),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 25.h),

              _balanceCard(),

              SizedBox(height: 25.h),

              Text(
                "Transactions Overview",
                style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 15.h),

              Row(
                children: [
                  Expanded(
                    child: _overviewCard(
                      icon: Icons.arrow_downward,
                      color: Colors.green,
                      title: "Income",
                      percentage: "+24%",
                      amount:
                          " ${CurrencyService.getCurrencySymbol(selectedCurrency)} 50000",
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: _overviewCard(
                      icon: Icons.arrow_upward,
                      color: Colors.orange,
                      title: "Expense",
                      percentage: "-42%",
                      amount:
                          " ${CurrencyService.getCurrencySymbol(selectedCurrency)} 20000",
                    ),
                  ),
                ],
              ),

              SizedBox(height: 15.h),

              _savingsCard(),

              SizedBox(height: 30.h),

              Text(
                "Analytics Dashboard",
                style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 15.h),

              _monthlySpendingChart(),

              SizedBox(height: 20.h),

              _categoryChart(),

              SizedBox(height: 30.h),

              Text(
                "Recent Transactions",
                style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 15.h),

              _transactionTile(
                title: "Dribbble Pro",
                date: "18 Sep 2024",
                amount:
                    " ${CurrencyService.getCurrencySymbol(selectedCurrency)} -145",
                icon: Icons.design_services,
              ),

              _transactionTile(
                title: "Figma",
                date: "14 Sep 2024",
                amount:
                    " ${CurrencyService.getCurrencySymbol(selectedCurrency)} -46",
                icon: Icons.brush,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _loadCurrency() async {
    final currency = await CurrencyService.getCurrency();

    setState(() {
      selectedCurrency = currency;
    });
  }

  // load user data
  Future<void> _loadUserData() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) return;

    final doc = await FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid)
        .get();

    if (doc.exists) {
      final data = doc.data() ?? {};

      setState(() {
        userName = data["name"] ?? "No Name";
        totalIncome = (data["monthlyIncome"] ?? 0).toDouble();
      });
    }
  }

  Widget _balanceCard() {
    return Container(
      width: double.infinity,
      height: 220.h,
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.r),
        gradient: const LinearGradient(
          colors: [Color(0xff1D2433), Color(0xff2A3245)],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            // "₹54,800",
            "${CurrencyService.getCurrencySymbol(selectedCurrency)} $totalIncome",
            style: TextStyle(
              color: Colors.white,
              fontSize: 34.sp,
              fontWeight: FontWeight.bold,
            ),
          ),

          // Text(
          //   "${getCurrencySymbol(selectedCurrency)}54,800",
          //   style: TextStyle(
          SizedBox(height: 5.h),

          Text(
            "Balance",
            style: TextStyle(color: Colors.white70, fontSize: 16.sp),
          ),

          SizedBox(height: 40.h),

          ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: LinearProgressIndicator(value: 0.35, minHeight: 8.h),
          ),

          const Spacer(),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "**** **** 402",
                style: TextStyle(color: Colors.white, fontSize: 18.sp),
              ),
              const Icon(Icons.credit_card, color: Colors.orange, size: 35),
            ],
          ),
        ],
      ),
    );
  }

  Widget _overviewCard({
    required IconData icon,
    required Color color,
    required String title,
    required String percentage,
    required String amount,
  }) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: color.withOpacity(.15),
            child: Icon(icon, color: color),
          ),
          SizedBox(height: 10.h),
          Text(
            percentage,
            style: TextStyle(
              color: color,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(title),
          SizedBox(height: 5.h),
          Text(amount, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _savingsCard() {
    return Container(
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.blue.withOpacity(.15),
            child: const Icon(Icons.savings, color: Colors.blue),
          ),
          SizedBox(width: 15.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Savings", style: TextStyle(fontSize: 16.sp)),
              Text(
                "${CurrencyService.getCurrencySymbol(selectedCurrency)} 30000",
                style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _monthlySpendingChart() {
    return Container(
      height: 250.h,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Monthly Spending Trends",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
          ),
          SizedBox(height: 20.h),
          Expanded(
            child: BarChart(
              BarChartData(
                borderData: FlBorderData(show: false),
                gridData: FlGridData(show: false),
                titlesData: FlTitlesData(show: false),
                barGroups: [
                  BarChartGroupData(
                    x: 0,
                    barRods: [BarChartRodData(toY: 4000)],
                  ),
                  BarChartGroupData(
                    x: 1,
                    barRods: [BarChartRodData(toY: 7000)],
                  ),
                  BarChartGroupData(
                    x: 2,
                    barRods: [BarChartRodData(toY: 5500)],
                  ),
                  BarChartGroupData(
                    x: 3,
                    barRods: [BarChartRodData(toY: 9000)],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _categoryChart() {
    return Container(
      height: 250.h,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: PieChart(
        PieChartData(
          sections: [
            PieChartSectionData(value: 35, color: Colors.orange, title: "Food"),
            PieChartSectionData(value: 25, color: Colors.blue, title: "Bills"),
            PieChartSectionData(
              value: 20,
              color: Colors.green,
              title: "Shopping",
            ),
            PieChartSectionData(
              value: 20,
              color: Colors.purple,
              title: "Travel",
            ),
          ],
        ),
      ),
    );
  }

  // refresh home screen function
  Future<void> _refreshHome() async {
    await _loadUserName();
    await _loadCurrency();
    await _loadUserData();
  }

  // transaction title widget
  Widget _transactionTile({
    required String title,
    required String date,
    required String amount,
    required IconData icon,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 15.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        children: [
          CircleAvatar(radius: 28.r, child: Icon(icon)),
          SizedBox(width: 15.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  date,
                  style: TextStyle(color: Colors.grey, fontSize: 14.sp),
                ),
              ],
            ),
          ),
          Text(
            amount,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
          ),
        ],
      ),
    );
  }
}
