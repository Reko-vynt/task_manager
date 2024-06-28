import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:task_manager/model/task_model.dart';
import 'package:task_manager/service/task_service.dart';

class TaskControllerBindings implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => TaskController());
  }
}

class TaskController extends GetxController {
  final listTask = <TaskModel>[].obs;
  final isLoading = true.obs;
  final isConnected = false.obs;
  final Box<TaskModel> taskBox = Hive.box<TaskModel>('tasks');
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    checkConnectivity();
  }

  Future<void> checkConnectivity() async {
    await Connectivity().checkConnectivity().then(
      (value) {
        if (value.contains(ConnectivityResult.none)) {
          isConnected(false);
          loadTask();
        } else {
          isConnected(true);
          loadTask();
        }
      },
    );
    Connectivity().onConnectivityChanged.listen((result) async {
      if (result.contains(ConnectivityResult.none)) {
        isConnected(false);
        loadTask();
      } else {
        isConnected(true);
        await syncLocalChanges();
        loadTask();
      }
    });
  }

  Future<void> loadTask() async {
    try {
      isLoading(true);
      if (isConnected.value) {
        listTask.value = await TaskService().getTask();
        await taskBox.clear();
        for (var task in listTask) {
          taskBox.add(task);
        }
      } else {
        var localTask = taskBox.values;
        listTask.assignAll(localTask);
      }
    } catch (e) {
      if (kDebugMode) log('loi');
    } finally {
      isLoading(false);
    }
  }

  Future<void> addTask(TaskModel task) async {
    try {
      if (isConnected.value) {
        await TaskService().addTask(task);
      }
      taskBox.add(task);
      listTask.add(task);
    } catch (e) {
      if (kDebugMode) log('loi');
    }
  }

  Future<void> updateTask(TaskModel task) async {
    try {
      if (isConnected.value) {
        await TaskService().updateTask(task);
      }
      int index = taskBox.values.toList().indexWhere((e) => e.id == task.id);
      if (index != -1) {
        taskBox.put(index, task);
      }
      index = listTask.indexWhere((e) => e.id == task.id);
      listTask[index] = task;
    } catch (e) {
      if (kDebugMode) log('loi');
    }
  }

  Future<void> syncLocalChanges() async {
    try {
      var localTask = taskBox.values.toList();
      listTask.value = await TaskService().getTask();
      for (var taskBox in localTask) {
        int index = listTask.indexWhere((e) => e.id == taskBox.id);
        if (index == -1) {
          await TaskService().addTask(taskBox);
        } else {
          await TaskService().updateTask(taskBox);
        }
      }
    } catch (e) {
      if (kDebugMode) log('loi');
    }
  }
}
