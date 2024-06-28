// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:task_manager/controller/task_controller.dart';
import 'package:task_manager/model/sub_task_model.dart';
import 'package:task_manager/model/task_model.dart';
import 'package:task_manager/utils.dart';
import 'package:task_manager/widget/custom_text.dart';

class TaskDetailPage extends StatefulWidget {
  TaskModel task;

  TaskDetailPage({
    super.key,
    required this.task,
  });

  @override
  State<TaskDetailPage> createState() => _TaskDetailPageState();
}

class _TaskDetailPageState extends State<TaskDetailPage> {
  final TaskController controller = Get.find();
  late TaskModel task;
  @override
  void initState() {
    // TODO: implement initState
    task = TaskModel.fromMap(jsonDecode(jsonEncode(widget.task)));
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: CustomText(
          text: 'Tasks Details',
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
        actions: [
          IconButton(
              onPressed: () async {
                await controller.updateTask(task).then(
                  (value) {
                    Get.back();

                    Get.snackbar('Update Task Successful', '',
                        colorText: const Color(0xff8181a5),
                        snackPosition: SnackPosition.BOTTOM,
                        duration: const Duration(milliseconds: 800));
                  },
                );
              },
              icon: const Icon(Icons.check))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: CustomText(
                              text: task.title,
                              fontSize: 20,
                              fontWeight: FontWeight.w700),
                        ),
                        CustomText(
                          text:
                              'Task created on ${DateTime.parse(task.createDay).ddMMMyyyy}',
                        )
                      ],
                    ),
                  ),
                  Checkbox(
                    value: task.isComplete,
                    onChanged: (value) {
                      task.isComplete = value!;
                      setState(() {});
                    },
                  )
                ],
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: 'Due',
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xff8181A5),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xffECECF2)),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.calendar_month,
                          color: Color(0xff8181A5),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        CustomText(
                          text: DateTime.parse(task.dueDay).ddMMMyyyy,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: 'Description',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xff8181A5),
                  ),
                  TextFormField(
                    enabled: false,
                    initialValue: task.description,
                    maxLength: 3000,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffF0F0F3))),
                    ),
                    maxLines: 6,
                  )
                ],
              ),
            ),
            Flexible(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomText(
                      text: 'Subtasks',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xff8181A5),
                    ),
                    if (task.subTaskModel.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20, left: 10, right: 10, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              text: 'Checklist',
                            ),
                            CustomText(
                              text:
                                  '${task.subTaskModel.where((e) => e.complete).length} / ${task.subTaskModel.length}',
                            )
                          ],
                        ),
                      ),
                    if (task.subTaskModel.isNotEmpty)
                      LinearPercentIndicator(
                        barRadius: const Radius.circular(10),
                        percent:
                            task.subTaskModel.where((e) => e.complete).length /
                                task.subTaskModel.length,
                        progressColor: const Color(0xffF4BE5E),
                        backgroundColor: const Color(0xffF0F0F3),
                      ),
                    ListView.separated(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Container(
                            child: Row(
                              children: [
                                Checkbox(
                                  value: task.subTaskModel[index].complete,
                                  onChanged: (value) {
                                    SubTaskModel subTaskModel = SubTaskModel(
                                        idSub: task.subTaskModel[index].idSub,
                                        subtasks:
                                            task.subTaskModel[index].subtasks,
                                        complete: value!);
                                    task.subTaskModel[index] = subTaskModel;
                                    setState(() {});
                                  },
                                ),
                                CustomText(
                                  text: task.subTaskModel[index].subtasks,
                                )
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 10,
                          );
                        },
                        itemCount: task.subTaskModel.length)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
