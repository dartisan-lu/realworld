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
import 'signup_scaffold.dart';

class SigninScaffold extends StatelessWidget {
  final userService = UserService(http.Client());

  SigninScaffold({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();

    void doLogin() {
      success() {
        Navigator.pushAndRemoveUntil(
            context, MaterialPageRoute(builder: (_) => const WelcomeScaffold()), (route) => false);
      }

      var loginState = context.read<LoginState>();
      var user = LoginUser(email: email.value.text, password: password.value.text);
      userService.login(user, loginState, success);
    }

    return Scaffold(
        appBar: AppBar(title: const MenuBar()),
        body: Column(children: [
          Container(
              margin: const EdgeInsets.fromLTRB(300, 50, 300, 0),
              child: Wrap(direction: Axis.horizontal, runSpacing: 20, children: [
                const Center(
                    child: Text(
                  'Sign in',
                  style: TextStyle(
                    fontSize: 40,
                  ),
                )),
                Center(
                    child: InkWell(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                              context, MaterialPageRoute(builder: (_) => SignupScaffold()), (route) => false);
                        },
                        child: Text(
                          'Need an account?',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 14,
                          ),
                        ))),
                const Center(child: SigninError()),
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
                            'Sign in',
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
