import 'package:expanse_app_with_sqflite_bloc/add_expanse_page.dart';
import 'package:expanse_app_with_sqflite_bloc/blocs/users/uers_state.dart';
import 'package:expanse_app_with_sqflite_bloc/blocs/users/users_bloc.dart';
import 'package:expanse_app_with_sqflite_bloc/blocs/users/users_event.dart';
import 'package:expanse_app_with_sqflite_bloc/database_helper.dart';
import 'package:expanse_app_with_sqflite_bloc/my_widgets.dart';
import 'package:expanse_app_with_sqflite_bloc/sign_up_page.dart';
import 'package:expanse_app_with_sqflite_bloc/utils/my_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Welcome',
          style: mTextStyle25(
            mWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          reverse: true,
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Form(
            key: formKey,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              height: MediaQuery.sizeOf(context).height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  hSpacer(),
                  Text(
                    'Please Login',
                    style: mTextStyle25(
                        mColor: CupertinoColors.systemRed,
                        mWeight: FontWeight.w900),
                  ),
                  hSpacer(),

                  /// for phone saving ///
                  // TextFormField(
                  //   decoration:
                  //       const InputDecoration(hintText: 'Enter Phone number'),
                  //   controller: phoneController,
                  //   validator: (value) {
                  //     if (value!.isNotEmpty) {
                  //       if (value.isValidNumber() == true) {
                  //         return null;
                  //       } else {
                  //         return 'Please Enter only 10-digit number';
                  //       }
                  //     } else {
                  //       return 'Please enter your phone';
                  //     }
                  //   },
                  //   autovalidateMode: AutovalidateMode.onUserInteraction,
                  // ),
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

                  hSpacer(mHeight: 30),

                  /// for checking if the user exists in database or not
                  /// further with the value got from the state
                  /// how to route the user to the next page?
                  BlocListener<UserBloc, UsersState>(
                    listener: (context, state) {
                      if (state is UserLoadedState) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return const AddExpansePage();
                          }),
                        );
                      }
                      if (state is UserErrorState) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              state.errorMessage.toString(),
                            ),
                          ),
                        );
                      }
                    },
                    child: CustomButton(
                      buttonWidth: MediaQuery.sizeOf(context).width * .6,
                      buttonHeight: 40,
                      titleWidget: const Text('Login'),
                      functionInsideButton: () async {
                        if (formKey.currentState!.validate()) {
                          context.read<UserBloc>().add(AuthenticateUserEvent(
                              email: emailController.text.toString(),
                              password: passwordController.text.toString()));
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
