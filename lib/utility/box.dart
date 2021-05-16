import 'package:hive/hive.dart';
import 'package:password_manager/utility/dbhelper.dart';

class Boxes{
  static Box<Password> getPasswords() =>
      Hive.box<Password>('disguise');
  static Box<Intro> getIntro() =>
      Hive.box<Intro>('intro');
}