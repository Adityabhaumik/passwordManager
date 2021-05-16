import 'package:flutter/material.dart';
import '../utility/dbhelper.dart';
import '../utility/box.dart';
class AddPass_screen extends StatefulWidget {
  static const id = "AddPass_screen";

  @override
  _AddPass_screenState createState() => _AddPass_screenState();
}

class _AddPass_screenState extends State<AddPass_screen> {
  final _formKey = GlobalKey<FormState>();
  final temp =Password();
  // String myvalidator(value){
  //   if(1==1){
  //     return "";
  //   }
  //   return "Required!";
  // }

  void add(String name,String username,String email,String password,String hint){
    final temp=Password();
    temp.name=name;
    temp.email=email;
    temp.password=password;
    temp.hint=hint;
    final box =Boxes.getPasswords();
    box.add(temp);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
      appBar: AppBar(
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
                        onChanged: (value){
                          temp.name = value;
                        },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), labelText: "Account For "),
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
                      onChanged: (value){
                        temp.username = value;
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), labelText: "User Name"),
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
                        onChanged: (value){
                          temp.email = value;
                        },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), labelText: "Email"),
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
                        onChanged: (value){
                          temp.password = value;
                        },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), labelText: "Password"),
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
                        onChanged: (value){
                          temp.hint = value;
                        },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), labelText: "Hint"),
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
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.orangeAccent,
          onPressed: (){
            add(temp.name, temp.username, temp.email,temp.password, temp.hint);

        print('this save button works');
      }, label: Text("Encrypt and Save"))
    );
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
