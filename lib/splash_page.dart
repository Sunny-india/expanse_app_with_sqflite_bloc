import 'dart:async';

import 'package:expanse_app_with_sqflite_bloc/utils/image_constants.dart';
import 'package:expanse_app_with_sqflite_bloc/utils/my_styles.dart';
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
    // takeMeWhere();
    super.initState();
  }

  // retrieving the value from SharedPreferences
  // and based on that send user to their relevant page
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
    Size size = MediaQuery.sizeOf(context);
    print(size);
    print(size.width * .109);
    return Material(
      child: Scaffold(
        body: SafeArea(
            child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: Colors.grey,
                radius: size.width * .11,
                child: Image.asset(
                  ImageConstants.appLogo,
                  fit: BoxFit.contain,
                  width: size.width * .109,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Expanse App',
                style: mTextStyle43(
                  mWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
