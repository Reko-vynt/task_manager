import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/screen/add_task_page.dart';

class HomeNodata extends StatelessWidget {
  const HomeNodata({super.key});

  @override
  Widget build(BuildContext context) {
    final kW = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Image.asset('assets/images/Img.png'),
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          'No tasks found?',
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.w700),
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          'Try to create more tasks to your employees or create a new project and setup it from scratch',
          style: TextStyle(fontSize: 14, color: Color(0xff8181A5)),
          maxLines: 2,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 30,
        ),
        Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Color(0xff5E81F4)),
          width: kW / 2,
          height: 50,
          child: TextButton(
              onPressed: () async {
                await Get.to(() => AddTaskPage());
              },
              child: const Text(
                'Create',
                style: TextStyle(color: Colors.white),
              )),
        )
      ],
    );
  }
}
