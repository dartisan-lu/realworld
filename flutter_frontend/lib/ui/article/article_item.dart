import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../model/article_model.dart';
import '../scaffold/article_scaffold.dart';
import '../theme/app_theme.dart';
import '../widget/favorite_count.dart';
import 'article_category.dart';
import 'article_creator.dart';

class ArticleItem extends StatelessWidget {
  final Article data;
  final DateFormat formatter = DateFormat('MMMM dd, yyyy');

  ArticleItem(this.data, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        children: [
          ArticleCreator(data),
          const Spacer(),
          FavoriteCount(data.favoritesCount),
        ],
      ),
      InkWell(
          onTap: () {
            Navigator.pushAndRemoveUntil(
                context, MaterialPageRoute(builder: (_) => ArticleScaffold(data.slug)), (route) => false);
          },
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.title,
                  style: const TextStyle(
                    fontSize: 24,
                  ),
                ),
                Text(
                  data.description,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.rwLightGray,
                  ),
                ),
                Text(
                  'Read more...',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.rwLightGray,
                    fontSize: 12,
                  ),
                ),
                ListView(primary: true, shrinkWrap: true, children: <Widget>[
                  Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: List<Widget>.generate(data.tagList.length, // place the length of the array here
                          (int index) {
                        return Container(
                          margin: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                          child: ArticleCategory(data.tagList[index]),
                        );
                      }).toList())
                ]),
              ]))
    ]);
  }
}
