import 'package:hive/hive.dart';
import 'package:encrypt/encrypt.dart';
part 'dbhelper.g.dart';

@HiveType(typeId: 0)
class Password extends HiveObject{
  @HiveField(0)
  late String name="Missing";
  @HiveField(1)
  late String username="Missing";
  @HiveField(2)
  late String email="Missing";
  @HiveField(3)
  late String password="Missing";
  @HiveField(4)
  late String iv="xyz";
}

@HiveType(typeId: 1)
class Intro extends HiveObject {
  @HiveField(0)
  late String name = "Missing";
  @HiveField(1)
  late String password = "Missing";
}