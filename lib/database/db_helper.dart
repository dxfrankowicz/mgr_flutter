import 'dart:async';
import 'dart:math';
import 'package:mgr_flutter/database/person_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';


class DBHelper{
  Database _database;
  String dbPath = "myDb.sqlite";
  static String tableName= "persons";

  DBHelper(this.dbPath);

  Future initDatabase() async {
    var documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, dbPath);

    _database = await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("create table $tableName (id INTEGER PRIMARY KEY, "
          "name TEXT, surname TEXT, age INTEGER);");
      for (int i = 1; i <= 100; i++) {
        db.insert(tableName, Person(i, "Name$i", "Surname$i", Random().nextInt(100)).toJson());
      }
    });
  }

  Future<int> insert(Person person) async {
    final db = _database;
    var res = await db.insert(tableName, person.toJson());
    return res;
  }

  Future<List<Person>> queryAllRows() async {
    final db = _database;
    List<Map<String, dynamic>> res = await db.query(tableName);
    return res.map((e) {
      return Person.fromJson(e);
    }).toList();
  }

  Future<int> delete(int id) async {
    final db = _database;
    return await db.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }

  Future<void> dropTable() async {
    final db = _database;
    return await db.rawQuery("drop table $tableName");
  }
}