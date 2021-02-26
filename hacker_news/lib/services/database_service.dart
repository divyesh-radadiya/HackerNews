import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseService {
  dynamic setDatabase() async {
    // ignore: always_specify_types
    final directory = await getApplicationDocumentsDirectory();
    final String path = join(directory.path, 'db_hacker_news_sqflite');
    final Database database =
        await openDatabase(path, version: 1, onCreate: _onCreateDatabase);
    return database;
  }

  Future<void> _onCreateDatabase(Database database, int version) async {
    await database.execute(
        'Create table news(id INTEGER PRIMARY KEY,title TEXT, by TEXT,time INTEGER )');
  }
}
