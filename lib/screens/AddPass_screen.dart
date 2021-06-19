import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:password_strength/password_strength.dart';
import 'package:provider/provider.dart';
import '../provider/auth_provider.dart';
import '../utility/inputOutputClass.dart';
import '../functions/AddPass_screenFunctions.dart';

class AddPass_screen extends StatefulWidget {
  static const id = "AddPass_screen";

  @override
  _AddPass_screenState createState() => _AddPass_screenState();
}

class _AddPass_screenState extends State<AddPass_screen> {
  final _formKey = GlobalKey<FormState>();
  final tempinput = inputPass();
  Color passStrengthColor =Colors.transparent;
  @override
  Widget build(BuildContext context) {
    dynamic current = Provider.of<AuthProvider>(context);
    return Scaffold(
      backgroundColor: Color(0xFF071330),
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
                        tempinput.name = value;
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
                        tempinput.username = value;
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
                        tempinput.email = value;
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
                        tempinput.password = value;
                        double strength =
                        estimatePasswordStrength(value.toString());
                        if (strength <= 0.7) {
                          setState(() {
                            passStrengthColor=Colors.red;
                          });

                        }
                        if (strength > 0.7) {
                          setState(() {
                            passStrengthColor=Colors.greenAccent;
                          });
                          print('this worked');

                        }
                      },
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        focusColor: Colors.white,
                        border: OutlineInputBorder(
                            gapPadding: 6,
                            borderSide: BorderSide(color: Colors.white)),
                        labelText: "Password",
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
                          setState(() {
                            passStrengthColor=Colors.red;
                          });
                          return null;
                        }
                        if (strength > 0.7) {
                          setState(() {
                            passStrengthColor=Colors.greenAccent;
                          });
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
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        focusColor: Colors.white,
                        border: OutlineInputBorder(
                            gapPadding: 6,
                            borderSide: BorderSide(color: Colors.white)),
                        labelText: "Confirm Password",
                        labelStyle: TextStyle(color: Colors.white),
                      ),
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        print('Validation Works');
                        if (value == null || value.isEmpty) {
                          return 'Please enter some Hint';
                        }
                        if (value == tempinput.password) {
                          return null;
                        }
                        return "Error!";
                      },
                    ),
                  ),
                  Center(
                    child: Container(
                      color: passStrengthColor,
                      height: MediaQuery.of(context).size.height * 0.008,
                      width: MediaQuery.of(context).size.width * 0.5,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.orangeAccent,
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            add(tempinput.name, tempinput.username, tempinput.email,
                tempinput.password, current.getPass());
            Navigator.pop(context);
          }
        },
        label: Text("Encrypt and Save"),
      ),
    );
  }
}
