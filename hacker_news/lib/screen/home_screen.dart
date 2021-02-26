import 'package:flutter/material.dart';
import 'package:hacker_news/screen/newsScreen.dart';
import 'package:hacker_news/view_model/news_list_model.dart';
import 'package:provider/provider.dart';
import 'loading.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController myScrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    print('call init');
    Provider.of<NewsListModel>(context, listen: false).getTopIds();
    myScrollController.addListener(() {
      if (myScrollController.position.pixels ==
          myScrollController.position.maxScrollExtent) {
        Provider.of<NewsListModel>(context, listen: false).getNextNews();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hecker News'),
      ),
      body: Consumer<NewsListModel>(
        builder: (context, value, child) => (value.newsList.length == 0)
            ? Loading()
            : ListView.builder(
                controller: myScrollController,
                itemCount: value.newsList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
                    child: Card(
                      elevation: 5.0,
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      NewsScreen(index: index)));
                        },
                        title: Text(value.newsList[index].title),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('${value.newsList[index].id}'),
                            Text('${value.newsList[index].by}'),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
