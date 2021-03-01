import 'package:dio/dio.dart';
import 'package:hacker_news/view_model/news_model.dart';

class NetworkService {
  Future<dynamic> _getData(String url) async {
    try {
      final Dio dio = Dio();
      dio.options.connectTimeout = 10000;
      final Response<dynamic> response = await dio.get(url);
      return response.data;
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response.data);
        print(e.response.headers);
        print(e.response.request);
      } else {
        print(e.request);
        print(e.message);
      }
      return null;
    }
  }

  Future<List<int>> getTopIds() async {
    List<int> ids = <int>[];
    final dynamic allIds = await _getData(
        'https://hacker-news.firebaseio.com/v0/topstories.json?print=pretty');
    if (allIds != null) {
      for (final dynamic x in allIds) {
        ids.add(x as int);
      }
    }
    return ids;
  }

  Future<NewsModel> getNewsById(int id) async {
    final String url =
        'https://hacker-news.firebaseio.com/v0/item/$id.json?print=pretty';

    final dynamic news = await _getData(url);
    if (news != null) {
      return NewsModel.fromJson(news as Map<String, dynamic>);
    } else {
      return null;
    }
  }
}
