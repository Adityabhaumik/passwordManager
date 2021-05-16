import 'package:flutter/material.dart';
import '../utility/dbhelper.dart';
import '../utility/box.dart';
import '../utility/dbhelper.dart';

class ViewEdit_screen extends StatefulWidget {
  static const id = "ViewEdit_screen";

  @override
  _ViewEdit_screenState createState() => _ViewEdit_screenState();
}

class _ViewEdit_screenState extends State<ViewEdit_screen> {
  final _formKey = GlobalKey<FormState>();
  bool edit = false;
  Password edited = Password();
  Password current = Password();

  // String myvalidator(value){
  //   if(1==1){
  //     return "";
  //   }
  //   return "Required!";
  // }
  //
  // void add(String name,String username,String email,String password,String hint){
  //   final temp=Password();
  //   temp.name=name;
  //   temp.email=email;
  //   temp.password=password;
  //   temp.hint=hint;
  //   final box =Boxes.getPasswords();
  //   box.add(temp);
  // }
  @override
  Widget build(BuildContext context) {
    current = ModalRoute.of(context)!.settings.arguments as Password;

    void enableEdit() {
      setState(() {
        edit = true;
        edited.name = current.name;
        edited.username = current.username;
        edited.email = current.email;
        edited.password = current.password;
        edited.hint = current.hint;
      });
    }

    void saveEdit() {
      setState(() {
        edit = false;
        print("INside set state${edit}");
      });

      print(edit);
    }

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
                          edited.name = value;
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
                          edited.username = value;
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
                          edited.email = value;
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
                      child: TextFormField(
                        onChanged: (value) {
                          edited.password = value;
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
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        onChanged: (value) {
                          edited.hint = value;
                        },
                        enabled: edit,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Hint : ${current.hint}"),
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
        ),
        floatingActionButton: edit
            ? FloatingActionButton.extended(
                backgroundColor: Colors.orangeAccent,
                onPressed: () {
                  current.name = edited.name;
                  current.username = edited.username;
                  current.email = edited.email;
                  current.password = edited.password;
                  current.hint = edited.hint;
                  setState(() {
                    current.save();
                  });
                  saveEdit();
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
