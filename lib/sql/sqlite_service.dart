// ignore_for_file: non_constant_identifier_names, unused_field

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io' as io;
import 'package:path_provider/path_provider.dart';
import 'employee.dart';

class SqliteService {
  static Database? _database;
  String ID = 'id';
  String AGE = 'age';
  String FIRSTNAME = 'firstname';
  String SURNAME = 'surname';
  String TABLENAME = 'Employee';
  String DATABASENAME = 'employee.db';

  Future<Database?> get db async {
    //check if datbase is null
    if (_database != null) {
      return _database;
    }
    //if databse !=null
    _database = await initDb();
    return _database;
  }

//initialize directory
  initDb() async {
    io.Directory directory =
        await getApplicationDocumentsDirectory(); //get local directory
    String path = join(directory.path, DATABASENAME);
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  //create table function
  _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $TABLENAME ($ID INTEGER PRIMARY KEY, $AGE INTEGER, $FIRSTNAME TEXT, $SURNAME TEXT");
  }

  Future<Employee> save(Employee employee) async {
    var dbClient = await db;
    employee.id = await dbClient!.insert(TABLENAME, employee.toMap());
    return employee;

    //another way to write the save method
    // await dbClient.transaction((txn) async {
    //   var query = "INSERT INTO $TABLENAME ($FIRSTNAME) VALUES ('" +
    //       employee.firstname +
    //       "'))";
    //   return await txn.rawInsert(query);
    // });
  }

  Future<List<Employee>> getEmployees() async {
    var dbClient = await db;
    List<Map> maps = await dbClient!
        .query(TABLENAME, columns: [ID, AGE, FIRSTNAME, SURNAME]);
    List<Employee> employees = [];
    if (maps.isNotEmpty) {
      for (int i = 0; i < maps.length; i++) {
        employees.add(Employee.fromMap(maps[i]));
      }
    }
    return employees;
  }

  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient!.delete(TABLENAME, where: '$ID=?', whereArgs: [id]);
  }

  Future<int> update(Employee employee) async {
    var dbClient = await db;
    return await dbClient!.update(TABLENAME, employee.toMap(),
        where: '$ID=?', whereArgs: [employee.id]);
  }

  Future close() async {
    var dbClient = await db;
    dbClient!.close();
  }
}
