import 'package:flutter/material.dart';
import 'package:hacker_news/services/network_service.dart';
import 'package:hacker_news/view_model/news_model.dart';
import 'package:hacker_news/services/news_table_service.dart';

class NewsListModel extends ChangeNotifier {
  List<NewsModel> newsList = <NewsModel>[];
  List<int> allTopIds = <int>[];
  List<Map<String, dynamic>> allData = <Map<String, dynamic>>[];
  int index = 0;

  Future<void> getFromTable() async {
    allData = await NewsTableService().readData();
  }

  Future<void> getTopIds() async {
    final NetworkService networkService = NetworkService(
        'https://hacker-news.firebaseio.com/v0/topstories.json?print=pretty');

    final dynamic allIds = await networkService.getData();
    if (allIds != null) {
      for (final dynamic x in allIds) {
        allTopIds.add(x as int);
      }
    }

    notifyListeners();
  }

  Future<NewsModel> getNewsById(int id) async {
    final NetworkService networkService = NetworkService(
        'https://hacker-news.firebaseio.com/v0/item/$id.json?print=pretty');

    final dynamic news = await networkService.getData();
    if (news != null) {
      return NewsModel.fromJson(news as Map<String, dynamic>);
    } else {
      return null;
    }
  }

  Future<void> getNextNews() async {
    final List<NewsModel> newNewsList = <NewsModel>[];
    if (allTopIds.isEmpty) await getTopIds();

    if (allTopIds.isNotEmpty) {
      for (int i = 0; i < 10 && index < 500; i++) {
        final List<Map<String, dynamic>> data =
            await NewsTableService().readDataById(allTopIds[index]);
        if (data.isNotEmpty) {
          newNewsList.add(NewsModel.fromJson(data[0]));
          index++;
        } else {
          final NewsModel newNews = await getNewsById(allTopIds[index]);
          if (newNews != null) {
            newNewsList.add(newNews);
            await NewsTableService().insertData(newNews.toJson());
            index++;
          }
        }
      }
    } else {
      if (allData.isEmpty) await getFromTable();
      for (int i = 0; i < 10; i++, index++) {
        if (allData.length > index) {
          newNewsList.add(NewsModel.fromJson(allData[index]));
        }
      }
    }
    newsList.addAll(newNewsList);
    notifyListeners();
  }
}
