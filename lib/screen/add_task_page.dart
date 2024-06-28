// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/controller/task_controller.dart';
import 'package:task_manager/model/sub_task_model.dart';
import 'package:task_manager/model/task_model.dart';
import 'package:task_manager/utils.dart';
import 'package:task_manager/widget/custom_text.dart';
import 'package:uuid/uuid.dart';

class AddTaskPage extends StatefulWidget {
  String? taskTitle;
  AddTaskPage({
    super.key,
    this.taskTitle,
  });

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final taskTitleController = TextEditingController();
  final subTaskController = TextEditingController();
  final descriptionController = TextEditingController();
  final TaskController controller = Get.find();
  List<String> subTasks = [];
  String selectDate = 'Select Date';
  DateTime? dueDay;
  var uuid = const Uuid();
  String? errorText;
  @override
  void initState() {
    if (widget.taskTitle != null) {
      taskTitleController.text = widget.taskTitle!;
    }
    super.initState();
  }

  void onSubmitCheck() {
    setState(() {
      if (taskTitleController.text.isEmpty) {
        errorText = 'The title can not empty';
      } else {
        errorText = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Container(
            color: const Color(0xFFf5f5f5),
            height: 3.0,
          ),
        ),
        centerTitle: true,
        title: CustomText(
          text: 'Add New Task',
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
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
                          child: TextField(
                            keyboardType: TextInputType.text,
                            controller: taskTitleController,
                            onTapOutside: (event) {
                              FocusManager.instance.primaryFocus?.unfocus();
                            },
                            onChanged: (value) {
                              onSubmitCheck();
                            },
                            decoration: InputDecoration(
                                errorText: errorText,
                                border: InputBorder.none,
                                hintText: 'Type your task'),
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w700),
                          ),
                        ),
                        CustomText(
                          text: 'Task created on ${now.ddMMMyyyy}',
                        )
                      ],
                    ),
                  ),
                  Checkbox(
                    value: false,
                    onChanged: (value) {},
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
                    child: TextButton(
                        onPressed: () async {
                          dueDay = await showDatePicker(
                              context: context,
                              firstDate: now,
                              lastDate: now.add(const Duration(days: 1000)));
                          if (dueDay != null) {
                            setState(() {
                              selectDate = dueDay!.ddMMMyyyy;
                            });
                          }
                        },
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
                              text: selectDate,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            )
                          ],
                        )),
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
                    controller: descriptionController,
                    maxLength: 3000,
                    decoration: const InputDecoration(
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xffF0F0F3))),
                        hintText: 'Start typing…',
                        hintStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff8181A5),
                        )),
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
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              if (subTaskController.text.isNotEmpty) {
                                subTasks.add(subTaskController.text);
                                subTaskController.clear();
                              }
                            });
                          },
                          icon: const Icon(Icons.add_circle_outline_outlined),
                          color: const Color(0xff8181A5),
                        ),
                        Expanded(
                          child: TextField(
                            controller: subTaskController,
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Type to add more ...'),
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Color(0xff8181A5)),
                          ),
                        ),
                      ],
                    ),
                    ListView.separated(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Container(
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    subTasks.removeAt(index);
                                    setState(() {});
                                  },
                                  icon: const Icon(
                                      Icons.remove_circle_outline_outlined),
                                  color: const Color(0xff8181A5),
                                ),
                                CustomText(
                                  text: subTasks[index],
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
                        itemCount: subTasks.length)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      bottomSheet: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
              backgroundColor: const Color(0xff5E81F4),
              padding: const EdgeInsets.all(20)),
          onPressed: (taskTitleController.text.isNotEmpty && dueDay != null)
              ? () async {
                  var listsubtask = subTasks
                      .map((e) => SubTaskModel(
                          idSub: uuid.v4().toString(),
                          subtasks: e,
                          complete: false))
                      .toList();

                  var taskModel = TaskModel(
                      id: uuid.v1().toString(),
                      createDay: now.toString(),
                      dueDay: dueDay.toString(),
                      title: taskTitleController.text,
                      description: descriptionController.text.toString(),
                      isComplete: false,
                      subTaskModel: listsubtask);
                  await controller.addTask(taskModel).then(
                    (value) {
                      Get.back(result: true);
                      Get.snackbar('Add Task Successful', '',
                          colorText: const Color(0xff8181a5),
                          snackPosition: SnackPosition.BOTTOM);
                    },
                  );
                }
              : () {
                  onSubmitCheck();
                },
          child: CustomText(
            text: 'Create New Task',
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
