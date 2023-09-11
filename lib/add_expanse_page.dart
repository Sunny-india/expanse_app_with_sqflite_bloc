import 'package:expanse_app_with_sqflite_bloc/blocs/expanse_event.dart';
import 'package:expanse_app_with_sqflite_bloc/my_widgets.dart';
import 'package:expanse_app_with_sqflite_bloc/utils/app_constants.dart';
import 'package:expanse_app_with_sqflite_bloc/utils/my_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'blocs/expanase_bloc.dart';
import 'login_page.dart';
import 'models/expanse_model.dart';

class AddExpansePage extends StatefulWidget {
  const AddExpansePage({super.key});

  @override
  State<AddExpansePage> createState() => _AddExpansePageState();
}

class _AddExpansePageState extends State<AddExpansePage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  int selectedCategory = -1;
  List<String> expanseNatureList = ['Debit', 'Credit'];
  String selectedItem = 'Debit';
  //
  void showBottomSheet() {
    showModalBottomSheet(
        constraints:
            BoxConstraints(maxHeight: MediaQuery.sizeOf(context).height * .45),
        backgroundColor: CupertinoColors.activeOrange,
        shape: const BeveledRectangleBorder(),
        context: context,
        builder: (context) {
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemCount: AppConstants.categories.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> inSideCategoryMap =
                      AppConstants.categories[index];
                  return InkWell(
                    onTap: () {
                      setState(() {
                        selectedCategory = index;
                      });
                      print(selectedCategory);
                      Navigator.pop(context);
                    },
                    child: Column(
                      children: [
                        Image.asset(
                          inSideCategoryMap['imagepath'],
                          width: 50,
                          height: 50,
                        ),
                        hSpacer(mHeight: 4),
                        Text(inSideCategoryMap['name']),
                      ],
                    ),
                  );
                }),
          );
        });
  }

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

                    Row(
                      children: [
                        /// button for categories
                        Expanded(
                          flex: 2,
                          child: CustomButton(
                              titleWidget: selectedCategory < 0
                                  ? const Text('Categories')
                                  : Row(
                                      children: [
                                        Text(AppConstants
                                                .categories[selectedCategory]
                                            ['name']),
                                        wSpacer(mWidth: 4),
                                        Expanded(
                                          child: Image.asset(
                                            AppConstants.categories[
                                                selectedCategory]['imagepath'],
                                            width: 30,
                                            height: 30,
                                          ),
                                        ),
                                      ],
                                    ),
                              functionInsideButton: showBottomSheet),
                        ),
                        wSpacer(),
                        Expanded(
                          flex: 1,
                          child: DropdownButton(
                              items: expanseNatureList
                                  .map((e) => DropdownMenuItem(
                                        value: e,
                                        child: Text(e),
                                      ))
                                  .toList(),
                              onChanged: (String? newValue) {
                                selectedItem = newValue!;
                                setState(() {});
                              },
                              value: selectedItem),
                        ),
                      ],
                    ),
                    hSpacer(mHeight: 25),

                    /// button for entries
                    Row(
                      children: [
                        Expanded(
                          child: CustomButton(
                            functionInsideButton: () async {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              int? userId = prefs.getInt('uid');
                              context.read<ExpanseBloc>().add(AddExpanseEvent(
                                      expanse: Expanse(
                                    user_id: userId ??
                                        AppConstants
                                            .categories[selectedCategory]['id'],
                                    expanse_title:
                                        titleController.text.toString(),
                                    expanse_desc:
                                        descController.text.toString(),
                                    expanse_amount: double.parse(
                                        amountController.text.toString()),
                                    expanse_type:
                                        selectedItem == 'Debit' ? 0 : 1,
                                    expanse_cat_id: AppConstants
                                        .categories[selectedCategory]['id'],
                                    expanse_time: '',
                                    expanse_total: 0,
                                  )));
                            },
                            titleWidget: const Text('Enter'),
                          ),
                        ),
                      ],
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
