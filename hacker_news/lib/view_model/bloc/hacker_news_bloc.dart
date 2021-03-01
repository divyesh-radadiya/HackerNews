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
  final AppDatabase _appDatabase = AppDatabase();
  final NetworkService _networkService = NetworkService();

  @override
  Stream<HackerNewsState> mapEventToState(
    HackerNewsEvent event,
  ) async* {
    if (event is GetData) {
      if (allTopIds.isEmpty) await _networkService.getTopIds();
      if (newsList.isEmpty) {
        yield LoadingState();
      }
      final List<NewsModel> newNewsList = <NewsModel>[];
      if (allTopIds.isNotEmpty) {
        for (int i = 0; i < 10 && newsList.length < allTopIds.length; i++) {
          final NewsTableData data =
              await _appDatabase.getNewsById(allTopIds[newsList.length]);

          if (data != null) {
            newNewsList.add(NewsModel.fromJson(data.toJson()));
          } else {
            final NewsModel newNews =
                await _networkService.getNewsById(allTopIds[newsList.length]);
            if (newNews != null) {
              newNewsList.add(newNews);
              await _appDatabase
                  .insertNews(NewsTableData.fromJson(newNews.toJson()));
            }
          }
        }
      } else {
        if (allDataFromTable.isEmpty) {
          allDataFromTable = await _appDatabase.getAllNews();
        }

        for (int i = 0; i < 10; i++) {
          if (allDataFromTable.length > newsList.length) {
            newNewsList.add(
                NewsModel.fromJson(allDataFromTable[newsList.length].toJson()));
          }
        }
      }
      newsList.addAll(newNewsList);

      yield SuccessState(newsList: newsList);
    }
  }
}
