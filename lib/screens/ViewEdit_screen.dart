import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart';
import 'package:password_manager/utility/inputOutputClass.dart';
import '../utility/dbhelper.dart';
import '../utility/box.dart';
import '../utility/dbhelper.dart';
import '../utility/inputOutputClass.dart';
import 'package:provider/provider.dart';
import '../provider/auth_provider.dart';
import 'package:encrypt/encrypt.dart' as enc;
import '../provider/auth_provider.dart';
import 'package:random_string/random_string.dart';
import 'dart:math' show Random;
import 'package:characters/characters.dart';
import '../functions/ViewEdit_screenFunctions.dart';

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
                          enabled: edit,
                          onChanged: (value) {
                            if (value != null) {
                              local.name = value;
                            }
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Name: ${local.name} "),
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
                          enabled: edit,
                          onChanged: (value) {
                            local.username = value;
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "User Name : ${local.username}"),
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
                            if (value != null) {
                              local.email = value;
                            }
                          },
                          enabled: edit,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Email : ${local.email}"),
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
                            if (value != null) {
                              local.password = value;
                            }
                          },
                          enabled: edit,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Password : ${local.password}"),
                          // The validator receives the text that the user has entered.
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
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
