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

  Future<int> lengthOfData() async {
    final Database con = await database;
    final List<Map<String, dynamic>> result =
        await con.rawQuery('SELECT COUNT(*) FROM news');
    return Sqflite.firstIntValue(result);
  }
}
