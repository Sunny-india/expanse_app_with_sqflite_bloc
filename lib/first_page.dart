import 'package:expanse_app_with_sqflite_bloc/database_helper.dart';
import 'package:flutter/material.dart';

import 'models/users_model.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  SQLHelper databaseHelper = SQLHelper.singleInstance;
  List<Users> allUsers = [];

  Future<void> getAllUsersFromDatabase() async {
    allUsers = await databaseHelper.fetchUsers();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllUsersFromDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Of Users'),
      ),
      body: SafeArea(
        child: ListView.builder(
            itemCount: allUsers.length,
            itemBuilder: (context, index) {
              Users user = allUsers[index];
              return Card(
                child: ListTile(
                  leading: Text(user.user_id.toString()),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(user.name.toString()),
                      const SizedBox(height: 15),
                      Text(user.email.toString()),
                      const SizedBox(height: 5),
                      Text(user.phone.toString()),
                      const SizedBox(height: 5),
                      Text(user.city.toString()),
                    ],
                  ),
                ),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.attach_money),
      ),
    );
  }
}
