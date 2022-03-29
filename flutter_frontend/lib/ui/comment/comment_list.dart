import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../model/article_model.dart';
import '../../model/comment_model.dart';
import '../../service/comment_service.dart';
import '../../state/login_state.dart';
import '../article/article_signin_or_signup.dart';
import 'comment_item.dart';
import 'comment_new.dart';

class CommentList extends StatefulWidget {
  final Article article;

  const CommentList(this.article, {Key? key}) : super(key: key);

  @override
  State<CommentList> createState() => _CommentListState();
}

class _CommentListState extends State<CommentList> {
  final commentService = CommentService(http.Client());

  @override
  Widget build(BuildContext context) {
    addComment(String comment) async {
      var loginState = context.read<LoginState>();
      await commentService.createComment(comment, widget.article.slug, loginState.user?.token ?? '');
      setState(() {});
    }

    var CommentHeader = Container(
        margin: const EdgeInsets.fromLTRB(300, 0, 300, 0),
        padding: const EdgeInsets.all(20.0),
        child: Consumer<LoginState>(builder: (context, loginState, child) {
          if (loginState.user == null) {
            return const SigninOrSignup();
          } else {
            return CommentNew(onAddComment: addComment);
          }
        }));

    return FutureBuilder<List<Comment>>(
        future: commentService.fetchComments(widget.article.slug),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isNotEmpty) {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) {
                      return Column(
                        children: <Widget>[
                          CommentHeader,
                          ListTile(
                            title: CommentItem(snapshot.data![index]),
                          ),
                        ],
                      );
                    } else {
                      return ListTile(
                        title: CommentItem(snapshot.data![index]),
                      );
                    }
                  });
            } else {
              return CommentHeader;
            }
          }
          return const Text('Loading comments...');
        });
  }
}
