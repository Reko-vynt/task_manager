// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskModelAdapter extends TypeAdapter<TaskModel> {
  @override
  final int typeId = 0;

  @override
  TaskModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TaskModel(
      id: fields[0] as String,
      createDay: fields[1] as String,
      dueDay: fields[2] as String,
      title: fields[3] as String,
      description: fields[4] as String,
      isComplete: fields[5] as bool,
      subTaskModel: (fields[6] as List).cast<SubTaskModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, TaskModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.createDay)
      ..writeByte(2)
      ..write(obj.dueDay)
      ..writeByte(3)
      ..write(obj.title)
      ..writeByte(4)
      ..write(obj.description)
      ..writeByte(5)
      ..write(obj.isComplete)
      ..writeByte(6)
      ..write(obj.subTaskModel);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskModel _$TaskModelFromJson(Map<String, dynamic> json) => TaskModel(
      id: json['id'] as String,
      createDay: json['create_day'] as String,
      dueDay: json['due_day'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      isComplete: json['is_complete'] as bool,
      subTaskModel: (json['sub_tasks'] as List<dynamic>)
          .map((e) => SubTaskModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TaskModelToJson(TaskModel instance) => <String, dynamic>{
      'id': instance.id,
      'create_day': instance.createDay,
      'due_day': instance.dueDay,
      'title': instance.title,
      'description': instance.description,
      'is_complete': instance.isComplete,
      'sub_tasks': instance.subTaskModel.map((e) => e.toJson()).toList(),
    };
