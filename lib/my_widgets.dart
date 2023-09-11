import 'package:expanse_app_with_sqflite_bloc/utils/color_constants.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.titleWidget,
      required this.functionInsideButton,
      this.bgColor = ColorConstants.mainBlackColor});
  final Widget titleWidget;
  final VoidCallback functionInsideButton;
  final Color bgColor;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: functionInsideButton,
      child: titleWidget,
    );
  }
}
