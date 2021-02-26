import 'package:flutter/material.dart';
import 'package:hacker_news/services/network_service.dart';
import 'package:hacker_news/view_model/news_model.dart';
import 'package:hacker_news/services/news_table_service.dart';

class NewsListModel extends ChangeNotifier {
  List<NewsModel> newsList = List<NewsModel>(0);
  List<int> allTopIds = List<int>(0);
  List<Map<String, dynamic>> allData = List<Map<String, dynamic>>(0);
  int index = 0;

  Future<void> getFromTable() async {
    allData = await NewsTableService().readData();
  }

  Future<void> getTopIds() async {
    final NetworkService networkService = NetworkService(
        'https://hacker-news.firebaseio.com/v0/topstories.json?print=pretty');

    final dynamic allIds = await networkService.getData();
    for (final dynamic x in allIds) {
      allTopIds.add(x as int);
    }
    notifyListeners();
  }

  Future<NewsModel> getNewsById(int id) async {
    final NetworkService networkService = NetworkService(
        'https://hacker-news.firebaseio.com/v0/item/$id.json?print=pretty');

    final dynamic news = await networkService.getData();
    return NewsModel.fromJson(news as Map<String, dynamic>);
  }

  Future<void> getNextNews() async {
    final List<NewsModel> newNewsList = List<NewsModel>(0);
    int j = index;
    for (int i = 0; i < 10; i++, index++, j++) {
      if (allData.isEmpty) await getFromTable();
      if (index < allData.length) {
        newNewsList.add(NewsModel.fromJson(allData[index]));
      } else {
        if (allTopIds.isEmpty) await getTopIds();
        if (index < allTopIds.length) {
          final NewsModel newNews = await getNewsById(allTopIds[index]);
          newNewsList.add(newNews);
        }
      }
    }
    newsList.addAll(newNewsList);
    notifyListeners();

    for (int i = await NewsTableService().lengthOfData(); i < j; i++) {
      await NewsTableService().insertData(newsList[i].toJson());
    }
  }
}
