import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:password_manager/utility/dbhelper.dart';
import 'package:provider/provider.dart';
import '../provider/auth_provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

//import '../utility/auth.dart';
import '../utility/box.dart';

class FirstName_screen extends StatefulWidget {
  @override
  _FirstName_screenState createState() => _FirstName_screenState();
}

class _FirstName_screenState extends State<FirstName_screen> {
  final _formKey = GlobalKey<FormState>();
  String Name = "";
  String Password = "";
  bool newUser = true;
  var user = Boxes.getIntro();

  void userExist() async {
    if (user.isEmpty) {
      newUser = false;
      print("User dosent Exist");
    } else {
      newUser = false;
      Name = user.name;
      print('User Exist');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    userExist();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    dynamic current = Provider.of<AuthProvider>(context);
    var name='Aditya';
    return Scaffold(
      backgroundColor: Colors.orangeAccent,
      body: newUser
          ? Center(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        onChanged: (value) {
                          Name = value;
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Enter Your Name"),
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
                        onChanged: (value) {
                          Password = value;
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "PassWord"),
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          print(Name);
                          print(Password);
                          //userExist();
                          //current.authenticated();
                        },
                        child: Text('Save'))
                  ],
                ),
              ),
            )
          : Center(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: Text(
                            'Sup!',
                            style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.w300,
                                fontStyle: FontStyle.italic,
                                color: Colors.white),
                          ),
                        )),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Text(
                          '$name',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w900,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        style: TextStyle(color: Colors.white),
                        cursorColor: Colors.white,

                        onChanged: (value) {
                          Password = value;
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
                          return null;
                        },
                      ),
                    ),
                    ElevatedButton(
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.teal)),
                        onPressed: () {
                          //user.name;
                          //userExist();
                          current.authenticated();
                        },
                        child: Text('Login'))
                  ],
                ),
              ),
            ),
    );
  }
}

// var box = Hive.box('myBox');
//
// box.put('name', 'David');
//
// var name = box.get('name');
//
// print('Name: $name');
//error: The argument type 'MaterialColor' can't be assigned to the parameter type 'MaterialStateProperty<Color?>?'. (argument_type_not_assignable at [password_manager] lib\screens\Name.dart:164)