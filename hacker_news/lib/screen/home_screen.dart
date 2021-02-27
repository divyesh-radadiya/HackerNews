import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hacker_news/screen/news_screen.dart';
import 'package:hacker_news/view_model/bloc/hacker_news_bloc.dart';

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
    BlocProvider.of<HackerNewsBloc>(context, listen: false).add(GetData());
    myScrollController.addListener(() async {
      if (myScrollController.position.pixels ==
          myScrollController.position.maxScrollExtent) {
        BlocProvider.of<HackerNewsBloc>(context, listen: false).add(GetData());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Hecker News'),
        ),
        body: BlocBuilder<HackerNewsBloc, HackerNewsState>(
            builder: (BuildContext context, HackerNewsState state) {
          if (state is LoadingState) {
            return Loading();
          } else if (state is SuccessState) {
            return ListView.builder(
              controller: myScrollController,
              itemCount: state.newsList.length + 1,
              itemBuilder: (BuildContext context, int index) {
                if (index != state.newsList.length) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
                    child: Card(
                      elevation: 5.0,
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute<dynamic>(
                                builder: (BuildContext context) =>
                                    NewsScreen(news: state.newsList[index])),
                          );
                        },
                        title: Text(state.newsList[index].title),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('${state.newsList[index].id}'),
                            Text(state.newsList[index].by),
                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  return Center(
                    child: Container(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        height: 70.0,
                        width: 50.0,
                        child: const CircularProgressIndicator()),
                  );
                }
              },
            );
          } else if (state is FailState) {
            return const Center(
              child: Text('failuer'),
            );
          } else {
            return const Center(
              child: Text('error'),
            );
          }
        }));
  }
}
