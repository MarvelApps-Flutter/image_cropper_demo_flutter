import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import '../models/personModel.dart';

class PersonDatabaseHelper {
  static PersonDatabaseHelper?
      _personDatabaseHelper; //Singleton object of the class

  static Database? _database;

  String personTable = 'personsTable';
  String personFullName = 'fullName';
  String personEmail = 'email';
  String personPhoneNumber = 'phoneNumber';
  String personPassword = 'password';
  String personBirthDate = 'birthDate';
  String personGender = 'gender';

  PersonDatabaseHelper._createInstance();
  factory PersonDatabaseHelper() {
    //initializing the object
    _personDatabaseHelper ??= PersonDatabaseHelper._createInstance();
    return _personDatabaseHelper!;
  }

  // Getter for our database
  Future<Database?> get database async {
    _database ??= await initializeDatabase();
    return _database;
  }

  // Function to initialize the database
  Future<Database> initializeDatabase() async {
    // Getting directory path for both Android and Ios

    Directory directory = await getApplicationDocumentsDirectory();

    String path = '${directory.path}person.db';

    // Open or create database at a given path.
    var personDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    print("Database Created");

    // _createDb(personDatabase, 1);
    // print("Table created");

    return personDatabase;
  }

  // Function for creating a Database,
  void _createDb(Database db, int newVersion) async {
    if (_database == null) {
      await db.execute(
          'CREATE TABLE personsTable ($personFullName TEXT, $personEmail TEXT PRIMARY KEY, $personPhoneNumber TEXT UNIQUE, $personPassword VARCHAR, $personBirthDate TEXT, $personGender TEXT)');
    }
  }

  // Functions for CRUD operations

  //Fetch operation
  Future<List<Map<String, dynamic>>> getPerson(String email) async {
    Database? db = await database;

    var result = await db!.rawQuery(
        'SELECT * FROM $personTable WHERE $personEmail = \'$email\' ');
    return result;
  }

  // Insert Operation
  Future<int> insertPerson(Person person) async {
    Database? db = await database;

    var result = await db!.insert(personTable, person.toMap());
    print("Person details inserted in the $personTable.");
    print("$personTable contains $result records.");
    return result;
  }

  // Update Operation
  Future<int> updatePerson(Person person) async {
    Database? db = await database;

    var result = await db!.update(personTable, person.toMap(),
        where: '$personEmail = ?', whereArgs: [person.email]);
    return result;
  }

  // Delete Operation
  Future<int> deletePerson(String email) async {
    Database? db = await database;

    var result = await db!
        .rawDelete('DELETE FROM $personTable WHERE $personEmail = $email');
    return result;
  }
}
