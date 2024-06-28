// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sub_task_model.g.dart';

@HiveType(typeId: 1)
@JsonSerializable()
class SubTaskModel {
  @HiveField(0)
  @JsonKey(name: 'idSub')
  String idSub;
  @HiveField(1)
  @JsonKey(name: 'subtasks')
  String subtasks;
  @HiveField(2)
  @JsonKey(name: 'complete')
  bool complete;
  SubTaskModel({
    required this.idSub,
    required this.subtasks,
    required this.complete,
  });

  factory SubTaskModel.fromJson(Map<String, dynamic> json) =>
      _$SubTaskModelFromJson(json);
  Map<String, dynamic> toJson() => _$SubTaskModelToJson(this);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idSub': idSub,
      'subtasks': subtasks,
      'complete': complete,
    };
  }

  factory SubTaskModel.fromMap(Map<String, dynamic> map) {
    return SubTaskModel(
      idSub: map['idSub'] as String,
      subtasks: map['subtasks'] as String,
      complete: map['complete'] as bool,
    );
  }
}
