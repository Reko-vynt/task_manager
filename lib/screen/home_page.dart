import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/controller/task_controller.dart';
import 'package:task_manager/screen/add_task_page.dart';
import 'package:task_manager/widget/home_data.dart';
import 'package:task_manager/widget/home_nodata.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TaskController controller = Get.put(TaskController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Task'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () async {
                var check = await Get.to(() => AddTaskPage());
                if (check) {
                  setState(() {});
                }
              },
              icon: const Icon(Icons.add_outlined))
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.listTask.isEmpty) {
          return const HomeNodata();
        } else {
          return const HomeData();
        }
      }),
    );
  }
}
