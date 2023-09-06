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

class Expanse {
  int? expanse_id;
  int user_id;
  String expanse_title;
  String expanse_desc;
  double expanse_amount;
  double expanse_total;
  int expanse_type;
  int expanse_cat_id;
  String expanse_time;
  Expanse(
      {this.expanse_id,
      required this.user_id,
      required this.expanse_title,
      required this.expanse_desc,
      required this.expanse_amount,
      required this.expanse_total,
      required this.expanse_type,
      required this.expanse_cat_id,
      required this.expanse_time});

  factory Expanse.fromMap(Map<String, dynamic> map) {
    return Expanse(
        expanse_id: map[SQLHelper.EXPANSE_ID],
        user_id: map[SQLHelper.USER_ID],
        expanse_title: map[SQLHelper.EXPANSE_TITLE],
        expanse_desc: map[SQLHelper.EXPANSE_DESC],
        expanse_amount: map[SQLHelper.EXPANSE_AMOUNT],
        expanse_total: map[SQLHelper.EXPANSE_TOTAL],
        expanse_type: map[SQLHelper.EXPANSE_TYPE],
        expanse_cat_id: map[SQLHelper.EXPANSE_CAT_ID],
        expanse_time: map[SQLHelper.EXPANSE_TIME]);
  }

  Map<String, dynamic> toMap() {
    return {
      SQLHelper.EXPANSE_ID: expanse_id,
      SQLHelper.USER_ID: user_id,
      SQLHelper.EXPANSE_TITLE: expanse_title,
      SQLHelper.EXPANSE_DESC: expanse_desc,
      SQLHelper.EXPANSE_AMOUNT: expanse_amount,
      SQLHelper.EXPANSE_TOTAL: expanse_total,
      SQLHelper.EXPANSE_TYPE: expanse_type,
      SQLHelper.EXPANSE_CAT_ID: expanse_cat_id,
      SQLHelper.EXPANSE_TIME: expanse_time
    };
  }
}
