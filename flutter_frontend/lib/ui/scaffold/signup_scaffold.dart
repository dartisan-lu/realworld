import 'package:flutter/material.dart';
import 'package:flutter_real_world_example_app/ui/scaffold/welcome_scaffold.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '/service/user_service.dart';
import '/ui/widget/signin_error.dart';
import '../../model/user_model.dart';
import '../../state/login_state.dart';
import '../bars/footer_bar.dart';
import '../bars/menu_bar.dart';
import '../theme/app_theme.dart';
import 'signin_scaffold.dart';

class SignupScaffold extends StatelessWidget {
  final userService = UserService(http.Client());

  SignupScaffold({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController username = TextEditingController();
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();

    void doLogin() {
      success() {
        Navigator.pushAndRemoveUntil(
            context, MaterialPageRoute(builder: (_) => const WelcomeScaffold()), (route) => false);
      }

      var loginState = context.read<LoginState>();
      var user = LoginUser(email: email.value.text, password: password.value.text, username: username.value.text);
      userService.create(user, loginState, success);
    }

    return Scaffold(
        appBar: AppBar(title: const MenuBar()),
        body: Column(children: [
          Container(
              margin: const EdgeInsets.fromLTRB(300, 50, 300, 0),
              child: Wrap(direction: Axis.horizontal, runSpacing: 20, children: [
                const Center(
                    child: Text(
                  'Sign up',
                  style: TextStyle(
                    fontSize: 40,
                  ),
                )),
                Center(
                    child: InkWell(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                              context, MaterialPageRoute(builder: (_) => SigninScaffold()), (route) => false);
                        },
                        child: Text(
                          'Have an account?',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 14,
                          ),
                        ))),
                const Center(child: SigninError()),
                TextField(
                    controller: username,
                    decoration: InputDecoration(
                      hintText: 'Username',
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
                      hintText: 'Password',
                      border: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                          borderSide: BorderSide(color: defaultTheme.colorScheme.rwLightGray)),
                    )),
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  ElevatedButton(
                      child: const Padding(
                          padding: EdgeInsets.fromLTRB(24, 12, 24, 12),
                          child: Text(
                            'Sign up',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          )),
                      onPressed: doLogin,
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
