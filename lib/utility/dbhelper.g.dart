// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dbhelper.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PasswordAdapter extends TypeAdapter<Password> {
  @override
  final int typeId = 0;

  @override
  Password read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Password()
      ..name = fields[0] as String
      ..username = fields[1] as String
      ..email = fields[2] as String
      ..password = fields[3] as String
      ..hint = fields[4] as String;
  }

  @override
  void write(BinaryWriter writer, Password obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.username)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.password)
      ..writeByte(4)
      ..write(obj.hint);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PasswordAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class IntroAdapter extends TypeAdapter<Intro> {
  @override
  final int typeId = 1;

  @override
  Intro read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Intro()
      ..name = fields[0] as String
      ..password = fields[1] as String;
  }

  @override
  void write(BinaryWriter writer, Intro obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.password);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IntroAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
