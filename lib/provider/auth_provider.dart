import 'package:flutter/cupertino.dart';

class AuthProvider with ChangeNotifier {
  bool _authStatus = false;
  String _password = "";

  void authenticated(String pass) {
    _password = pass;
    _authStatus = true;
    notifyListeners();
  }

  bool isAuthenticated() {
    return _authStatus;
    // notifyListeners();
  }

  String getPass() {
    return _password;
  }
}
