import 'package:flutter/material.dart';
import '../utility/dbhelper.dart';
import '../utility/box.dart';
import 'dart:math';
import 'package:form_field_validator/form_field_validator.dart';
import 'dart:io';
import 'package:password_strength/password_strength.dart';
import 'package:provider/provider.dart';
import '../provider/auth_provider.dart';

class AddPass_screen extends StatefulWidget {
  static const id = "AddPass_screen";

  @override
  _AddPass_screenState createState() => _AddPass_screenState();
}

class _AddPass_screenState extends State<AddPass_screen> {
  final _formKey = GlobalKey<FormState>();
  final temp = Password();

  // String myvalidator(value){
  //   if(1==1){
  //     return "";
  //   }
  //   return "Required!";
  // }

  void add(String name, String username, String email, String password,
      String hint) {
    final temp = Password();
    temp.name = name;
    temp.username=username;
    temp.email = email;
    temp.password = password;
    temp.hint = hint;
    final box = Boxes.getPasswords();
    box.add(temp);
  }

  @override
  Widget build(BuildContext context) {
    dynamic current = Provider.of<AuthProvider>(context);
    return Scaffold(
        backgroundColor: Colors.black45,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Color(0xFF0C4160),
          title: Text("Password manager"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        style: TextStyle(color: Colors.white),
                        onChanged: (value) {
                          temp.name = value;
                        },
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          focusColor: Colors.white,
                          border: OutlineInputBorder(
                              gapPadding: 6,
                              borderSide: BorderSide(color: Colors.white)),
                          labelText: "Account For",
                          labelStyle: TextStyle(color: Colors.white),
                        ),
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Field Cant Be Empty';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        style: TextStyle(color: Colors.white),
                        onChanged: (value) {
                          temp.username = value;
                        },
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          focusColor: Colors.white,
                          border: OutlineInputBorder(
                              gapPadding: 6,
                              borderSide: BorderSide(color: Colors.white)),
                          labelText: "User Name",
                          labelStyle: TextStyle(color: Colors.white),
                        ),
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        style: TextStyle(color: Colors.white),
                        onChanged: (value) {
                          temp.email = value;
                        },
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          focusColor: Colors.white,
                          border: OutlineInputBorder(
                              gapPadding: 6,
                              borderSide: BorderSide(color: Colors.white)),
                          labelText: "Email",
                          labelStyle: TextStyle(color: Colors.white),
                        ),
                        // The validator receives the text that the user has entered.
                        validator: EmailValidator(
                            errorText: 'Enter a valid email address'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        style: TextStyle(color: Colors.white),
                        onChanged: (value) {
                          temp.password = value;
                        },
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          focusColor: Colors.white,
                          border: OutlineInputBorder(
                              gapPadding: 6,
                              borderSide: BorderSide(color: Colors.white)),
                          labelText: "PassWord",
                          labelStyle: TextStyle(color: Colors.white),
                        ),
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          if (value.toString().trim().length < 8) {
                            return 'Enter more than 8 charecter ';
                          }
                          double strength =
                              estimatePasswordStrength(value.toString());
                          if (strength <= 0.7) {
                            return ('This password is weak!');
                          }
                          if (strength > 0.7) {
                            print('this worked');
                            return null;
                          }
                          ;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        style: TextStyle(color: Colors.white),
                        onChanged: (value) {
                          temp.hint = value;
                        },
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          focusColor: Colors.white,
                          border: OutlineInputBorder(
                              gapPadding: 6,
                              borderSide: BorderSide(color: Colors.white)),
                          labelText: "Hint",
                          labelStyle: TextStyle(color: Colors.white),
                        ),
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          print('Validation Works');
                          if (value == null || value.isEmpty) {
                            return 'Please enter some Hint';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
            backgroundColor: Colors.orangeAccent,
            onPressed: () {
              print(current.getPass());
              // if (_formKey.currentState!.validate()) {
              //   add(temp.name, temp.username, temp.email, temp.password,
              //       temp.hint);
              //   //print('Validation Works');
              //   // print(Password);
              // }
            },
            label: Text("Encrypt and Save")));
  }
}
//
// class MyCustomForm extends StatefulWidget {
//   @override
//   MyCustomFormState createState() {
//     return MyCustomFormState();
//   }
// }
//
// class MyCustomFormState extends State<MyCustomForm> {
//
//   final _formKey = GlobalKey<FormState>();
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Form(
//       key: _formKey,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           TextFormField(
//             // The validator receives the text that the user has entered.
//             validator: (value) {
//               if (value == null || value.isEmpty) {
//                 return 'Please enter some text';
//               }
//               return null;
//             },
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 16.0),
//             child: ElevatedButton(
//               onPressed: () {
//                 // Validate returns true if the form is valid, or false otherwise.
//                 if (_formKey.currentState!.validate()) {
//                   // If the form is valid, display a snackbar. In the real world,
//                   // you'd often call a server or save the information in a database.
//                   ScaffoldMessenger.of(context)
//                       .showSnackBar(SnackBar(content: Text('Processing Data')));
//                 }
//               },
//               child: Text('Submit'),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//}
