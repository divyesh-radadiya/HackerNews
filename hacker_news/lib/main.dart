import 'package:flutter/material.dart';
import 'package:hacker_news/screen/home_screen.dart';
import 'package:hacker_news/view_model/bloc/hacker_news_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HackerNewsBloc>(
      create: (BuildContext context) => HackerNewsBloc(),
      child: MaterialApp(
        home: HomeScreen(),
      ),
    );
  }
}
