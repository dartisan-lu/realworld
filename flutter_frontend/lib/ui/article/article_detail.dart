import 'package:flutter/material.dart';

import '../../../model/article_model.dart';
import '../bars/footer_bar.dart';
import '../comment/comment_list.dart';
import '../theme/app_theme.dart';
import 'article_category.dart';
import 'article_creator.dart';

class ArticleDetail extends StatelessWidget {
  final Article article;

  const ArticleDetail(this.article, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
          child: Container(
            margin: const EdgeInsets.fromLTRB(150, 0, 150, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                    child: Text(
                      article.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 48,
                      ),
                    )),
                ArticleCreator(article)
              ],
            ),
          ),
          color: Theme.of(context).colorScheme.rwBrown,
          padding: const EdgeInsets.fromLTRB(0, 32, 0, 32)),
      Container(
          margin: const EdgeInsets.fromLTRB(150, 20, 150, 0),
          child: Wrap(
            spacing: 30,
            runSpacing: 30,
            children: [
              Text(
                article.body,
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
              ListView(primary: true, shrinkWrap: true, children: <Widget>[
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List<Widget>.generate(article.tagList.length, // place the length of the array here
                        (int index) {
                      return Container(
                        margin: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                        child: ArticleCategory(article.tagList[index]),
                      );
                    }).toList())
              ]),
              Divider(
                color: Theme.of(context).colorScheme.rwLightGray,
              ),
            ],
          )),
      Expanded(child: CommentList(article)),
      const FooterBar()
    ]);
  }
}
