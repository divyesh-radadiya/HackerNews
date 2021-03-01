import 'package:hacker_news/services/news_table.dart';
import 'package:hacker_news/services/network_service.dart';
import 'package:hacker_news/view_model/news_model.dart';

class AddNewsToScreenService {
  final AppDatabase _appDatabase = AppDatabase();
  final NetworkService _networkService = NetworkService();
  List<NewsTableData> allDataFromTable = <NewsTableData>[];

  Future<List<NewsModel>> getAllNewsFromTable(int from) async {
    final List<NewsModel> newNewsList = <NewsModel>[];
    if (allDataFromTable.isEmpty) {
      allDataFromTable = await _appDatabase.getAllNews();
    }
    for (int i = from; i < 10 + from && allDataFromTable.length > i; i++) {
      newNewsList.add(NewsModel.fromJson(allDataFromTable[i].toJson()));
    }
    return newNewsList;
  }

  Future<List<int>> getTopIds() async {
    return _networkService.getTopIds();
  }

  Future<NewsModel> getNewsFromTable(int id) async {
    final NewsTableData data = await _appDatabase.getNewsById(id);
    return (data != null) ? NewsModel.fromJson(data.toJson()) : null;
  }

  Future<List<NewsModel>> getNews(int form, List<int> allTopIds) async {
    final List<NewsModel> newNewsList = <NewsModel>[];

    for (int i = form; i < 10 + form && i < allTopIds.length; i++) {
      final NewsModel newNews = await getNewsFromTable(allTopIds[i]);
      if (newNews != null) {
        newNewsList.add(newNews);
      } else {
        final NewsModel newNews =
            await _networkService.getNewsById(allTopIds[i]);
        if (newNews != null) {
          newNewsList.add(newNews);
          await _appDatabase
              .insertNews(NewsTableData.fromJson(newNews.toJson()));
        }
      }
    }
    return newNewsList;
  }
}
