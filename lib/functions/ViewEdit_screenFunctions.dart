import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart';
import 'package:password_manager/utility/inputOutputClass.dart';
import '../utility/dbhelper.dart';
import '../utility/inputOutputClass.dart';
import 'package:provider/provider.dart';
import '../provider/auth_provider.dart';
import 'package:encrypt/encrypt.dart' as enc;
import 'package:random_string/random_string.dart';
import 'package:characters/characters.dart';


String decriptPass(context) {
  final current = ModalRoute
      .of(context)!
      .settings
      .arguments as Password;
  final carry = Provider.of<AuthProvider>(context, listen: false);
  var actualkey = carry.getPass();
  while (actualkey.length < 32) {
    actualkey = actualkey + actualkey;
  }
  final key = enc.Key.fromUtf8("${actualkey.characters.take(32)}");
  final encrypter = Encrypter(AES(key));
  final iv = enc.IV.fromUtf8(current.iv);
  print(current.password.length);
  final decrypted = encrypter.decrypt64(current.password, iv: iv);

  print(decrypted);
  return decrypted;
}


void saveAfterEditing(inputPass a, String actualkey, Password here) {
  while (actualkey.length < 32) {
    actualkey = actualkey + actualkey;
  }
  final key = enc.Key.fromUtf8('${actualkey.characters.take(32)}');
  var randomStringIV = randomAlphaNumeric(12);
  final iv = enc.IV.fromUtf8(randomStringIV);
  final encrypter = enc.Encrypter(enc.AES(key));
  final encrypted = encrypter.encrypt(a.password, iv: iv);

  here.name = a.name;
  here.username = a.username;
  here.email = a.email;
  here.password = encrypted.base64;
  here.iv = randomStringIV;
  here.save();
}