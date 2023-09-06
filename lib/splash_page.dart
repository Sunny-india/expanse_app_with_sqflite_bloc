import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'first_page.dart';
import 'login_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    takeMeWhere();
    super.initState();
  }

  // retrieving the value from SharedPreferences
  void takeMeWhere() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    Timer(const Duration(seconds: 3), () {
      if (isLoggedIn == false) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const LoginPage();
            },
          ),
        );
      } else if (isLoggedIn == true) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return const FirstPage();
        }));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Material(
      child: Scaffold(
        body: SafeArea(
            child: Center(
          child: Text(
              'within 2 seconds, you would be taken to your page, depending upon you are logged in or not'),
        )),
      ),
    );
  }
}
