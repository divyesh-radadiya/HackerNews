import 'package:sqflite/sqflite.dart';

import 'database_service.dart';

class NewsTableService {
  NewsTableService() {
    _databaseService = DatabaseService();
  }
  DatabaseService _databaseService;

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    // ignore: join_return_with_assignment
    _database = await _databaseService.setDatabase() as Database;
    return _database;
  }

  Future<int> insertData(Map<String, dynamic> data) async {
    final Database con = await database;
    return con.insert('news', data,
        conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<List<Map<String, dynamic>>> readData() async {
    final Database con = await database;
    return con.query('news');
  }

  Future<List<Map<String, dynamic>>> readDataById(int id) async {
    final Database con = await database;
    return con.query('news', where: 'id=?', whereArgs: <dynamic>[id]);
  }
}
