import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../model/article_model.dart';
import '../../../service/article_service.dart';
import 'article_item.dart';

class ArticleList extends StatelessWidget {
  final articleService = ArticleService(http.Client());

  ArticleList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Article>>(
        future: articleService.fetchArticles(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isNotEmpty) {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: ArticleItem(snapshot.data![index]),
                    );
                  });
            } else {
              return const Text('No Articles yet created...');
            }
          }
          return const Text('Loading articles...');
        });
  }
}
