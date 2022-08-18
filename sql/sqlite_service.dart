import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'employee.dart';

class SqliteService {
  final String databseName = "employee.db";

//Creating Database and Table
  Future<Database> initDB() async {
    final databasePath = await getDatabasesPath();
    return openDatabase(join(databasePath, databseName),
        onCreate: ((db, version) async {
      await db.execute(
          "CREATE TABLE EmployeeDetails(id INTEGER PRIMARY KEY AUTOINCREMENT,AGE INTEGER NOT NULL, FIRSTNAME TEXT NOT NULL, SURNAME TEXT NOT NULL ");
    }), version: 1);
  }

//Insert Data into Database
  // Future<int> createData(Employee employee) async {
  //   int result = 0;
  //   final Database db = await initDB();

  //   final id = await db.insert('Employee', employee.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  // }

  
}
