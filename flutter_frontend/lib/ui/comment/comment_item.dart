import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../model/comment_model.dart';
import '../theme/app_theme.dart';

class CommentItem extends StatelessWidget {
  final Comment data;
  final DateFormat formatter = DateFormat('MMMM dd, yyyy');

  CommentItem(this.data, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(300, 0, 300, 0),
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).colorScheme.rwLightGray),
        borderRadius: BorderRadius.circular(2),
      ),
      child: Column(
        children: [
          Padding(padding: const EdgeInsets.fromLTRB(20, 20, 20, 20), child: SelectableText(data.body)),
          Container(
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: Theme.of(context).colorScheme.rwLightGray)),
                color: Theme.of(context).colorScheme.rwWhite,
              ),
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 10,
                        backgroundImage: NetworkImage(data.author.image),
                      ),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Text(
                            data.author.username,
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 12,
                            ),
                          )),
                      Text(
                        formatter.format(data.updatedAt),
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.rwLightGray,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ))),
        ],
      ),
    );
  }
}
