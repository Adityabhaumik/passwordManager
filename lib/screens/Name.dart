import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:password_manager/utility/dbhelper.dart';
import 'package:provider/provider.dart';
import '../provider/auth_provider.dart';
import 'package:dbcrypt/dbcrypt.dart';
import '../utility/box.dart';

class FirstName_screen extends StatefulWidget {
  @override
  _FirstName_screenState createState() => _FirstName_screenState();
}

class _FirstName_screenState extends State<FirstName_screen> {
  final _formKey = GlobalKey<FormState>();
  DBCrypt dBCrypt = DBCrypt();
  String Name = "";
  String Password = "";
  String CarryPass = "";
  bool newUser = true;
  bool hidepass= true;
  var user = Boxes.getIntro();

  void userExist() async {
    if (user.isEmpty) {
      newUser = true;
      print("User dosent Exist");
    } else {
      Intro myuser = Intro();
      newUser = false;
      myuser = user.getAt(0)!;
      Name = myuser.name;
      Password = myuser.password;
      print('User Exist ');
    }
  }

  void add(String name, String password) {
    String salt = dBCrypt.gensaltWithRounds(12);
    String hashedPwd = dBCrypt.hashpw(Password, salt);

    final temp = Intro();
    temp.name = name;
    temp.password = hashedPwd;
    final box = Boxes.getIntro();
    box.add(temp);
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
    return Scaffold(
      backgroundColor: Color(0xFF071330),
      body: newUser
          ? Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Welcome 🙏',
                      style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w900,
                          color: Colors.white),
                    ),
                    Text(
                      '**DO NOT FORGET THIS PASSWORD THERE IS NO WAY TO RECOVER IT**',
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: Colors.red),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              style: TextStyle(color: Colors.white),
                              onChanged: (value) {
                                Name = value;
                              },
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                focusColor: Colors.white,
                                border: OutlineInputBorder(
                                    gapPadding: 6,
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                labelText: "Enter Your Name",
                                labelStyle: TextStyle(color: Colors.white),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Enter Your Name';
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
                                Password = value;
                              },
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                focusColor: Colors.white,
                                border: OutlineInputBorder(
                                    gapPadding: 6,
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                labelText: "Password",
                                labelStyle: TextStyle(color: Colors.white),
                              ),
                              // The validator receives the text that the user has entered.
                              validator: (value) {
                                if (value.toString().length < 8) {
                                  return 'Please Enter more Than 8 Characters ';
                                }
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a Password';
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
                                Password = value;
                                CarryPass = Password;
                              },
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                focusColor: Colors.white,
                                border: OutlineInputBorder(
                                    gapPadding: 6,
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                labelText: "Confirm Password",
                                labelStyle: TextStyle(color: Colors.white),
                              ),
                              // The validator receives the text that the user has entered.
                              validator: (value) {
                                if (Password != value) {
                                  return 'Not Matched!';
                                }
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                            ),
                          ),
                          ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.orange),
                              ),
                              onPressed: () {
                                // if (_formKey.currentState!.validate()) {
                                //   print(Name);
                                //   print(Password);
                                add(Name, Password);
                                current.authenticated(CarryPass);
                                // }

                                //print();
                              },
                              child: Text('Save'))
                        ],
                      ),
                    ),
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
                          '$Name',
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
                        obscureText: hidepass,
                        style: TextStyle(color: Colors.white),
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                          suffixIcon: GestureDetector(
                            onTap: (){
                              setState(() {
                                hidepass=!hidepass;
                              });
                            },
                            child: Icon(
                              Icons.remove_red_eye_sharp,
                              color: hidepass?Colors.red[400]:Colors.greenAccent,
                            ),
                          ),
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
                            return 'Unable to Log IN';
                          } else {
                            if (dBCrypt.checkpw(value.toString(), Password)) {
                              //print('${value} ${Password}');
                              CarryPass = value;
                              return null;
                            } else {
                              return 'Unable to Log IN';
                            }
                          }
                        },
                      ),
                    ),
                    ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.orange),
                        ),
                        onPressed: () {
                          //user.name;
                          //userExist();
                          if (_formKey.currentState!.validate()) {
                            //print('from the button $Password');
                            current.authenticated(CarryPass);
                          }
                        },
                        child: Text('Login'))
                  ],
                ),
              ),
            ),
    );
  }
}
