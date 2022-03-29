import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class CommentNew extends StatelessWidget {
  Function(String comment) onAddComment;

  CommentNew({required this.onAddComment, Key? key}) : super(key: key);
  TextEditingController content = TextEditingController();

  void addComment() {
    onAddComment(content.value.text);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).colorScheme.rwLightGray),
        borderRadius: BorderRadius.circular(2),
      ),
      child: Column(
        children: [
          Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: TextField(
                  controller: content,
                  enableSuggestions: false,
                  autocorrect: false,
                  minLines: 4,
                  maxLines: 5,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                    hintText: 'Write a comment...',
                    border: InputBorder.none,
                  ))),
          Container(
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: Theme.of(context).colorScheme.rwLightGray)),
                color: Theme.of(context).colorScheme.rwWhite,
              ),
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                          child: const Padding(
                              padding: EdgeInsets.fromLTRB(20, 12, 20, 12),
                              child: Text(
                                'Post Comment',
                                style: TextStyle(fontSize: 16, color: Colors.white),
                              )),
                          onPressed: addComment,
                          style: ButtonStyle(
                              //backgroundColor: Color(0xFF5cb85c),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ))))
                    ],
                  ))),
        ],
      ),
    );
  }
}
