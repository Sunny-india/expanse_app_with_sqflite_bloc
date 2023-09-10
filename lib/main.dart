import 'package:expanse_app_with_sqflite_bloc/add_expanse_page.dart';
import 'package:expanse_app_with_sqflite_bloc/database_helper.dart';
import 'package:expanse_app_with_sqflite_bloc/utils/utils.dart';
import 'package:flutter/material.dart';

import 'login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SQLHelper.singleInstance.getDB();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: Utils.myLightTheme(),
      darkTheme: Utils.myDarkTheme(),
      home: const AddExpansePage(),
    ),
  );
}
