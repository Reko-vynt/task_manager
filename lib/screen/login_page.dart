import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/widget/custom_text.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final controller = TextEditingController();
  final fucusNode = FocusNode();
  String passcode = '';
  String checkPass = '';

  @override
  void initState() {
    // TODO: implement initState
    loadPreferences();
    super.initState();
  }

  Future<void> loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      passcode = prefs.getString('passcode') ?? '';
    });
  }

  Future<void> savePreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('passcode', controller.text);
    loadPreferences();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    fucusNode.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const defaultPinTheme = PinTheme(
      margin: EdgeInsets.zero,
      width: 81,
      height: 78,
      textStyle: TextStyle(
        fontSize: 20,
        color: Colors.black,
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        color: Color(0xfff5f5fa),
      ),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: passcode.isNotEmpty ? false : true,
        title: const ImageIcon(
          AssetImage("assets/images/lock.png"),
          color: Color(0xFF3757FF),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: passcode.isNotEmpty
              ? CrossAxisAlignment.start
              : CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 48,
            ),
            passcode.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: 'Wellcome\nBack!',
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xff141416),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        CustomText(
                          text: 'Please enter your passcode to unlock',
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xff777E90),
                        ),
                      ],
                    ),
                  )
                : Column(
                    children: [
                      CustomText(
                        text: 'Login in to Edumy!',
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xff141416),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      CustomText(
                        text: 'Please enter your passcode',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xff777E90),
                      ),
                    ],
                  ),
            const SizedBox(
              height: 48,
            ),
            Center(
              child: Container(
                width: 326,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: const Color(0xFFFCFCFD),
                  border: Border.all(
                      width: 2,
                      strokeAlign: BorderSide.strokeAlignOutside,
                      color: const Color(0xFFE6E8EC)),
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                ),
                child: Pinput(
                  controller: controller,
                  autofocus: true,
                  focusNode: fucusNode,
                  readOnly: true,
                  showCursor: true,
                  separatorBuilder: (index) => SizedBox(
                    height: 78,
                    width: 2,
                    child: Container(
                      color: const Color(0xffE6E8EC),
                    ),
                  ),
                  defaultPinTheme: defaultPinTheme,
                  focusedPinTheme: defaultPinTheme.copyWith(
                      decoration:
                          const BoxDecoration(color: Color(0xFFFFFFFF))),
                  submittedPinTheme: defaultPinTheme.copyWith(
                      decoration:
                          const BoxDecoration(color: Color(0xFFFFFFFF))),
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Center(
              child: CustomText(
                text: checkPass,
                color: Colors.red,
              ),
            ),
            const SizedBox(
              height: 39,
            ),
            SizedBox(
              height: 270,
              child: GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 3, // Number of items per row
                childAspectRatio: 2, // Adjust the aspect ratio as needed
                padding: const EdgeInsets.all(8.0),
                children: [
                  _buildKey('1'),
                  _buildKey('2'),
                  _buildKey('3'),
                  _buildKey('4'),
                  _buildKey('5'),
                  _buildKey('6'),
                  _buildKey('7'),
                  _buildKey('8'),
                  _buildKey('9'),
                  _buildKey('--'),
                  _buildKey('0'),
                  _buildKey('<-'),
                ],
              ),
            ),
            if (passcode.isEmpty)
              Center(
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff3757FF),
                        fixedSize: const Size(200, 56)),
                    onPressed: () {
                      if (controller.text.isNotEmpty) {
                        savePreferences();
                        Get.offNamed('/homepage');
                      }
                    },
                    child: CustomText(
                      text: 'Continue',
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    )),
              )
            else
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextButton(
                        onPressed: () {
                          setState(() {
                            controller.clear();
                            savePreferences();
                          });
                        },
                        child: CustomText(
                          text: 'Change passcode',
                          color: const Color(0xff3757FF),
                        )),
                    const SizedBox(
                      height: 40,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff3757FF),
                            fixedSize: const Size(200, 56)),
                        onPressed: () {
                          if (controller.text.isNotEmpty) {
                            if (passcode == controller.text) {
                              Get.offNamed('/homepage');
                            } else {
                              checkPass = 'Passcode incorrect';
                              setState(() {});
                            }
                          }
                        },
                        child: CustomText(
                          text: 'UNLOCK',
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        )),
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }

  Widget _buildKey(String keyLabel) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: TextButton(
        onPressed: () {
          if (keyLabel == '<-' || keyLabel == '--') {
            if (controller.text.isNotEmpty) {
              fucusNode.requestFocus();
              controller.text =
                  controller.text.substring(0, controller.text.length - 1);
              checkPass = '';
              setState(() {});
            }
          } else {
            if (controller.text.length < 4) {
              controller.text = '${controller.text}$keyLabel';
            }
          }
        },
        child: Builder(builder: (context) {
          if (keyLabel == '<-') {
            return Container(
                decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xff777E90)),
                    borderRadius: BorderRadius.circular(50)),
                child: const Icon(
                  Icons.chevron_left_outlined,
                  color: Color(0xff777E90),
                  size: 20,
                ));
          } else if (keyLabel == '--') {
            return const Icon(
              Icons.keyboard_arrow_down,
              color: Color(0xff777E90),
            );
          }
          return CustomText(
            text: keyLabel,
          );
        }),
      ),
    );
  }
}
