import 'package:flutter/material.dart';
import 'package:flutter_real_world_example_app/model/article_model.dart';
import 'package:flutter_real_world_example_app/service/article_service.dart';
import 'package:flutter_real_world_example_app/ui/scaffold/welcome_scaffold.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../state/login_state.dart';
import '../bars/footer_bar.dart';
import '../bars/menu_bar.dart';
import '../theme/app_theme.dart';
import '../widget/signin_error.dart';

class EditoralScaffold extends StatelessWidget {
  final ArticleService articleService = ArticleService(http.Client());

  EditoralScaffold({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController title = TextEditingController();
    TextEditingController about = TextEditingController();
    TextEditingController content = TextEditingController();
    TextEditingController tags = TextEditingController();

    saveArticle() {
      success() {
        Navigator.pushAndRemoveUntil(
            context, MaterialPageRoute(builder: (_) => const WelcomeScaffold()), (route) => false);
      }

      var loginState = context.read<LoginState>();
      var article = NewArticle(
          title: title.value.text,
          description: about.value.text,
          body: content.value.text,
          tagList: tags.value.text.split(' ').toList());
      articleService.createArticle(article, loginState.user?.token, success, () => {});
    }

    return Scaffold(
        appBar: AppBar(title: const MenuBar()),
        body: Column(children: [
          Container(
              margin: const EdgeInsets.fromLTRB(300, 50, 300, 0),
              child: Wrap(direction: Axis.horizontal, runSpacing: 20, children: [
                const Center(child: SigninError()),
                TextField(
                    controller: title,
                    decoration: InputDecoration(
                      hintText: 'Article Title',
                      border: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                          borderSide: BorderSide(color: defaultTheme.colorScheme.rwLightGray)),
                    )),
                TextField(
                    controller: about,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: InputDecoration(
                      hintText: "What's this article about?",
                      border: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                          borderSide: BorderSide(color: defaultTheme.colorScheme.rwLightGray)),
                    )),
                TextField(
                    controller: content,
                    enableSuggestions: false,
                    autocorrect: false,
                    minLines: 4,
                    maxLines: 5,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      hintText: 'Write your article (in markdown)',
                      border: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                          borderSide: BorderSide(color: defaultTheme.colorScheme.rwLightGray)),
                    )),
                TextField(
                    controller: tags,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: InputDecoration(
                      hintText: 'Enter tags',
                      border: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                          borderSide: BorderSide(color: defaultTheme.colorScheme.rwLightGray)),
                    )),
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  ElevatedButton(
                      child: const Padding(
                          padding: EdgeInsets.fromLTRB(24, 12, 24, 12),
                          child: Text(
                            'Publish Article',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          )),
                      onPressed: () => saveArticle(),
                      style: ButtonStyle(
                          //backgroundColor: Color(0xFF5cb85c),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ))))
                ])
              ])),
          const Expanded(child: SizedBox()),
          const FooterBar()
        ]));
  }
}
