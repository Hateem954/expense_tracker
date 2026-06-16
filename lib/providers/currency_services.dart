// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class CurrencyService {
//   static const String _localKey = "currency";

//   static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   static final FirebaseAuth _auth = FirebaseAuth.instance;

//   static Future<void> setCurrency(String currency) async {
//     final user = FirebaseAuth.instance.currentUser;

//     if (user == null) return;

//     await FirebaseFirestore.instance.collection("users").doc(user.uid).set({
//       "currency": currency,
//     }, SetOptions(merge: true));
//   }

//   static Future<String> getCurrency() async {
//     final user = FirebaseAuth.instance.currentUser;

//     if (user == null) return "PKR";

//     final doc = await FirebaseFirestore.instance
//         .collection("users")
//         .doc(user.uid)
//         .get();

//     return doc.data()?["currency"] ?? "PKR";
//   }

//   static getCurrencySymbol(String currency) {
//     switch (currency) {
//       case "USD":
//         return "\$";

//       case "EUR":
//         return "€";

//       case "GBP":
//         return "£";

//       case "PKR":
//         return "Rs";

//       case "INR":
//         return "₹";

//       case "AED":
//         return "د.إ";

//       case "SAR":
//         return "﷼";

//       case "JPY":
//         return "¥";

//       case "CAD":
//         return "C\$";

//       case "AUD":
//         return "A\$";

//       default:
//         return currency;
//     }
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class CurrencyService {
  static final ValueNotifier<String> currencyNotifier = ValueNotifier<String>(
    "PKR",
  );

  static Future<void> initCurrency() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) return;

    final doc = await FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid)
        .get();

    final currency = doc.data()?["currency"] ?? "PKR";

    currencyNotifier.value = currency;
  }

  static Future<void> setCurrency(String currency) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    await FirebaseFirestore.instance.collection("users").doc(user.uid).set({
      "currency": currency,
    }, SetOptions(merge: true));

    // 🔥 instantly update UI everywhere
    currencyNotifier.value = currency;
  }

  static Future<String> getCurrency() async {
    return currencyNotifier.value;
  }

  static String getCurrencySymbol(String currency) {
    switch (currency) {
      case "USD":
        return "\$";
      case "EUR":
        return "€";
      case "GBP":
        return "£";
      case "PKR":
        return "Rs";
      case "INR":
        return "₹";
      case "AED":
        return "د.إ";
      case "SAR":
        return "﷼";
      case "JPY":
        return "¥";
      case "CAD":
        return "C\$";
      case "AUD":
        return "A\$";
      default:
        return currency;
    }
  }
}
