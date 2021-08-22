import 'package:flutter/material.dart';
import '../constants/color.dart';

class CustomCircularProgressIndicator extends StatelessWidget {
  const CustomCircularProgressIndicator(
      {Key? key, this.color, this.backGroundColor, this.value})
      : super(key: key);

  final Color? color;
  final Color? backGroundColor;
  final double? value;

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      strokeWidth: 2.0,
      backgroundColor: backGroundColor ?? kcGreyLight,
      color: color ?? kcGrey400,
      value: value,
    );
  }
}
