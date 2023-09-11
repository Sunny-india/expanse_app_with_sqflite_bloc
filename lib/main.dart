import 'package:expanse_app_with_sqflite_bloc/add_expanse_page.dart';
import 'package:expanse_app_with_sqflite_bloc/database_helper.dart';
import 'package:expanse_app_with_sqflite_bloc/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/expanase_bloc.dart';
import 'login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SQLHelper.singleInstance.getDB();
  runApp(
    BlocProvider(
      create: (context) => ExpanseBloc(db: SQLHelper.singleInstance),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.light,
        theme: Utils.myLightTheme(),
        darkTheme: Utils.myDarkTheme(),
        home: const AddExpansePage(),
      ),
    ),
  );
}
