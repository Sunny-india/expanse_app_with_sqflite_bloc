import 'package:expanse_app_with_sqflite_bloc/utils/color_constants.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.titleWidget,
      required this.functionInsideButton,
      this.bgColor = ColorConstants.mainBlackColor,
      this.buttonHeight,
      this.buttonWidth});

  final Widget titleWidget;
  final VoidCallback functionInsideButton;
  final Color bgColor;
  final double? buttonHeight;
  final double? buttonWidth;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: buttonHeight,
      width: buttonWidth,
      child: ElevatedButton(
        onPressed: functionInsideButton,
        child: titleWidget,
      ),
    );
  }
}
