import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:login_register_first/Models/User.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ConnectDatabase {
  Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await createDb();
    return _db;
  }

  createDb() async {
    WidgetsFlutterBinding.ensureInitialized();
    // Open the database and store the reference.
    final Future<Database> database = openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      join(await getDatabasesPath(), 'user_database.db'),
      onCreate: (db, version) {
        // Run the CREATE TABLE statement on the database.
        return db.execute(
          "CREATE TABLE users(id INTEGER PRIMARY KEY, fullname TEXT, email TEXT, username TEXT, password TEXT)",
        );
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );
    return database;
  }

  Future<void> registerUser(User user) async {
    // Get a reference to the database.
    final Database database = await db;

    // Insert the Dog into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same dog is inserted twice.
    //
    // In this case, replace any previous data.
    await database.insert(
      'users',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<User> loginUser(String user, String password) async {
    // Get a reference to the database.
    final Database database = await db;

    final List<Map<String, dynamic>> maps = await database.rawQuery(
        "SELECT * FROM users WHERE username = '$user' and password = '$password'");
    print(maps.length);
    // Query the table for all The Dogs.
    if (maps.length > 0) {
      User abc = User.fromMap(maps.first);
      print("Password" + abc.password);
      return abc;
    }
    return null;
  }

  Future<int> getCount() async {
    final Database database = await db;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps =
        await database.rawQuery("SELECT COUNT(*) FROM users");
    return maps.length;
  }

  Future<List<User>> dogs() async {
    // Get a reference to the database.
    final Database database = await db;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await database.query('users');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return User.fromMap(maps[i]);
    });
  }
}
