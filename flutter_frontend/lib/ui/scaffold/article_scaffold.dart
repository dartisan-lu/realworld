import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../model/article_model.dart';
import '../../service/article_service.dart';
import '../article/article_detail.dart';
import '../bars/menu_bar.dart';

class ArticleScaffold extends StatelessWidget {
  final String articleLink;

  final articleService = ArticleService(http.Client());

  ArticleScaffold(this.articleLink, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const MenuBar()),
      body: FutureBuilder<Article?>(
          future: articleService.fetchArticle(articleLink),
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              return ArticleDetail(snapshot.data!);
            } else {
              return const SizedBox();
            }
          }),
    );
  }
}
