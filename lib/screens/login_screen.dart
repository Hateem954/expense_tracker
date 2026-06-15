// import 'package:expense_tracker/AuthService/auth_services.dart';
// import 'package:expense_tracker/screens/signup_screen.dart';
// import 'package:expense_tracker/utils/customimage.dart';
// import 'package:expense_tracker/utils/images.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:local_auth/local_auth.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final LocalAuthentication auth = LocalAuthentication();

//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();

//   bool isLoading = false;

//   /// 🔐 Fingerprint Login
//   Future<void> authenticateWithBiometrics() async {
//     // try {
//     //   bool canCheck = await auth.canCheckBiometrics;
//     //   bool isDeviceSupported = await auth.isDeviceSupported();

//     //   if (!canCheck || !isDeviceSupported) {
//     //     ScaffoldMessenger.of(context).showSnackBar(
//     //       const SnackBar(content: Text("Biometric not available")),
//     //     );
//     //     return;
//     //   }

//     //   bool authenticated = await auth.authenticate(
//     //     localizedReason: "Login using fingerprint",
//     //     options: const AuthenticationOptions(
//     //       biometricOnly: true,
//     //       stickyAuth: true,
//     //     ),
//     //   );

//     //   if (authenticated && mounted) {
//     //     ScaffoldMessenger.of(context).showSnackBar(
//     //       const SnackBar(content: Text("Login successful")),
//     //     );

//     //     // TODO: Navigate to Home
//     //   }
//     // } catch (e) {
//     //   ScaffoldMessenger.of(context).showSnackBar(
//     //     SnackBar(content: Text("Error: $e")),
//     //   );
//     // }
//   }

//   // void login() {
//   //   setState(() => isLoading = true);

//   //   Future.delayed(const Duration(seconds: 2), () {
//   //     setState(() => isLoading = false);

//   //     ScaffoldMessenger.of(
//   //       context,
//   //     ).showSnackBar(const SnackBar(content: Text("Login successful")));

//   //     // TODO: Navigate to Home
//   //   });
//   // }
//   void login() async {
//   setState(() => isLoading = true);

//   try {
//     await AuthService().login(
//       emailController.text.trim(),
//       passwordController.text.trim(),
//     );

//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text("Login successful")),
//     );
//   } catch (e) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text(e.toString())),
//     );
//   }

//   setState(() => isLoading = false);
// }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;

//     return Scaffold(
//       body: SizedBox(
//         height: size.height,
//         width: size.width,
//         child: Stack(
//           children: [
//             /// 🌄 Background
//             Positioned.fill(
//               child: CustomImageContainer(
//                 height: size.height,
//                 width: size.width,
//                 imageUrl: AppImages.background,
//               ),
//             ),

//             /// 🧊 Dark overlay
//             Container(color: Colors.black.withOpacity(0.55)),

//             /// 📱 Content
//             SafeArea(
//               child: SingleChildScrollView(
//                 padding: EdgeInsets.symmetric(horizontal: 24.w),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SizedBox(height: 200.h),

//                     /// Title
//                     Text(
//                       "Welcome Back",
//                       style: TextStyle(
//                         fontSize: 34.sp,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                       ),
//                     ),

//                     SizedBox(height: 10.h),

//                     Text(
//                       "Login to continue managing your expenses",
//                       style: TextStyle(fontSize: 14.sp, color: Colors.white70),
//                     ),

//                     SizedBox(height: 40.h),

//                     /// Email
//                     TextField(
//                       controller: emailController,
//                       style: const TextStyle(color: Colors.white),
//                       decoration: InputDecoration(
//                         labelText: "Email",
//                         labelStyle: const TextStyle(color: Colors.white70),
//                         filled: true,
//                         fillColor: Colors.white10,
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12.r),
//                         ),
//                       ),
//                     ),

//                     SizedBox(height: 20.h),

//                     /// Password
//                     TextField(
//                       controller: passwordController,
//                       obscureText: true,
//                       style: const TextStyle(color: Colors.white),
//                       decoration: InputDecoration(
//                         labelText: "Password",
//                         labelStyle: const TextStyle(color: Colors.white70),
//                         filled: true,
//                         fillColor: Colors.white10,
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12.r),
//                         ),
//                       ),
//                     ),

//                     SizedBox(height: 35.h),

//                     /// 🔥 LOGIN + FINGERPRINT ROW
//                     Row(
//                       children: [
//                         /// Login Button
//                         Expanded(
//                           child: SizedBox(
//                             height: 50.h,
//                             child: ElevatedButton(
//                               onPressed: isLoading ? null : login,
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: Colors.white,
//                                 foregroundColor: Colors.black,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(30.r),
//                                 ),
//                               ),
//                               child: isLoading
//                                   ? const CircularProgressIndicator()
//                                   : Text(
//                                       "Login",
//                                       style: TextStyle(
//                                         fontSize: 18.sp,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                             ),
//                           ),
//                         ),

//                         SizedBox(width: 15.w),

//                         /// Fingerprint Button
//                         GestureDetector(
//                           onTap: authenticateWithBiometrics,
//                           child: Container(
//                             height: 50.h,
//                             width: 50.w,
//                             decoration: BoxDecoration(
//                               color: Colors.white10,
//                               shape: BoxShape.circle,
//                               border: Border.all(color: Colors.white24),
//                             ),
//                             child: const Icon(
//                               Icons.fingerprint,
//                               size: 28,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),

//                     SizedBox(height: 30.h),

//                     /// OR divider
//                     Row(
//                       children: const [
//                         Expanded(child: Divider(color: Colors.white24)),
//                         Padding(
//                           padding: EdgeInsets.symmetric(horizontal: 10),
//                           child: Text(
//                             "OR",
//                             style: TextStyle(color: Colors.white70),
//                           ),
//                         ),
//                         Expanded(child: Divider(color: Colors.white24)),
//                       ],
//                     ),

//                     SizedBox(height: 25.h),

//                     /// ✍️ SIGNUP TEXT
//                     Center(
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(
//                             "Don't have an account? ",
//                             style: TextStyle(
//                               color: Colors.white70,
//                               fontSize: 14.sp,
//                             ),
//                           ),
//                           GestureDetector(
//                             onTap: () {
//                               // TODO: Navigate to Signup
//                               Navigator.pushReplacement(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => SignupScreen(),
//                                 ),
//                               );
//                             },
//                             child: Text(
//                               "Sign up",
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 14.sp,
//                                 fontWeight: FontWeight.bold,
//                                 decoration: TextDecoration.underline,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),

//                     SizedBox(height: 30.h),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:expense_tracker/AuthService/auth_services.dart';
import 'package:expense_tracker/screens/home_screen.dart';
import 'package:expense_tracker/screens/signup_screen.dart';
import 'package:expense_tracker/screens/splash_screen.dart';
import 'package:expense_tracker/utils/customimage.dart';
import 'package:expense_tracker/utils/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LocalAuthentication auth = LocalAuthentication();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

  /// 🔐 Fingerprint Login (FIXED)
  Future<void> authenticateWithBiometrics() async {
    try {
      bool canCheck = await auth.canCheckBiometrics;
      bool isSupported = await auth.isDeviceSupported();

      if (!canCheck || !isSupported) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Biometric not available")),
        );
        return;
      }

      bool authenticated = await auth.authenticate(
        localizedReason: "Login using fingerprint",
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
        ),
      );

      if (authenticated && mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const SplashScreen()),
        );
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  /// 🔐 Email login
  // void login() async {
  //   setState(() => isLoading = true);

  //   try {
  //     await AuthService().login(
  //       emailController.text.trim(),
  //       passwordController.text.trim(),
  //     );

  //     ScaffoldMessenger.of(
  //       context,
  //     ).showSnackBar(const SnackBar(content: Text("Login successful")));

  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(builder: (_) => const HomeScreen()),
  //     );
  //   } catch (e) {
  //     ScaffoldMessenger.of(
  //       context,
  //     ).showSnackBar(SnackBar(content: Text(e.toString())));
  //   }

  //   setState(() => isLoading = false);
  // }
  void login() async {
    setState(() => isLoading = true);

    try {
      final credential = await AuthService().login(
        emailController.text.trim(),
        passwordController.text.trim(),
      );
      // final uid = "FNS9uMSBJvZp5GN40HaEowWjRnI3";
      final uid = credential.user?.uid;

      if (uid != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString("uid", uid);
        await prefs.setInt("lastActive", DateTime.now().millisecondsSinceEpoch);
      }

      if (!mounted) return;

      // ScaffoldMessenger.of(
      //   context,
      // ).showSnackBar(const SnackBar(content: Text("Login successful")));

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("please enter the valid email and password")),
      );
    }

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Stack(
          children: [
            /// Background
            Positioned.fill(
              child: CustomImageContainer(
                height: size.height,
                width: size.width,
                imageUrl: AppImages.background,
              ),
            ),

            Container(color: Colors.black.withOpacity(0.55)),

            /// Content
            SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 200.h),

                    Text(
                      "Welcome Back",
                      style: TextStyle(
                        fontSize: 34.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),

                    SizedBox(height: 10.h),

                    Text(
                      "Login to continue managing your expenses",
                      style: TextStyle(fontSize: 14.sp, color: Colors.white70),
                    ),

                    SizedBox(height: 40.h),

                    TextField(
                      controller: emailController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: "Email",
                        labelStyle: const TextStyle(color: Colors.white70),
                        filled: true,
                        fillColor: Colors.white10,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                    ),

                    SizedBox(height: 20.h),

                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: "Password",
                        labelStyle: const TextStyle(color: Colors.white70),
                        filled: true,
                        fillColor: Colors.white10,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                    ),

                    SizedBox(height: 35.h),

                    /// LOGIN + FINGERPRINT
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 50.h,
                            child: ElevatedButton(
                              onPressed: isLoading ? null : login,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.r),
                                ),
                              ),
                              child: isLoading
                                  ? const CircularProgressIndicator()
                                  : Text(
                                      "Login",
                                      style: TextStyle(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                            ),
                          ),
                        ),

                        SizedBox(width: 15.w),

                        GestureDetector(
                          onTap: authenticateWithBiometrics,
                          child: Container(
                            height: 50.h,
                            width: 50.w,
                            decoration: BoxDecoration(
                              color: Colors.white10,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white24),
                            ),
                            child: const Icon(
                              Icons.fingerprint,
                              size: 28,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 25.h),

                    Row(
                      children: const [
                        Expanded(child: Divider(color: Colors.white24)),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            "OR",
                            style: TextStyle(color: Colors.white70),
                          ),
                        ),
                        Expanded(child: Divider(color: Colors.white24)),
                      ],
                    ),

                    SizedBox(height: 25.h),

                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don't have an account? ",
                            style: TextStyle(color: Colors.white70),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const SignupScreen(),
                                ),
                              );
                            },
                            child: const Text(
                              "Sign up",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 30.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
