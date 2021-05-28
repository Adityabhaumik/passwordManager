import 'dart:convert';
import 'package:characters/characters.dart';
import 'package:flutter/material.dart';
import '../utility/dbhelper.dart';
import '../utility/box.dart';
import 'dart:math';
import 'package:form_field_validator/form_field_validator.dart';
import 'dart:io';
import 'package:password_strength/password_strength.dart';
import 'package:provider/provider.dart';
import '../provider/auth_provider.dart';
import 'package:encrypt/encrypt.dart' as encryptor;
import 'package:random_string/random_string.dart';
import 'dart:math' show Random;
import '../utility/inputOutputClass.dart';
import 'dart:convert';




void add(String name, String username, String email, String password,
    String actualkey) {

  while(actualkey.length<32){
    actualkey=actualkey+actualkey;
  }
  print(actualkey.characters.take(32));
  print(actualkey.characters.take(32).length);
  final key = encryptor.Key.fromUtf8('${actualkey.characters.take(32)}');
  var a = randomAlphaNumeric(12);
  final iv = encryptor.IV.fromUtf8(a);
  final encrypter = encryptor.Encrypter(encryptor.AES(key));
  final encrypted = encrypter.encrypt(password, iv: iv);
  print(encrypted.base64.length);
  final temp = Password();
  temp.name = name;
  temp.username = username;
  temp.email = email;
  temp.password = encrypted.base64;
  temp.iv=a;
  final decript = encrypter.decrypt64(encrypted.base64,iv: iv);
  print(decript);
  final box = Boxes.getPasswords();
  box.add(temp);
}