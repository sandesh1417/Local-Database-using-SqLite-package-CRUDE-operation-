import 'dart:developer';
import 'dart:io';
//import 'dart:js_util';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'dart:async';

class Databasehelper {
  static final _databasename = " person.db";
  static final _databaseversion = 1;

  static final table = "my_table";

  static final columnID = 'id';
  static final columnname = "name";
  static final columnage = 'age';

  Databasehelper._privateConstructor();
  static final Databasehelper instance = Databasehelper._privateConstructor();

  static Database? _database;

  // Future<Database> get _getdatabase async {
  //   if (_database != null)  return await _database;

  //   _database = await _initDatabase();
  //   return _database;
  // }

  Future<Database> get database async {
    // return _database ?? await _initDatabase();
    if (_database != null) {
      return _database!;
    } else {
      return await _initDatabase();
    }
  }

  _initDatabase() async {
    Directory documentdirectory = await getApplicationDocumentsDirectory();
    String path = join(documentdirectory.path, _databasename);
    return await openDatabase(path,
        version: _databaseversion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $table (
        $columnID INTEGER PRIMARY KEY,
        $columnname Text NOT NULL,
        $columnage INTEGER NOT NULL

                          )
                     ''');
  }

  Future<int?> insert(Map<String, dynamic> row) async {
    log("Insert in db called");
    Database db = await instance.database;
    return db.insert(table, row);
  }

  Future<List<Map<String, dynamic>>> queryall() async {
    Database db = await instance.database;
    return await db.query(table);
  }

  Future<List<Map<String, dynamic>>> queryspecify(int age) async {
    Database db = await instance.database;
    var res = await db.query(table, where: "age>?", whereArgs: [age]);
    return res;

    //var res = await db.rawQuery('SELECT *FROM my_table WHERE age>?,', [age]);
  }

  Future<int> deletedata(int id) async {
    Database db = await instance.database;
    var res = await db.delete(table, where: "id=?", whereArgs: [id]);
    return res;
  }

  Future<int> update(int id) async {
    Database db = await instance.database;
    var res = await db.update(table, {"name": "Sandesh Shrestha", "age": 50},
        where: "id=?", whereArgs: [id]);
    return res;
  }
}
