import 'package:flutter/material.dart';
import 'package:flutter_real_world_example_app/ui/scaffold/welcome_scaffold.dart';
import 'package:provider/provider.dart';

import '/ui/widget/signin_error.dart';
import '../../state/login_state.dart';
import '../bars/footer_bar.dart';
import '../bars/menu_bar.dart';
import '../theme/app_theme.dart';

class SettingsScaffold extends StatelessWidget {
  const SettingsScaffold({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController username = TextEditingController();
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();
    TextEditingController url = TextEditingController();
    TextEditingController bio = TextEditingController();

    void doLogout() {
      var loginState = context.read<LoginState>();
      loginState.logout();
      Navigator.pushAndRemoveUntil(
          context, MaterialPageRoute(builder: (_) => const WelcomeScaffold()), (route) => false);
    }

    void updateSettings() {}

    return Scaffold(
        appBar: AppBar(title: const MenuBar()),
        body: ListView(children: [
          Container(
              margin: const EdgeInsets.fromLTRB(300, 50, 300, 0),
              child: Wrap(direction: Axis.horizontal, runSpacing: 20, children: [
                const Center(
                    child: Text(
                  'Your Settings',
                  style: TextStyle(
                    fontSize: 40,
                  ),
                )),
                const Center(child: SigninError()),
                TextField(
                    controller: url,
                    decoration: InputDecoration(
                      hintText: 'URL of profile picture',
                      border: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                          borderSide: BorderSide(color: defaultTheme.colorScheme.rwLightGray)),
                    )),
                TextField(
                    controller: username,
                    decoration: InputDecoration(
                      hintText: 'Username',
                      border: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                          borderSide: BorderSide(color: defaultTheme.colorScheme.rwLightGray)),
                    )),
                TextField(
                    controller: bio,
                    enableSuggestions: false,
                    autocorrect: false,
                    minLines: 4,
                    maxLines: 5,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      hintText: 'Sort bio about you',
                      border: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                          borderSide: BorderSide(color: defaultTheme.colorScheme.rwLightGray)),
                    )),
                TextField(
                    controller: email,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      border: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                          borderSide: BorderSide(color: defaultTheme.colorScheme.rwLightGray)),
                    )),
                TextField(
                    controller: password,
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: InputDecoration(
                      hintText: 'New Password',
                      border: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                          borderSide: BorderSide(color: defaultTheme.colorScheme.rwLightGray)),
                    )),
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  ElevatedButton(
                      child: const Padding(
                          padding: EdgeInsets.fromLTRB(24, 12, 24, 12),
                          child: Text(
                            'Update Settings',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          )),
                      onPressed: updateSettings,
                      style: ButtonStyle(
                          //backgroundColor: Color(0xFF5cb85c),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ))))
                ]),
                const Divider(
                  color: Colors.black,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  OutlinedButton(
                      onPressed: doLogout,
                      child: Padding(
                          padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
                          child: Text(
                            'Or click here to logout',
                            style: TextStyle(fontSize: 16, color: defaultTheme.colorScheme.rwLogoutColor),
                          )),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(width: 1.0, color: defaultTheme.colorScheme.rwLogoutColor),
                      )),
                ])
              ])),
          const SizedBox(height: 20),
          const FooterBar()
        ]));
  }
}
