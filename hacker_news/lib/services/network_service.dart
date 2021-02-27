import 'package:dio/dio.dart';

class NetworkService {
  NetworkService(this._url);

  final String _url;

  Future<dynamic> getData() async {
    try {
      final Dio dio = Dio();
      dio.options.connectTimeout = 5000;
      final Response<dynamic> response = await dio.get(_url);
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
}
