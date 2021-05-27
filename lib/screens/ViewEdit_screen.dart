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

  String decriptPass(context) {
    final carry = Provider.of<AuthProvider>(context);
    final key = enc.Key.fromUtf8(carry.getPass());
    final encrypter = Encrypter(AES(key));
    final decrypted = encrypter.decrypt64(current.password, iv: current.iv);
    return decrypted;
  }
  void saveAfterEditing(inputPass a,
      String actualkey,Password here) {
    final key = enc.Key.fromUtf8('${actualkey}');
    final iv = enc.IV.fromUtf8(randomAlphaNumeric(20));
    final encrypter = enc.Encrypter(enc.AES(key));
    final encrypted = encrypter.encrypt(a.password, iv: iv);

    here.name = a.name;
    here.username =a.username;
    here.email = a.email;
    here.password = encrypted.base64;
    here.iv=iv;
    // final box = Boxes.getPasswords();
    // box.add(temp);
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      local.password = decriptPass(context);
      local.name=current.name;
      local.username=current.username;
      local.email=current.email;
    });
  }

  @override
  Widget build(BuildContext context) {
    final current = ModalRoute
        .of(context)!
        .settings
        .arguments as Password;

    void enableEdit() {
      setState(() {
        edit = true;
     });
    }

    void saveEdit(inputPass x,String key,Password y) {

      //saveAfterEditing(x, key,y);


      setState(() {
        edit = false;
        print("INside set state${edit}");
      });

      print(edit);
    }

    final carry = Provider.of<AuthProvider>(context);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        //backgroundColor:  Color(0xFF071330),
        appBar: AppBar(
          backgroundColor: Color(0xFF0C4160),
          actions: [
            edit
                ? Container()
                : IconButton(icon: Icon(Icons.edit), onPressed: enableEdit),
            IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  current.delete();
                  Navigator.pop(context);
                }),
          ],
          title: Text("View Edit Screen"),
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
                        enabled: edit,
                        onChanged: (value) {
                          local.name = value;
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Name: ${current.name} "),
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
                            labelText: "User Name : ${current.username}"),
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
                          local.email = value;
                        },
                        enabled: edit,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Email : ${current.email}"),
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
                      child: Row(
                        children: [
                          TextFormField(
                            onChanged: (value) {
                              local.password = value;
                            },
                            enabled: edit,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Password : ${current.password}"),
                            // The validator receives the text that the user has entered.
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                          IconButton(icon: Icon(Icons.remove_red_eye_sharp), onPressed: (){})
                        ],
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: TextFormField(
                    //     onChanged: (value) {
                    //       local.hint = value;
                    //     },
                    //     enabled: edit,
                    //     decoration: InputDecoration(
                    //         border: OutlineInputBorder(),
                    //         labelText: "Hint : ${current.hint}"),
                    //     // The validator receives the text that the user has entered.
                    //     validator: (value) {
                    //       if (value == null || value.isEmpty) {
                    //         return 'Please enter some text';
                    //       }
                    //       return null;
                    //     },
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ),
        floatingActionButton: edit
            ? FloatingActionButton.extended(
            backgroundColor: Colors.orangeAccent,
            onPressed: () {
                 saveEdit(local,carry.getPass(),current);
            },
            label: Text("Encrypt and Save"))
            : Container());
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
