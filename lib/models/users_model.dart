import 'package:expanse_app_with_sqflite_bloc/database_helper.dart';

class Users {
  int? user_id;
  String name, phone, email, password, city;
  Users(
      {this.user_id,
      required this.name,
      required this.phone,
      required this.email,
      required this.password,
      required this.city});

  factory Users.fromUserTable(Map<String, dynamic> userTable) {
    return Users(
        user_id: userTable[SQLHelper.USER_ID],
        name: userTable[SQLHelper.USER_NAME],
        phone: userTable[SQLHelper.USER_PHONE],
        email: userTable[SQLHelper.USER_EMAIL],
        password: userTable[SQLHelper.USER_PASSWORD],
        city: userTable[SQLHelper.USER_CITY]);
  }

  /// for adding or sending data from the app to its database.
  /// database takes the parameters in json or map format. so before sending
  /// the data, we convert it to that format.
  /// break-down: First it it changing the data to a map, that what this method
  /// is returning, and secondly, this method would be used to send that map
  ///  to the database.

  Map<String, dynamic> toUserTable() {
    return {
      SQLHelper.USER_ID: user_id,
      SQLHelper.USER_NAME: name,
      SQLHelper.USER_PHONE: phone,
      SQLHelper.USER_EMAIL: email,
      SQLHelper.USER_PASSWORD: password,
      SQLHelper.USER_CITY: city
    };
  }
}
