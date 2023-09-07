import 'package:flutter/material.dart';

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
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TextFormField(),
          ],
        ),
      ),
    );
  }
}
