import 'dart:async';

import 'package:expense_tracker/AuthService/auth_services.dart';
import 'package:expense_tracker/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ActivityWrapper extends StatefulWidget {
  final Widget child;
  const ActivityWrapper({super.key, required this.child});

  @override
  State<ActivityWrapper> createState() => _ActivityWrapperState();
}

class _ActivityWrapperState extends State<ActivityWrapper> {
  Timer? timer;

  void updateActivity() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('lastActive', DateTime.now().millisecondsSinceEpoch);
  }

  void startTimer() {
    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 30), (_) async {
      final prefs = await SharedPreferences.getInstance();
      final last = prefs.getInt('lastActive') ?? 0;

      final diff = DateTime.now().millisecondsSinceEpoch - last;

      if (diff > 5 * 60 * 1000) {
        await AuthService().logout();

        if (mounted) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const LoginScreen()),
            (route) => false,
          );
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: updateActivity,
      onPanDown: (_) => updateActivity(),
      child: widget.child,
    );
  }
}
