import 'package:expense_tracker/utils/colors.dart';
import 'package:flutter/material.dart';

/// A reusable custom text field widget
Widget buildCustomTextField(
  String label,
  TextEditingController controller, {
  bool obscure = false,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: TextField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        hintText: label, // Display label as placeholder
        hintStyle: const TextStyle(
          color: Colors.black87,
          fontWeight: FontWeight.w500,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12), // Rounded edges
          borderSide: BorderSide.none, // Removes border line
        ),
        filled: true,
        fillColor: AppColors.cream, // Light subtle background color
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),
      style: const TextStyle(fontSize: 16, color: Colors.black),
    ),
  );
}
