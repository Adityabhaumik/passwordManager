import 'package:flutter/material.dart';
import 'package:password_manager/utility/inputOutputClass.dart';
import '../utility/dbhelper.dart';
import '../utility/inputOutputClass.dart';
import 'package:provider/provider.dart';
import '../provider/auth_provider.dart';
import '../functions/ViewEdit_screenFunctions.dart';
import 'package:password_strength/password_strength.dart';

class ViewEdit_screen extends StatefulWidget {
  static const id = "ViewEdit_screen";

  @override
  _ViewEdit_screenState createState() => _ViewEdit_screenState();
}

class _ViewEdit_screenState extends State<ViewEdit_screen> {
  final _formKey = GlobalKey<FormState>();
  bool edit = false;
  inputPass local = inputPass();
  Password current = Password();
  bool loaded = false;
  Color passStrengthColor =Colors.greenAccent;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      final currentthis =
          ModalRoute.of(context)!.settings.arguments as Password;
      local.password = await decriptPass(context);
      local.name = await currentthis.name;
      local.username = await currentthis.username;
      local.email = await currentthis.email;
      setState(() {
        loaded = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final current = ModalRoute.of(context)!.settings.arguments as Password;

    final carry = Provider.of<AuthProvider>(context);
    return loaded
        ? Scaffold(
            backgroundColor: Color(0xFF071330),
            resizeToAvoidBottomInset: false,
            //backgroundColor:  Color(0xFF071330),
            appBar: AppBar(
              backgroundColor: Color(0xFF0C4160),
              actions: [
                edit
                    ? Container()
                    : IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          setState(() {
                            edit = true;
                          });
                        }),
                IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      current.delete();
                      Navigator.pop(context);
                    }),
              ],
              title: Text("View Edit Screen"),
            ),
            body: Padding(
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
                          enabled: edit,
                          onChanged: (value) {
                            if (value != null) {
                              local.name = value;
                            }
                          },

                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                            focusColor: Colors.white,
                            border: OutlineInputBorder(
                                gapPadding: 6,
                                borderSide: BorderSide(color: Colors.white)),
                            labelText: "Account For : ${local.name}",
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
                          enabled: edit,
                          onChanged: (value) {
                            local.username = value;
                          },

                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                            focusColor: Colors.white,
                            border: OutlineInputBorder(
                                gapPadding: 6,
                                borderSide: BorderSide(color: Colors.white)),
                            labelText: "User Name : ${local.username}",
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
                            if (value != null) {
                              local.email = value;
                            }
                          },
                          enabled: edit,

                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                            focusColor: Colors.white,
                            border: OutlineInputBorder(
                                gapPadding: 6,
                                borderSide: BorderSide(color: Colors.white)),
                            labelText: "Email : ${local.email}",
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
                            if (value != null) {
                              local.password = value;
                              double strength =
                              estimatePasswordStrength(value.toString());
                              if (strength <= 0.7) {
                                setState(() {
                                  passStrengthColor=Colors.red;
                                });
                              }
                              if (strength >= 0.7) {
                                setState(() {
                                  passStrengthColor=Colors.greenAccent;
                                });
                              }
                            }
                          },
                          enabled: edit,

                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                            focusColor: Colors.white,
                            border: OutlineInputBorder(
                                gapPadding: 6,
                                borderSide: BorderSide(color: Colors.white)),
                            labelText: "Password: ${local.password}",
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
                      edit?Center(
                        child: Container(
                          color: passStrengthColor,
                          height: MediaQuery.of(context).size.height * 0.008,
                          width: MediaQuery.of(context).size.width * 0.5,
                        ),
                      ):Container()
                    ],
                  ),
                ),
              ),
            ),
            floatingActionButton: edit
                ? FloatingActionButton.extended(
                    backgroundColor: Colors.orangeAccent,
                    onPressed: () {
                      print(local.name);
                      print(local.email);
                      print(local.username);
                      saveAfterEditing(local, carry.getPass(), current);
                      setState(() {
                        edit = false;
                      });
                    },
                    label: Text("Encrypt and Save"))
                : Container())
        : Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
  }
}
