import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../model/article_model.dart';
import '../theme/app_theme.dart';

class ArticleCreator extends StatelessWidget {
  final Article data;
  final DateFormat formatter = DateFormat('MMMM dd, yyyy');

  ArticleCreator(this.data, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
          child: CircleAvatar(
            backgroundImage: NetworkImage(data.author.image),
          )),
      Wrap(direction: Axis.vertical, children: [
        Text(data.author.username,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 16,
            )),
        Text(formatter.format(data.updatedAt),
            style: TextStyle(
              color: Theme.of(context).colorScheme.rwLightGray,
              fontSize: 12,
            )),
      ]),
    ]);
  }
}
