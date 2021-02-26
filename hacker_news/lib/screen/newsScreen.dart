import 'package:flutter/material.dart';
import 'package:hacker_news/view_model/news_list_model.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class NewsScreen extends StatelessWidget {
  NewsScreen({this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    final df = new DateFormat('dd-MM-yyyy hh:mm a');
    final int myvalue =
        Provider.of<NewsListModel>(context).newsList[index].time;

    return Scaffold(
        appBar: AppBar(
          title: Text(
              Provider.of<NewsListModel>(context).newsList[index].title ??
                  'hii'),
        ),
        body: Container(
            child: Column(
          children: [
            Text(Provider.of<NewsListModel>(context).newsList[index].by),
            Text(df.format(
                new DateTime.fromMillisecondsSinceEpoch(myvalue * 1000)))
          ],
        )));
  }
}
