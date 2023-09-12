import 'package:expanse_app_with_sqflite_bloc/blocs/users/users_bloc.dart';
import 'package:expanse_app_with_sqflite_bloc/blocs/users/users_event.dart';
import 'package:expanse_app_with_sqflite_bloc/database_helper.dart';
import 'package:expanse_app_with_sqflite_bloc/utils/my_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_page.dart';
import 'models/users_model.dart';
import 'my_widgets.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isTextObscured = true;
  TextEditingController cityController = TextEditingController();
  SQLHelper dbHelper = SQLHelper.singleInstance;
  static late Size size;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          reverse: true,
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Form(
            key: formKey,
            child: Container(
              width: size.width,
              height: size.height,
              alignment: Alignment.center,
              decoration: buildBoxDecoration(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    hSpacer(),
                    Text(
                      'Create Account',
                      style: TextStyle(fontSize: size.width * .09),
                    ),
                    hSpacer(mHeight: 70),

                    /// for name saving ///
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Enter name',
                      ),
                      controller: nameController,
                      validator: (value) {
                        if (value != null && value.isNotEmpty) {
                          if (value.isValidAlphabet() == true) {
                            return null;
                          } else {
                            return 'Please Enter only alphabets';
                          }
                        } else {
                          return 'Please enter your name';
                        }
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),

                    hSpacer(),

                    /// for phone saving ///
                    TextFormField(
                      decoration:
                          const InputDecoration(hintText: 'Enter Phone number'),
                      controller: phoneController,
                      validator: (value) {
                        if (value!.isNotEmpty) {
                          if (value.isValidNumber() == true) {
                            return null;
                          } else {
                            return 'Please Enter only 10-digit number';
                          }
                        } else {
                          return 'Please enter your phone';
                        }
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    const SizedBox(height: 12),

                    /// for email saving ///
                    TextFormField(
                      decoration:
                          const InputDecoration(hintText: 'Enter email'),
                      controller: emailController,
                      validator: (value) {
                        if (value!.isNotEmpty) {
                          if (value.isValidEmail() == true) {
                            return null;
                          } else {
                            return 'Please Enter valid email';
                          }
                        } else {
                          return 'Please enter your email';
                        }
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    const SizedBox(height: 12),

                    /// for password saving ///
                    TextFormField(
                      controller: passwordController,
                      obscureText: isTextObscured,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isTextObscured = !isTextObscured;
                            });
                          },
                          icon: const Icon(Icons.visibility),
                        ),
                        hintText: 'Enter password',
                      ),
                      validator: (value) {
                        if (value!.isNotEmpty) {
                          return null;
                        } else {
                          return 'Please enter some password';
                        }
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    const SizedBox(height: 12),

                    /// for city saving ///
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Enter city name',
                      ),
                      controller: cityController,
                      validator: (value) {
                        if (value!.isNotEmpty) {
                          if (value.isValidAlphabet() == true) {
                            return null;
                          } else {
                            return 'Please Enter only alphabets';
                          }
                        } else {
                          return 'Please enter your city name';
                        }
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    hSpacer(mHeight: 30),

                    /// for submitting this page's detail to database
                    CustomButton(
                        titleWidget: const Text('Submit Detail'),
                        functionInsideButton: () async {
                          // if (formKey.currentState!.validate()) {
                          //   // try {
                          //   //   //todo: login to sqflite
                          //   //   await dbHelper
                          //   //       .addUser(Users(
                          //   //           name: nameController.text.toString(),
                          //   //           phone: phoneController.text.toString(),
                          //   //           email: emailController.text.toString(),
                          //   //           password: passwordController.text.toString(),
                          //   //           city: cityController.text.toString()))
                          //   //       .whenComplete(() async {
                          //   //     formKey.currentState!.reset();
                          //   //     await Navigator.pushReplacement(context,
                          //   //         MaterialPageRoute(builder: (context) {
                          //   //       return const FirstPage();
                          //   //     }));
                          //   //   });
                          //   // } catch (e) {
                          //   //   print(e);
                          //   // }
                          // }
                          if (formKey.currentState!.validate()) {
                            context.read<UserBloc>().add(
                                  AddUsersEvent(
                                    user: Users(
                                      name: nameController.text.toString(),
                                      phone: phoneController.text.toString(),
                                      email: emailController.text.toString(),
                                      password:
                                          passwordController.text.toString(),
                                      city: cityController.text.toString(),
                                    ),
                                  ),
                                );
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return const LoginPage();
                            }));
                          }
                        })
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration buildBoxDecoration() {
    return const BoxDecoration(
      gradient: RadialGradient(
        center: Alignment(0.7, -0.6),
        radius: 0.2,
        colors: <Color>[
          Color(0xFFFFFF00),
          Color(0x68A0CD19),
        ],
        stops: <double>[0.4, 1.0],
      ),
    );
  }
}

extension ValidAlphabet on String {
  bool isValidAlphabet() {
    return RegExp(r'^(([a-zA-Z\s]+)([a-zA-Z]+))$').hasMatch(this);
  }
}

extension ValidNumber on String {
  bool isValidNumber() {
    return RegExp(r'^[0-9]{10}$').hasMatch(this);
  }
}

extension ValidEmail on String {
  bool isValidEmail() {
    return RegExp(
            r'^([a-zA-Z0-9]+)([-_.]*)([a-zA-Z0-9]*)([@])([a-zA-Z]{2,})([.])([a-zA-Z]{2,4})$')
        .hasMatch(this);
  }
}

extension ValidAmount on String {
  bool isValidAmount() {
    return RegExp(r'^(([1-9][0-9]*[.]?[0-9]{0,2})||([0]?[.][0]?[1-9]{1,2}))$')
        .hasMatch(this);
  }
}

extension ValidDetail on String {
  bool isValidDetail() {
    return RegExp(r'^(([a-zA-Z0-9\s]*)([a-zA-Z0-9]+))$').hasMatch(this);
  }
}
