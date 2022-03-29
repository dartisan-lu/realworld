import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../theme/app_theme.dart';

class ArticleCategory extends StatelessWidget {
  final String text;
  final DateFormat formatter = DateFormat('MMMM dd, yyyy');

  ArticleCategory(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(text,
          style: TextStyle(
            color: Theme.of(context).colorScheme.rwLightGray,
            fontSize: 12,
          )),
      labelPadding: const EdgeInsets.fromLTRB(0, -3, 0, -3),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Theme.of(context).colorScheme.rwLightGray, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      backgroundColor: Colors.transparent,
    );
  }
}
