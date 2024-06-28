import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_manager/model/task_model.dart';

class TaskService {
  CollectionReference taskCollection =
      FirebaseFirestore.instance.collection('task');
  Future addTask(TaskModel task) async {
    try {
      await taskCollection.add(jsonDecode(jsonEncode(task.toJson())));
    } catch (e) {
      rethrow;
    }
  }

  Future<List<TaskModel>> getTask() async {
    try {
      List<TaskModel> list;
      var result = await taskCollection.get();
      list = result.docs
          .map((e) => TaskModel.fromJson(
              jsonDecode(jsonEncode(e.data())) as Map<String, dynamic>))
          .toList();
      return list;
    } catch (e) {
      rethrow;
    }
  }

  Future updateTask(TaskModel task) async {
    try {
      QuerySnapshot snapshot =
          await taskCollection.where('id', isEqualTo: task.id).get();
      if (snapshot.docs.isNotEmpty) {
        snapshot.docs.first.reference.update(task.toJson());
      } else {}
    } catch (e) {
      rethrow;
    }
  }
}
