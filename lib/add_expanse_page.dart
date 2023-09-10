import 'package:expanse_app_with_sqflite_bloc/utils/app_constants.dart';
import 'package:expanse_app_with_sqflite_bloc/utils/my_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'login_page.dart';

class AddExpansePage extends StatefulWidget {
  const AddExpansePage({super.key});

  @override
  State<AddExpansePage> createState() => _AddExpansePageState();
}

class _AddExpansePageState extends State<AddExpansePage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add Expanse here'),
          automaticallyImplyLeading: true,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: SingleChildScrollView(
              reverse: true,
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: SizedBox(
                height: MediaQuery.sizeOf(context).height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Add Expanse Here',
                      style: TextStyle(
                          fontSize: MediaQuery.sizeOf(context).height * .03),
                    ),
                    hSpacer(),

                    /// for expanse title ///
                    TextFormField(
                      controller: titleController,
                      decoration:
                          const InputDecoration(hintText: 'Enter Title'),
                      validator: (value) {
                        if (value == null || value.isValidAlphabet() == false) {
                          return 'Invalid Title';
                        } else {
                          return null;
                        }
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    hSpacer(),

                    /// for expanse detail ///
                    TextFormField(
                      controller: descController,
                      decoration:
                          const InputDecoration(hintText: 'Enter Detail'),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.isValidDetail() == false) {
                          return 'Please Enter Valid Detail. Don\'t use special characters.';
                        } else {
                          return null;
                        }
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    hSpacer(),

                    /// for expanse amount
                    TextFormField(
                      controller: amountController,
                      decoration:
                          const InputDecoration(hintText: 'Enter amount'),
                      validator: (value) {
                        if (value == null || value.isValidAmount() == false) {
                          return 'Please enter valid amount';
                        } else {
                          return null;
                        }
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.number,
                    ),
                    hSpacer(mHeight: 50),

                    /// button for entries
                    ElevatedButton(
                      onPressed: () {
                        showModalBottomSheet(
                            constraints: BoxConstraints(
                                maxHeight:
                                    MediaQuery.sizeOf(context).height * .45),
                            backgroundColor: CupertinoColors.activeOrange,
                            // shape: const CircleBorder(
                            //     side: BorderSide(
                            //         color: CupertinoColors.black, width: 3)),
                            context: context,
                            builder: (context) {
                              return Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20),
                                child: GridView.builder(
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 3),
                                    itemCount: AppConstants.categories.length,
                                    itemBuilder: (context, index) {
                                      Map<String, dynamic> inSideCategoryMap =
                                          AppConstants.categories[index];
                                      return Column(
                                        children: [
                                          Image.asset(
                                            inSideCategoryMap['imagepath'],
                                            width: 50,
                                            height: 50,
                                          ),
                                          hSpacer(mHeight: 4),
                                          Text(inSideCategoryMap['name']),
                                        ],
                                      );
                                    }),
                              );
                            });
                      },
                      child: const Text('Submit Expanse'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
