import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import 'models/expanse_model.dart';
import 'models/users_model.dart';

class SQLHelper {
  SQLHelper._();
  static final SQLHelper singleInstance = SQLHelper._();
  Database? _database;
  static String USER_TABLE = 'users';
  static String USER_ID = 'user_id';
  static String USER_NAME = 'name';
  static String USER_PHONE = 'phone';
  static String USER_EMAIL = 'email';
  //
  static String USER_PASSWORD = 'password';
  static String USER_CITY = 'city';

  static String EXPANSE_TABLE = 'expanses';
  static String EXPANSE_ID = 'expanse_id';
  static String EXPANSE_TITLE = 'expanse_title';
  static String EXPANSE_DESC = 'expanse_desc';

  static String EXPANSE_AMOUNT = 'expanse_amount';
  static String EXPANSE_TOTAL = 'expanse_total';
  // 0 for debit, 1 for credit type. Will accept boolean in it
  static String EXPANSE_TYPE = 'expanse_type';
  static String EXPANSE_CAT_ID = 'expanse_cat_id';
  static String EXPANSE_TIME = 'expanse_time';

  Future<Database> getDB() async {
    if (_database != null) {
      return _database!;
    } else {
      print('database created for the first time');
      return _database = await initDB();
    }
  }

  Future<Database> initDB() async {
    String path = join(await getDatabasesPath(), 'expense.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  ///===basically it creates database schema===///
  Future _onCreate(Database db, version) async {
    //
    await db.execute('''
     CREATE TABLE $USER_TABLE (
     $USER_ID INTEGER PRIMARY KEY AUTOINCREMENT,
     $USER_NAME TEXT,
     $USER_PHONE TEXT,
     $USER_EMAIL TEXT,
     $USER_PASSWORD TEXT,
    $USER_CITY TEXT
    )

     ''');
    print('user table created here');
    //
    await db.execute('''
    CREATE TABLE $EXPANSE_TABLE (
    $EXPANSE_ID INTEGER PRIMARY KEY AUTOINCREMENT, 
    $USER_ID INTEGER,
    $EXPANSE_TITLE TEXT,
    $EXPANSE_DESC TEXT,
    $EXPANSE_AMOUNT REAL,
    $EXPANSE_TOTAL REAL,
    $EXPANSE_TYPE INTEGER,
    $EXPANSE_TIME TEXT,
    $EXPANSE_CAT_ID INTEGER    
    )
    ''');

    print('EXPANSE table created here');
  }

  /// for adding users in the database
  Future addUser(Users user) async {
    Database db = await getDB();
    bool checkExistence = await userAlreadyExistedOrNot(
        email: user.email.toString(), phone: user.phone.toString());
    if (checkExistence == false) {
      int added = await db.insert(USER_TABLE, user.toUserTable());
      if (added > 0) {
        print(await db.query('users'));
      } else {
        print('Not Added');
      }
    } else {
      print('Data Already existed');
    }
  }

  Future<bool> userAlreadyExistedOrNot({String? email, String? phone}) async {
    Database db = await getDB();
    List<Map<String, dynamic>> dataCheck = await db.query(USER_TABLE,
        where: '$USER_EMAIL =? OR $USER_PHONE = ?',
        whereArgs: ['$email, $phone']);
    return dataCheck.isNotEmpty;
  }

  /// for sign up method and have their id set through SharedPreferences
  Future<bool> authenticateUser(
      {required String email, required String password}) async {
    Database db = await getDB();

    List<Map<String, dynamic>> emailPassword = await db.query(USER_TABLE,
        where: '$USER_EMAIL = ? and $USER_PASSWORD',
        whereArgs: ['$email, $password']);

    // set uid by sharedPrefs here
    if (emailPassword.isNotEmpty) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setInt('uid', int.parse(emailPassword[0][USER_ID]));
    }
    //  done
    return emailPassword.isNotEmpty;
  }

  Future<List<Users>> fetchUsers() async {
    Database db = await getDB();
    List<Map<String, dynamic>> listOfMaps = await db.query(USER_TABLE);
    return List.generate(listOfMaps.length, (index) {
      Map<String, dynamic> eachUser = listOfMaps[index];

      return Users.fromUserTable(eachUser);
    });
  }

  ///===Expanse Table Operations are below===///

  Future<bool> addExpanse(Expanse newExpanse) async {
    Database db = await getDB();
    int added = await db.insert(EXPANSE_TABLE, newExpanse.toMap());

    print(await db.query(EXPANSE_TABLE));
    return added > 0;
  }

  // Future<List<Expanse>> fetchUserBasedAllExpanses(int uid) async {
  //   Database db = await getDB();
  //
  //   // get uid by SharedPreference method here, for its use further
  //   // in Bloc. set task has been done in users function.
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   int? uid = prefs.getInt('uid');
  //   //
  //   List<Map<String, dynamic>> listOfMaps =
  //       await db.query(EXPANSE_TABLE, where: '$USER_ID =?', whereArgs: [uid]);
  //   return List.generate(listOfMaps.length, (index) {
  //     Map<String, dynamic> singleMap = listOfMaps[index];
  //     return Expanse.fromMap(singleMap);
  //   });
  // }

  // with the support of SharedPreferences
  Future<List<Expanse>> fetchAllExpanses() async {
    Database db = await getDB();
    // get uid by SharedPreference method here, for its use further
    // in Bloc. set task has been done in users function.
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int uid = prefs.getInt('uid') as int;
    //
    List<Map<String, dynamic>> listOfMaps = await db
        .query(EXPANSE_TABLE, where: '$USER_ID = ?', whereArgs: ["$uid"]);
    return List.generate(listOfMaps.length, (index) {
      Map<String, dynamic> eachMap = listOfMaps[index];
      return Expanse.fromMap(eachMap);
    });
  }

  // Without the support of SharedPreferences//
  // This method also require to change your Event, and State classes accordingly

  Future<List<Expanse>> fetchAllExpansesOfUser(int uid) async {
    Database db = await getDB();
    List<Map<String, dynamic>> userBasedExp = await db
        .query(EXPANSE_TABLE, where: '$USER_ID = ?', whereArgs: ["$uid"]);
    return List.generate(userBasedExp.length, (index) {
      Map<String, dynamic> eachUser = userBasedExp[index];
      return Expanse.fromMap(eachUser);
    });
  }
}
