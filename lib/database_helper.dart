import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import 'models/users_model.dart';

class SQLHelper {
  SQLHelper._();
  static final SQLHelper singleInstance = SQLHelper._();
  Database? _database;
  String EXPENSE_DATABASE = 'expense.db';
  // String USER_TABLE = 'users';
  // String USER_ID = 'id';
  // String USER_NAME = 'name';
  // String USER_PHONE = 'phone';
  // String USER_EMAIL = 'email';
  //
  // String USER_PASSWORD = 'password';
  // String USER_CITY = 'city';

  // String EXPANSE_TABLE = 'expanses';
  // String EXPANSE_ID = 'expanse_id';
  // String EXPANSE_AMOUNT = 'amount';
  // String EXPANSE_TIME = 'time_of_expanse';
  // String EXPANSE_TOTAL = 'total_amount_of_expanse';

  Future getDB() async {
    if (_database != null) {
      return _database;
    } else {
      print('database created for the first time');
      return _database = await initDB();
    }
  }

  Future<Database> initDB() async {
    String path = join(await getDatabasesPath(), 'expense.db');
    return openDatabase(path, version: 1, onCreate: _onCreate);
  }

  ///===basically it creates database schema===///
  Future _onCreate(Database db, version) async {
    //
    await db.execute('''
     CREATE TABLE users (
     id INTEGER PRIMARY KEY AUTOINCREMENT,
     name TEXT,
    phone TEXT,
    email TEXT,
    password TEXT,
    city TEXT )

     ''');
    print('user table created here');
    //
    // await db.execute('''
    // CREATE TABLE $EXPANSE_TABLE (
    // $EXPANSE_ID INTEGER PRIMARY KEY,
    // $EXPANSE_AMOUNT REAL NOT NULL,
    // $EXPANSE_TIME TEXT NOT NULL,
    // $EXPANSE_TOTAL REAL,
    // $USER_ID INTEGER,
    // FOREIGN KEY ($USER_ID) REFERENCES $USER_TABLE($USER_ID)
    // )
    // ''');
    // print('EXPANSE table created here');
  }

  Future addUser(Users user) async {
    Database db = await getDB();
    int added = await db.insert('users', user.toUserTable());
    if (added > 0) {
      print(await db.query('users'));

      SharedPreferences prefs = await SharedPreferences.getInstance();

      await prefs.setBool('isLoggedIn', true);
    } else {
      print('Not Added');
    }
  }
}
