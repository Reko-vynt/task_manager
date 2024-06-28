import 'package:animated_segmented_tab_control/animated_segmented_tab_control.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/controller/task_controller.dart';
import 'package:task_manager/screen/add_task_page.dart';
import 'package:task_manager/screen/task_detail_page.dart';
import 'package:task_manager/widget/custom_text.dart';

class HomeData extends StatefulWidget {
  const HomeData({super.key});
  @override
  State<HomeData> createState() => _HomeDataState();
}

class _HomeDataState extends State<HomeData> with TickerProviderStateMixin {
  final TaskController controller = Get.find();
  final addTaskController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var listDoneTask = controller.listTask.where((e) => e.isComplete).toList();

    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 10),
              child: const SegmentedTabControl(
                  squeezeIntensity: 2,
                  height: 50,
                  barDecoration: BoxDecoration(color: Color(0xFFf5f5fa)),
                  tabTextColor: Color(0xff8181a5),
                  selectedTabTextColor: Color(0xff8181a5),
                  tabs: [
                    SegmentTab(label: 'All'),
                    SegmentTab(label: 'Done'),
                    SegmentTab(label: 'Pending'),
                  ]),
            ),
            Obx(() => Flexible(
                  fit: FlexFit.loose,
                  child: TabBarView(children: [
                    Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                              top: 10, left: 10, right: 10),
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Checkbox(
                                value: false,
                                onChanged: (value) {},
                              ),
                              Expanded(
                                child: TextField(
                                  keyboardType: TextInputType.text,
                                  controller: addTaskController,
                                  onTapOutside: (event) {
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                  },
                                  onSubmitted: (value) async {
                                    var check = await Get.to(() => AddTaskPage(
                                          taskTitle: addTaskController.text,
                                        ));
                                    if (check) {
                                      setState(() {});
                                      addTaskController.clear();
                                    }
                                  },
                                  onChanged: (value) {},
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Type to add a new task …'),
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Flexible(
                          fit: FlexFit.loose,
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            child: ListView.separated(
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () async {
                                      Get.to(() => TaskDetailPage(
                                              task:
                                                  controller.listTask[index]))!
                                          .then(
                                        (value) {
                                          setState(() {});
                                        },
                                      );
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      child: Row(
                                        children: [
                                          Checkbox(
                                            value: controller
                                                .listTask[index].isComplete,
                                            onChanged: (value) {},
                                          ),
                                          CustomText(
                                            text: controller
                                                .listTask[index].title,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return const SizedBox(
                                    height: 10,
                                  );
                                },
                                itemCount: controller.listTask.length),
                          ),
                        ),
                      ],
                    ),
                    Obx(
                      () => Container(
                        padding: const EdgeInsets.all(10),
                        child: ListView.separated(
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Get.to(() => TaskDetailPage(
                                          task: controller.listTask
                                              .where((e) => e.isComplete)
                                              .toList()[index]))!
                                      .then(
                                    (value) {
                                      setState(() {});
                                    },
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Row(
                                    children: [
                                      Checkbox(
                                        value: controller.listTask
                                            .where((e) => e.isComplete)
                                            .toList()[index]
                                            .isComplete,
                                        onChanged: (value) {},
                                      ),
                                      CustomText(
                                        text: controller.listTask
                                            .where((e) => e.isComplete)
                                            .toList()[index]
                                            .title,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                height: 10,
                              );
                            },
                            itemCount: controller.listTask
                                .where((e) => e.isComplete)
                                .toList()
                                .length),
                      ),
                    ),
                    Obx(() {
                      return Container(
                        padding: const EdgeInsets.all(10),
                        child: ListView.separated(
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Get.to(() => TaskDetailPage(
                                          task: controller.listTask
                                              .where((e) => !e.isComplete)
                                              .toList()[index]))!
                                      .then(
                                    (value) {
                                      setState(() {});
                                    },
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Row(
                                    children: [
                                      Checkbox(
                                        value: controller.listTask
                                            .where((e) => !e.isComplete)
                                            .toList()[index]
                                            .isComplete,
                                        onChanged: (value) {},
                                      ),
                                      CustomText(
                                        text: controller.listTask
                                            .where((e) => !e.isComplete)
                                            .toList()[index]
                                            .title,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                height: 10,
                              );
                            },
                            itemCount: controller.listTask
                                .where((e) => !e.isComplete)
                                .toList()
                                .length),
                      );
                    })
                  ]),
                ))
          ],
        ),
      ),
    );
  }
}
