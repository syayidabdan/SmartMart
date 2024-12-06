import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier{
  bool _isLoggedIn = false;
  String? _email;

  bool get isLoggedIn => _isLoggedIn;
  String? get email => _email;

  AuthProvider() {
    loadAuth();
  }

  void loadAuth() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isLoggedIn = prefs.getBool("isLoggedIn") ?? false;
    _email = prefs.getString("email") ?? "";
    print("loadAuth: $_isLoggedIn, email: $_email");
    notifyListeners();
  }

  void setAuth(bool status, {String? email}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isLoggedIn = status;
    if (email != null) {
      _email = email;
      await prefs.setString("email", email);
    }
    await prefs.setBool("isLoggedIn", status);
    notifyListeners();
  }
}