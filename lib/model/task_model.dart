// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:task_manager/model/sub_task_model.dart';

part 'task_model.g.dart';

@HiveType(typeId: 0)
@JsonSerializable(explicitToJson: true)
class TaskModel extends HiveObject {
  @HiveField(0)
  @JsonKey(name: 'id')
  String id;
  @HiveField(1)
  @JsonKey(name: 'create_day')
  String createDay;
  @HiveField(2)
  @JsonKey(name: 'due_day')
  String dueDay;
  @HiveField(3)
  @JsonKey(name: 'title')
  String title;
  @HiveField(4)
  @JsonKey(name: 'description')
  String description;
  @HiveField(5)
  @JsonKey(name: 'is_complete')
  bool isComplete;
  @HiveField(6)
  @JsonKey(name: 'sub_tasks')
  List<SubTaskModel> subTaskModel;

  TaskModel({
    required this.id,
    required this.createDay,
    required this.dueDay,
    required this.title,
    required this.description,
    required this.isComplete,
    required this.subTaskModel,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) =>
      _$TaskModelFromJson(json);
  Map<String, dynamic> toJson() => _$TaskModelToJson(this);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'createDay': createDay,
      'dueDay': dueDay,
      'title': title,
      'description': description,
      'isComplete': isComplete,
      'subTaskModel': subTaskModel.map((x) => x.toMap()).toList(),
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'] as String,
      createDay: map['create_day'] as String,
      dueDay: map['due_day'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      isComplete: map['is_complete'] as bool,
      subTaskModel: List<SubTaskModel>.from(
        (map['sub_tasks'] as List<dynamic>).map<SubTaskModel>(
          (x) => SubTaskModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }
}
