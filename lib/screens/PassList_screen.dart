import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:password_manager/screens/AddPass_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'dart:math';
import 'package:hive/hive.dart';
import 'package:password_manager/screens/ViewEdit_screen.dart';
import 'package:password_manager/utility/box.dart';
import 'package:password_manager/utility/dbhelper.dart';
import 'package:hive_flutter/hive_flutter.dart';

class PassList_screen extends StatefulWidget {
  static const id = "PassList_screen";
  @override
  _PassList_screenState createState() => _PassList_screenState();
}
class _PassList_screenState extends State<PassList_screen> {
  @override
  void dispose() {
    // TODO: implement dispose
    Hive.close();
    super.dispose();
  }
  static Future<void> pop({bool? animated}) async {
    await SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop', animated);
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color(0xFF071330),
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                pop();
                //Provider.of<AuthProvider>(context).logout();
              })
        ],
        backgroundColor: Color(0xFF0C4160),
        title: Text("Password manager"),
      ),
      body: ValueListenableBuilder<Box<Password>>(
        valueListenable: Boxes.getPasswords().listenable(),
        builder: (context, box, _) {
          final pass = box.values.toList().cast<Password>();
          return StaggeredGridView.countBuilder(
            crossAxisCount: 4,
            itemCount: pass.length,
            itemBuilder: (BuildContext context, int index) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, ViewEdit_screen.id,
                      arguments: pass[index]);
                },
                child: new Container(
                    color: Colors
                        .primaries[Random().nextInt(Colors.primaries.length)],
                    child: new Center(
                      child: new Text('${pass[index].name}',style: TextStyle(color: Colors.white),),
                    )),
              ),
            ),
            staggeredTileBuilder: (int index) =>
                new StaggeredTile.count(2, index.isEven ? 2 : 1),
            mainAxisSpacing: 4.0,
            crossAxisSpacing: 4.0,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('password adding menu open');
          Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.rightToLeft,
                  child: AddPass_screen()));
        },
        child: const Icon(
          Icons.add,
          size: 42,
        ),
        backgroundColor: Colors.orangeAccent,
      ),
    );
  }
}
