import 'package:flutter/material.dart';
import 'package:flutter_real_world_example_app/ui/scaffold/signin_scaffold.dart';
import 'package:flutter_real_world_example_app/ui/widget/popular_tags.dart';
import 'package:provider/provider.dart';

import '../../state/login_state.dart';
import '../article/article_list.dart';

class FeedTabPanel extends StatelessWidget {
  const FeedTabPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void checkLogin(int id) {
      var loginState = context.read<LoginState>();
      if (id == 0 && loginState.user == null) {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => SigninScaffold()), (route) => false);
      }
    }

    return Expanded(
        child: Container(
            margin: const EdgeInsets.fromLTRB(150, 30, 150, 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    flex: 3,
                    child: DefaultTabController(
                        length: 2,
                        initialIndex: 1,
                        child: Scaffold(
                            appBar: AppBar(
                              elevation: 0,
                              backgroundColor: Colors.transparent,
                              toolbarOpacity: 0,
                              title: TabBar(
                                tabs: const [
                                  Tab(text: 'Your Feed'),
                                  Tab(text: 'Global Feed'),
                                ],
                                onTap: (index) => checkLogin(index),
                              ),
                            ),
                            body: TabBarView(children: [
                              const Text('1'),
                              ArticleList(),
                            ])))),
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: PopularTags(),
                  ),
                )
              ],
            )));
  }
}
