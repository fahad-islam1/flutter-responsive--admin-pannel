// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accounts_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AccountsDataAdapter extends TypeAdapter<AccountsData> {
  @override
  final int typeId = 1;

  @override
  AccountsData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AccountsData(
      id: fields[0] as String,
      totalLoad: fields[1] as int,
      sendedLoad: fields[2] as int,
      remainingLoad: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, AccountsData obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.totalLoad)
      ..writeByte(2)
      ..write(obj.sendedLoad)
      ..writeByte(3)
      ..write(obj.remainingLoad);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AccountsDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
