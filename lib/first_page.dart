import 'package:flutter/material.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(child: Container()),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.attach_money),
      ),
    );
  }
}

class One extends StatelessWidget {
  const One({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
