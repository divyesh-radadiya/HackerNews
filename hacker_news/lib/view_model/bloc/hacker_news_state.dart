part of 'hacker_news_bloc.dart';

@immutable
abstract class HackerNewsState {}

class LoadingState extends HackerNewsState {}

class FailState extends HackerNewsState {}

class SuccessState extends HackerNewsState {
  SuccessState({this.newsList});
  final List<NewsModel> newsList;
}
