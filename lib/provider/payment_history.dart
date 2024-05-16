import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaymentHistoryProvider extends ChangeNotifier {
  List<String> _Payment = [];
  static const _PaymentKey = 'payments';
  static const _DescKey = 'descriptions';
  static const _PriceKey = 'prices';
  List<String> desc = [];
  List<String> price = [];

  List<String> get payment => _Payment;
  Future<void> loadPaymnet() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? payments = prefs.getStringList(_PaymentKey);
    final List<String>? descriptions = prefs.getStringList(_DescKey);
    final List<String>? prices = prefs.getStringList(_PriceKey);
    if (payments != null && descriptions != null && prices != null) {
      _Payment = payments;
      desc = descriptions;
      price = prices;
      notifyListeners();
    }
  }

  Future<void> addPayment(String title, des, String pric) async {
    _Payment.add(title);
    desc.add(des);
    price.add(pric);
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_PaymentKey, _Payment);
    await prefs.setStringList(_DescKey, desc);
    await prefs.setStringList(_PriceKey, price);
  }
}
