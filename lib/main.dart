import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart';
import './screens/PassList_screen.dart';
import './screens/AddPass_screen.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import './utility/dbhelper.dart';
import './screens/ViewEdit_screen.dart';
import './screens/initislizeingbox.dart';
import './provider/auth_provider.dart';
import './screens/Name.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(IntroAdapter());
  await Hive.openBox<Intro>('intro');
  Hive.registerAdapter(PasswordAdapter());

  //await Hive.openBox<Password>('disguise');
  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool current = Provider.of<AuthProvider>(context).isAuthenticated();
    return current
        ? MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            home: initHive(),
            routes: {
              PassList_screen.id: (context) => PassList_screen(),
              AddPass_screen.id: (context) => AddPass_screen(),
              ViewEdit_screen.id: (context) => ViewEdit_screen(),
              initHive.id:(context) =>initHive()
            },
          )
        : MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            home: FirstName_screen(),
          );
  }
}
