// import 'package:expense_tracker/screens/splash_screen.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// // void main() {
// //   runApp(const MyApp());
// // }

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return ScreenUtilInit(
//       designSize: const Size(375, 812),
//       builder: (_, __) {
//         return MaterialApp(
//           debugShowCheckedModeBanner: false,
//           home: SplashScreen(),
//         );
//       },
//     );
//   }
// }

import 'package:expense_tracker/providers/currency_services.dart';
import 'package:expense_tracker/providers/theme_provider.dart';
import 'package:expense_tracker/screens/home_screen.dart';
import 'package:expense_tracker/screens/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(const MyApp());
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await FirebaseAuth.instance.authStateChanges().first;
  await CurrencyService.initCurrency(); // 🔥 important
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  /// 🔐 Check if user session exists
  Future<Widget> _getStartScreen() async {
    final prefs = await SharedPreferences.getInstance();
    final uid = prefs.getString("uid");

    if (uid != null && uid.isNotEmpty) {
      return const HomeScreen();
    } else {
      return const SplashScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, __) {
        // return MaterialApp(
        //   debugShowCheckedModeBanner: false,

        //   /// 🚀 Decide first screen based on login session
        //   home: FutureBuilder<Widget>(
        //     future: _getStartScreen(),
        //     builder: (context, snapshot) {
        //       if (snapshot.connectionState == ConnectionState.waiting) {
        //         return const Scaffold(
        //           backgroundColor: Colors.black,
        //           body: Center(
        //             child: CircularProgressIndicator(color: Colors.white),
        //           ),
        //         );
        //       }

        //       if (snapshot.hasError) {
        //         return const Scaffold(
        //           body: Center(child: Text("Something went wrong")),
        //         );
        //       }

        //       return snapshot.data ?? const SplashScreen();
        //     },
        //   ),
        // );

        return Consumer<ThemeProvider>(
          builder: (context, themeProvider, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,

              theme: ThemeData(
                brightness: Brightness.light,
                scaffoldBackgroundColor: const Color(0xffF5F5F7),
              ),

              darkTheme: ThemeData(
                brightness: Brightness.dark,
                scaffoldBackgroundColor: const Color(0xff121212),
                cardColor: const Color(0xff1E1E1E),
              ),

              themeMode: themeProvider.themeMode,

              home: FutureBuilder<Widget>(
                future: _getStartScreen(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Scaffold(
                      body: Center(child: CircularProgressIndicator()),
                    );
                  }

                  if (snapshot.hasError) {
                    return const Scaffold(
                      body: Center(child: Text("Something went wrong")),
                    );
                  }

                  return snapshot.data ?? const SplashScreen();
                },
              ),
            );
          },
        );
      },
    );
  }
}
