import 'package:flutter/material.dart';

class CurrencyProvider extends ChangeNotifier {
  String _currency = "PKR";

  String get currency => _currency;

  void setCurrency(String newCurrency) {
    _currency = newCurrency;
    notifyListeners();
  }
}
