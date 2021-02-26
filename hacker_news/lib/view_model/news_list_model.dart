import 'package:flutter/material.dart';
import 'package:hacker_news/services/network_service.dart';
import 'package:hacker_news/view_model/news_model.dart';

class NewsListModel extends ChangeNotifier {
  List<NewsModel> newsList = List<NewsModel>();
  List<int> allTopIds = List<int>();
  int index = 0;

  Future<void> getTopIds() async {
    final NetworkService networkService = NetworkService(
        'https://hacker-news.firebaseio.com/v0/topstories.json?print=pretty');

    final dynamic allIds = await networkService.getData();
    for (final dynamic x in allIds) {
      allTopIds.add(x);
    }
    notifyListeners();
    await getNextNews();
  }

  Future<NewsModel> getNewsById(int id) async {
    final NetworkService networkService = NetworkService(
        'https://hacker-news.firebaseio.com/v0/item/$id.json?print=pretty');

    final dynamic news = await networkService.getData();
    return NewsModel.fromJson(news);
  }

  Future<void> getNextNews() async {
    List<NewsModel> newNewsList = List<NewsModel>();
    for (int i = 0; i < 10 && index < allTopIds.length; i++, index++) {
      newNewsList.add(await getNewsById(allTopIds[index]));
    }
    newsList.addAll(newNewsList);
    notifyListeners();
  }
}
