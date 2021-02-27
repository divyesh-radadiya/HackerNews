import 'package:flutter/material.dart';
import 'package:hacker_news/view_model/news_list_model.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    final DateFormat df = DateFormat('dd-MM-yyyy hh:mm a');
    final int myvalue =
        Provider.of<NewsListModel>(context).newsList[index].time;

    return Scaffold(
        appBar: AppBar(
          title: Text(Provider.of<NewsListModel>(context)
              .newsList[index]
              .id
              .toString()),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text('Title :'),
              Text(Provider.of<NewsListModel>(context).newsList[index].title),
              const SizedBox(
                height: 10.0,
              ),
              const Text('By :'),
              Text(Provider.of<NewsListModel>(context).newsList[index].by),
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
