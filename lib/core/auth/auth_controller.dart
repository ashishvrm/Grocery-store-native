import 'package:flutter/material.dart';

class AuthController extends ChangeNotifier {
  bool _isSignedIn = false;

  bool get isSignedIn => _isSignedIn;

  void signIn() {
    if (_isSignedIn) {
      return;
    }
    _isSignedIn = true;
    notifyListeners();
  }

  void signOut() {
    if (!_isSignedIn) {
      return;
    }
    _isSignedIn = false;
    notifyListeners();
  }
}
