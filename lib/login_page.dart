import 'package:expanse_app_with_sqflite_bloc/database_helper.dart';
import 'package:expanse_app_with_sqflite_bloc/first_page.dart';
import 'package:expanse_app_with_sqflite_bloc/models/users_model.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  bool isTextObscured = true;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  SQLHelper databaseHelper = SQLHelper.singleInstance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          reverse: true,
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Form(
            key: formKey,
            child: Column(
              children: [
                /// for name saving ///
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Enter name',
                  ),
                  controller: nameController,
                  validator: (value) {
                    if (value!.isNotEmpty) {
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
                const SizedBox(height: 12),

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
                  decoration: const InputDecoration(hintText: 'Enter email'),
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
                      icon: Icon(Icons.visibility),
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
                const SizedBox(height: 32),
                ElevatedButton(
                    onPressed: () async {
                      try {
                        if (formKey.currentState!.validate()) {
                          //todo: login to sqflite
                          await databaseHelper
                              .addUser(Users(
                                  name: nameController.text.toString(),
                                  phone: phoneController.text.toString(),
                                  email: emailController.text.toString(),
                                  password: passwordController.text.toString(),
                                  city: cityController.text.toString()))
                              .whenComplete(() async {
                            formKey.currentState!.reset();
                            await Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) {
                              return FirstPage();
                            }));
                          });
                        }
                      } catch (e) {
                        print(e);
                      }
                    },
                    child: Text('Submit Details')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

extension ValidAlphabet on String {
  bool isValidAlphabet() {
    return RegExp(r'^[a-zA-Z]+$').hasMatch(this);
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
