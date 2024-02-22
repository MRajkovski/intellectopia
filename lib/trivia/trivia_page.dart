import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_news_service/flutter_news_service.dart';
import '../app_drawer.dart';

class TriviaPage extends StatefulWidget {
  final User? user;
  final int selectedIndex;
  final Function(int) onDrawerItemTap;

  const TriviaPage({
    Key? key,
    required this.user,
    required this.selectedIndex,
    required this.onDrawerItemTap,
  }) : super(key: key);

  @override
  _TriviaPageState createState() => _TriviaPageState();
}

class _TriviaPageState extends State<TriviaPage> {
  late Future<List<ArticleResponse>> _newsFuture;

  @override
  void initState() {
    super.initState();
    _loadNews();
  }

  Future<void> _loadNews() async {
    var newsService = FlutterNewsService('57e26095b19a4393956ff611d5d7f928');

    setState(() {
      _newsFuture = newsService
          .fetchTopHeadlines(country: 'us')
          .then((response) => [response]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trivia'),
      ),
      drawer: AppDrawer(
        user: widget.user,
        selectedIndex: widget.selectedIndex,
        onDrawerItemTap: widget.onDrawerItemTap,
      ),
      body: Center(
        child: FutureBuilder<List<ArticleResponse>>(
          future: _newsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error loading news');
            } else if (snapshot.hasData && snapshot.data != null) {
              List<ArticleResponse> news = snapshot.data!;
              return ListView.builder(
                itemCount: news.length,
                itemBuilder: (context, index) {
                  ArticleResponse response = news[index];
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: response.articles.length,
                    itemBuilder: (context, index) {
                      Article article = response.articles[index];
                      return Card(
                        elevation: 3,
                        margin: EdgeInsets.all(8),
                        child: ListTile(
                          title: Text(article.title ?? 'No title'),
                          subtitle:
                              Text(article.description ?? 'No description'),
                        ),
                      );
                    },
                  );
                },
              );
            } else {
              return Text('No news available');
            }
          },
        ),
      ),
    );
  }
}
