import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'color_constants.dart';

class Utils {
  static ThemeData myLightTheme() {
    return ThemeData(
      scaffoldBackgroundColor: ColorConstants.mainGreyColor,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleTextStyle: TextStyle(
          color: ColorConstants.mainBlackColor,
          fontSize: 18,
        ),
      ),
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
      listTileTheme: ListTileThemeData(
        minLeadingWidth: 20,
        tileColor: Colors.lightBlue.withOpacity(.34),
        leadingAndTrailingTextStyle: const TextStyle(
          color: Colors.indigo,
          fontSize: 15,
        ),
        titleTextStyle: TextStyle(
          color: Colors.indigo.shade600,
          fontSize: 15,
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.lightBlue.withOpacity(.34),
          foregroundColor: Colors.indigo),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            backgroundColor: CupertinoColors.systemTeal,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20))),
      ),
    );
  }

  static ThemeData myDarkTheme() {
    return ThemeData(
      //    scaffoldBackgroundColor: Colors.black12,
      appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          elevation: 0,
          titleTextStyle:
              TextStyle(color: CupertinoColors.systemPurple, fontSize: 18),
          centerTitle: false),
      listTileTheme: ListTileThemeData(
        minLeadingWidth: 20,
        tileColor: Colors.grey.shade700.withOpacity(.13),
        leadingAndTrailingTextStyle: TextStyle(
          color: Colors.purple.shade600,
          fontSize: 15,
        ),
        titleTextStyle: TextStyle(
          color: Colors.purple.shade600,
          fontSize: 15,
        ),
      ),
    );
  }
}
