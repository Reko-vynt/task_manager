import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  String? text;
  double? fontSize;
  FontWeight? fontWeight;
  Color? color;
  CustomText(
      {this.text,
      this.fontSize = 14,
      this.fontWeight = FontWeight.normal,
      this.color = Colors.black,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      style:
          TextStyle(fontSize: fontSize, fontWeight: fontWeight, color: color),
    );
  }
}
