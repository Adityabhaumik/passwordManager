import 'package:flutter/material.dart';
import '../screens/PassList_screen.dart';
import 'package:hive/hive.dart';
import '../utility/dbhelper.dart';
import '../screens/PassList_screen.dart';
class initHive extends StatefulWidget {
  static const id = "initHive";
  @override
  _initHiveState createState() => _initHiveState();
}

class _initHiveState extends State<initHive> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Hive.openBox<Password>('disguise'),
        builder: (BuildContext context,AsyncSnapshot snapshot) {
          if(snapshot.connectionState == ConnectionState.done){
            if(snapshot.hasError){
              return Center(child: Text("Error",style: TextStyle(color: Colors.red,fontSize: 35),));
            }
            return PassList_screen();
          }
          return Center(child: CircularProgressIndicator());
        }
    );
  }
}
