// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sub_task_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SubTaskModelAdapter extends TypeAdapter<SubTaskModel> {
  @override
  final int typeId = 1;

  @override
  SubTaskModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SubTaskModel(
      idSub: fields[0] as String,
      subtasks: fields[1] as String,
      complete: fields[2] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, SubTaskModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.idSub)
      ..writeByte(1)
      ..write(obj.subtasks)
      ..writeByte(2)
      ..write(obj.complete);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubTaskModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubTaskModel _$SubTaskModelFromJson(Map<String, dynamic> json) => SubTaskModel(
      idSub: json['idSub'] as String,
      subtasks: json['subtasks'] as String,
      complete: json['complete'] as bool,
    );

Map<String, dynamic> _$SubTaskModelToJson(SubTaskModel instance) =>
    <String, dynamic>{
      'idSub': instance.idSub,
      'subtasks': instance.subtasks,
      'complete': instance.complete,
    };
