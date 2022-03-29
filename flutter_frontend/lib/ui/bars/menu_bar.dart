import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../state/login_state.dart';
import '../bars/menu_bar_user.dart';
import '../scaffold/editoral_scaffold.dart';
import '../scaffold/settings_scaffold.dart';
import '../scaffold/signin_scaffold.dart';
import '../scaffold/signup_scaffold.dart';
import '../scaffold/welcome_scaffold.dart';

class MenuBar extends StatelessWidget {
  const MenuBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const menuItemUnselect = TextStyle(
      color: Color(0xdd00004d),
      fontSize: 16,
    );

    return Container(
        margin: const EdgeInsets.fromLTRB(150, 0, 150, 0),
        child: Row(children: [
          Text(
            'conduit',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 24,
            ),
          ),
          const Spacer(),
          TextButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context, MaterialPageRoute(builder: (_) => WelcomeScaffold()), (route) => false);
            },
            child: const Text('Home', style: menuItemUnselect),
          ),
          Consumer<LoginState>(builder: (context, loginState, child) {
            if (loginState.user == null) {
              return Row(
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                          context, MaterialPageRoute(builder: (_) => SigninScaffold()), (route) => false);
                    },
                    child: const Text('Signin', style: menuItemUnselect),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                          context, MaterialPageRoute(builder: (_) => SignupScaffold()), (route) => false);
                    },
                    child: const Text('Signup', style: menuItemUnselect),
                  ),
                ],
              );
            } else {
              return Row(
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context, MaterialPageRoute(builder: (_) => EditoralScaffold()), (route) => false);
                      },
                      child: Row(children: const [
                        Icon(Icons.create_sharp),
                        Text('New Article', style: menuItemUnselect),
                      ])),
                  TextButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context, MaterialPageRoute(builder: (_) => SettingsScaffold()), (route) => false);
                      },
                      child: Row(children: const [
                        Icon(Icons.brightness_low_rounded),
                        Text('Settings', style: menuItemUnselect),
                      ])),
                  loginState.user != null ? MenuBarUser(loginState.user!) : const SizedBox()
                ],
              );
            }
          }),
        ]));
  }
}
