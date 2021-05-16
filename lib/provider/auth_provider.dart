import 'package:flutter/cupertino.dart';

//import '../utility/auth.dart';

class AuthProvider with ChangeNotifier{
  bool _authStatus = false;

  void authenticated(){
    _authStatus=true;
    notifyListeners();
  }

  bool isAuthenticated(){
    return _authStatus;
   // notifyListeners();
  }







}