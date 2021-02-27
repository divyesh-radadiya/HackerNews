import 'package:flutter/material.dart';
import 'package:hacker_news/screen/news_screen.dart';
import 'package:hacker_news/view_model/news_list_model.dart';
import 'package:provider/provider.dart';
import 'loading.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController myScrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    Provider.of<NewsListModel>(context, listen: false).getNextNews();
    myScrollController.addListener(() async {
      if (myScrollController.position.pixels ==
          myScrollController.position.maxScrollExtent) {
        await Provider.of<NewsListModel>(context, listen: false).getNextNews();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hecker News'),
      ),
      body: Consumer<NewsListModel>(
        builder: (BuildContext context, NewsListModel value, Widget child) =>
            (value.newsList.isEmpty)
                ? Loading()
                : ListView.builder(
                    controller: myScrollController,
                    itemCount: value.newsList.length + 1,
                    itemBuilder: (BuildContext context, int index) {
                      if (index != value.newsList.length) {
                        return Padding(
                          padding:
                              const EdgeInsets.only(top: 8, left: 8, right: 8),
                          child: Card(
                            elevation: 5.0,
                            child: ListTile(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute<dynamic>(
                                        builder: (BuildContext context) =>
                                            NewsScreen(index: index)));
                              },
                              title: Text(value.newsList[index].title),
                              subtitle: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text('${value.newsList[index].id}'),
                                  Text(value.newsList[index].by),
                                ],
                              ),
                            ),
                          ),
                        );
                      } else {
                        return Center(
                          child: Container(
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 10),
                              height: 70.0,
                              width: 50.0,
                              child: const CircularProgressIndicator()),
                        );
                      }
                    },
                  ),
      ),
    );
  }
}
