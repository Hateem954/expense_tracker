import 'package:expense_tracker/screens/login_screen.dart';
import 'package:expense_tracker/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/utils/customimage.dart';
import 'package:expense_tracker/utils/images.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final screenHeight = size.height;
    final screenWidth = size.width;

    return Scaffold(
      body: SizedBox(
        height: screenHeight,
        width: screenWidth,
        child: Stack(
          children: [
            /// 🔥 Background Image (FULL SCREEN SAFE)
            Positioned.fill(
              child: CustomImageContainer(
                height: double.infinity,
                width: double.infinity,
                imageUrl: AppImages.splashscreenimage,
              ),
            ),

            /// ✨ Text Content
            Positioned(
              top: screenHeight * 0.54,
              left: screenWidth * 0.06,
              right: screenWidth * 0.06,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "EXPENSE",
                    style: TextStyle(
                      fontSize: screenWidth * 0.17,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),
                  ),
                  Text(
                    "TRACKER",
                    style: TextStyle(
                      fontSize: screenWidth * 0.15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 0.9,
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.04),

                  Text(
                    "The right app makes it easy to manage\n"
                    "your expenses on the go. Personal\n"
                    "Capital · Expensify",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: screenWidth * 0.045,
                      height: 1.7,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            /// 🔘 Button
            Positioned(
              bottom: screenHeight * 0.03,
              left: screenWidth * 0.08,
              right: screenWidth * 0.08,
              child: SizedBox(
                height: screenHeight * 0.075,
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: navigation
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  child: Text(
                    "Next",
                    style: TextStyle(
                      fontSize: screenWidth * 0.05,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// StreamBuilder(
//   stream: FirebaseAuth.instance.authStateChanges(),
//   builder: (context, snapshot) {
//     if (snapshot.connectionState == ConnectionState.waiting) {
//       return SplashScreen();
//     }

//     if (snapshot.hasData) {
//       return HomeScreen();
//     } else {
//       return LoginScreen();
//     }
//   },
// );