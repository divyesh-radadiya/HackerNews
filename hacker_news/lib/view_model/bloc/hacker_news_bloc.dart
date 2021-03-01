import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:hacker_news/services/add_news_to_screen_service.dart';
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
  final AddNewsToScreenService _addNewsToScreenService =
      AddNewsToScreenService();
  @override
  Stream<HackerNewsState> mapEventToState(
    HackerNewsEvent event,
  ) async* {
    if (event is GetData) {
      if (allTopIds.isEmpty) {
        allTopIds = await _addNewsToScreenService.getTopIds();
      }
      if (newsList.isEmpty) {
        yield LoadingState();
      }
      List<NewsModel> newNewsList = <NewsModel>[];
      if (allTopIds.isNotEmpty) {
        newNewsList =
            await _addNewsToScreenService.getNews(newsList.length, allTopIds);
      } else {
        newNewsList =
            await _addNewsToScreenService.getAllNewsFromTable(newsList.length);
      }
      newsList.addAll(newNewsList);

      yield SuccessState(newsList: newsList);
    }
  }
}
