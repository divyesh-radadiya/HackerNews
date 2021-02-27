import 'package:flutter/material.dart';
import 'package:hacker_news/view_model/news_model.dart';
import 'package:intl/intl.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({this.news});
  final NewsModel news;

  @override
  Widget build(BuildContext context) {
    final DateFormat df = DateFormat('dd-MM-yyyy hh:mm a');
    final int myvalue = news.time;

    return Scaffold(
        appBar: AppBar(
          title: Text(news.id.toString()),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text('Title :'),
              Text(news.title),
              const SizedBox(
                height: 10.0,
              ),
              const Text('By :'),
              Text(news.by),
              const SizedBox(
                height: 10.0,
              ),
              const Text('Time :'),
              Text(df
                  .format(DateTime.fromMillisecondsSinceEpoch(myvalue * 1000)))
            ],
          ),
        ));
  }
}
