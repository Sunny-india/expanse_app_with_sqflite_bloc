class Users {
  int? id;
  String name, phone, email, password, city;
  Users(
      {this.id,
      required this.name,
      required this.phone,
      required this.email,
      required this.password,
      required this.city});

  factory Users.fromUserTable(Map<String, dynamic> userTable) {
    return Users(
        id: userTable['id'],
        name: userTable['name'],
        phone: userTable['phone'],
        email: userTable['email'],
        password: userTable['password'],
        city: userTable['city']);
  }

  /// for adding or sending data from the app to its database.
  /// database takes the parameters in json or map format. so before sending
  /// the data, we convert it to that format.
  /// break-down: First it it changing the data to a map, that what this method
  /// is returning, and secondly, this method would be used to send that map
  ///  to the database.

  Map<String, dynamic> toUserTable() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'email': email,
      'password': password,
      'city': city
    };
  }
}
