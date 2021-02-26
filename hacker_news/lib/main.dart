import 'package:flutter/material.dart';
import 'package:hacker_news/screen/home_screen.dart';
import 'package:provider/provider.dart';
import 'view_model/news_list_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<NewsListModel>(
      create: (BuildContext context) => NewsListModel(),
      child: MaterialApp(
        home: HomeScreen(),
      ),
    );
  }
}
