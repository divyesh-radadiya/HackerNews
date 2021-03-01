import 'package:moor_flutter/moor_flutter.dart';

part 'news_table.g.dart';

class NewsTable extends Table {
  IntColumn get id => integer()();
  TextColumn get title => text()();
  TextColumn get by => text()();
  IntColumn get time => integer()();

  @override
  // ignore: always_specify_types
  Set<Column> get primaryKey => {id};
}

@UseMoor(tables: [NewsTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super(FlutterQueryExecutor.inDatabaseFolder(
            path: 'db.sqflie', logStatements: true));
  @override
  int get schemaVersion => 1;

  Future<List<NewsTableData>> getAllNews() => select(newsTable).get();
  Future<int> insertNews(Insertable<NewsTableData> news, {String by}) =>
      into(newsTable).insert(news);
  Future<NewsTableData> getNewsById(int id) =>
      (select(newsTable)..where(($NewsTableTable n) => (n.id.equals(id))))
          .getSingle();
}
