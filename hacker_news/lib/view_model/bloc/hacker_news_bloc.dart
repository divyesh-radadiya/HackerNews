import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:hacker_news/services/network_service.dart';
import 'package:hacker_news/view_model/news_model.dart';
import 'package:meta/meta.dart';
import 'package:hacker_news/services/news_table.dart';
part 'hacker_news_event.dart';
part 'hacker_news_state.dart';

class HackerNewsBloc extends Bloc<HackerNewsEvent, HackerNewsState> {
  HackerNewsBloc() : super(LoadingState());

  List<NewsModel> newsList = <NewsModel>[];
  List<int> allTopIds = <int>[];
  List<NewsTableData> allDataFromTable = <NewsTableData>[];
  int index = 0;
  final AppDatabase _appDatabase = AppDatabase();

  @override
  Stream<HackerNewsState> mapEventToState(
    HackerNewsEvent event,
  ) async* {
    if (event is GetData) {
      if (allTopIds.isEmpty) await getTopIds();
      if (newsList.isEmpty) {
        yield LoadingState();
      }
      final List<NewsModel> newNewsList = <NewsModel>[];
      if (allTopIds.isNotEmpty) {
        for (int i = 0; i < 10 && index < 500; i++) {
          final NewsTableData data =
              await _appDatabase.getNewsById(allTopIds[index]);

          if (data != null) {
            newNewsList.add(NewsModel.fromJson(data.toJson()));
            index++;
          } else {
            final NewsModel newNews = await getNewsById(allTopIds[index]);
            if (newNews != null) {
              newNewsList.add(newNews);
              await _appDatabase
                  .insertNews(NewsTableData.fromJson(newNews.toJson()));
              index++;
            }
          }
        }
      } else {
        if (allDataFromTable.isEmpty) await getFromTable();
        for (int i = 0; i < 10; i++, index++) {
          if (allDataFromTable.length > index) {
            newNewsList
                .add(NewsModel.fromJson(allDataFromTable[index].toJson()));
          }
        }
      }
      newsList.addAll(newNewsList);

      yield SuccessState(newsList: newsList);
    }
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
  }

  Future<void> getFromTable() async {
    allDataFromTable = await (_appDatabase.getAllNews());
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
}
