import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Utils {
  static ThemeData myLightTheme() {
    return ThemeData(
      inputDecorationTheme: InputDecorationTheme(
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: CupertinoColors.destructiveRed)),
        disabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: CupertinoColors.inactiveGray)),
        //  focusColor: CupertinoColors.destructiveRed,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  static ThemeData myDarkTheme() {
    return ThemeData();
  }
}
