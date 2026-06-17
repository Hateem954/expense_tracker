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

  // static String getCurrencySymbol(String currency) {
  //   switch (currency) {
  //     // Major
  //     case "USD":
  //       return "\$";
  //     case "EUR":
  //       return "€";
  //     case "GBP":
  //       return "£";
  //     case "PKR":
  //       return "Rs";
  //     case "INR":
  //       return "₹";
  //     case "AED":
  //       return "د.إ";
  //     case "SAR":
  //       return "﷼";
  //     case "JPY":
  //       return "¥";
  //     case "CNY":
  //       return "¥";
  //     case "CAD":
  //       return "C\$";
  //     case "AUD":
  //       return "A\$";
  //     case "CHF":
  //       return "CHF";
  //     case "SGD":
  //       return "S\$";
  //     case "MYR":
  //       return "RM";
  //     case "IDR":
  //       return "Rp";
  //     case "KRW":
  //       return "₩";
  //     case "THB":
  //       return "฿";
  //     case "NGN":
  //       return "₦";
  //     case "ZAR":
  //       return "R";
  //     case "EGP":
  //       return "E£";
  //     case "TRY":
  //       return "₺";
  //     case "RUB":
  //       return "₽";
  //     case "BDT":
  //       return "৳";
  //     case "LKR":
  //       return "Rs";
  //     case "NPR":
  //       return "Rs";
  //     case "KWD":
  //       return "KD";
  //     case "QAR":
  //       return "QR";
  //     case "BHD":
  //       return "BD";
  //     case "OMR":
  //       return "﷼";

  //     default:
  //       return currency;
  //   }
  // }
  static const Map<String, String> _currencySymbols = {
    // ================= Asia =================
    "PKR": "Rs",
    "INR": "₹",
    "CNY": "¥",
    "JPY": "¥",
    "KRW": "₩",
    "BDT": "৳",
    "LKR": "Rs",
    "NPR": "Rs",
    "AFN": "؋",
    "MMK": "K",
    "THB": "฿",
    "MYR": "RM",
    "SGD": "S\$",
    "IDR": "Rp",
    "PHP": "₱",
    "VND": "₫",
    "KHR": "៛",
    "LAK": "₭",

    // ================= Middle East =================
    "AED": "د.إ",
    "SAR": "﷼",
    "QAR": "QR",
    "KWD": "KD",
    "BHD": "BD",
    "OMR": "﷼",
    "ILS": "₪",
    "JOD": "JD",
    "LBP": "L£",
    "YER": "﷼",
    "IQD": "IQD",
    "IRR": "﷼",

    // ================= Europe =================
    "EUR": "€",
    "GBP": "£",
    "CHF": "CHF",
    "SEK": "kr",
    "NOK": "kr",
    "DKK": "kr",
    "ISK": "kr",
    "PLN": "zł",
    "CZK": "Kč",
    "HUF": "Ft",
    "RON": "lei",
    "BGN": "лв",
    "HRK": "kn",
    "UAH": "₴",
    "RUB": "₽",

    // ================= North America =================
    "USD": "\$",
    "CAD": "C\$",
    "MXN": "\$",

    // ================= South America =================
    "BRL": "R\$",
    "ARS": "\$",
    "CLP": "\$",
    "COP": "\$",
    "PEN": "S/",
    "UYU": "\$U",
    "BOB": "Bs",
    "PYG": "₲",
    "VES": "Bs",

    // ================= Africa =================
    "ZAR": "R",
    "NGN": "₦",
    "EGP": "E£",
    "KES": "KSh",
    "GHS": "₵",
    "MAD": "DH",
    "DZD": "DA",
    "TND": "DT",
    "ETB": "Br",
    "UGX": "USh",
    "TZS": "TSh",
    "XOF": "CFA",
    "XAF": "FCFA",

    // ================= Oceania =================
    "AUD": "A\$",
    "NZD": "NZ\$",
    "FJD": "FJ\$",

    // ================= Crypto (optional) =================
    "BTC": "₿",
    "ETH": "Ξ",
    "USDT": "₮",
  };

  static String getCurrencySymbol(String currency) {
    return _currencySymbols[currency] ?? currency;
  }
}
