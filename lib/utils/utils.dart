import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Utils {
  static ThemeData myLightTheme() {
    return ThemeData(
      appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          titleTextStyle: TextStyle(color: CupertinoColors.label, fontSize: 18),
          centerTitle: true),
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
    );
  }

  static ThemeData myDarkTheme() {
    return ThemeData(
      appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          elevation: 0,
          titleTextStyle:
              TextStyle(color: CupertinoColors.systemPurple, fontSize: 18),
          centerTitle: true),
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
