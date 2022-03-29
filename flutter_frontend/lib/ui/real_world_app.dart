import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/login_state.dart';
import 'scaffold/editoral_scaffold.dart';
import 'scaffold/settings_scaffold.dart';
import 'scaffold/signin_scaffold.dart';
import 'scaffold/signup_scaffold.dart';
import 'scaffold/welcome_scaffold.dart';
import 'theme/app_theme.dart';

class RealWorldApp extends StatelessWidget {
  const RealWorldApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginState>(builder: (context, loginState, child) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter - Real World Example App',
        theme: defaultTheme,
        home: const WelcomeScaffold(),
        routes: <String, WidgetBuilder>{
          '/register': (BuildContext context) => SignupScaffold(),
          '/login': (BuildContext context) => SigninScaffold(),
          '/editor': (BuildContext context) => loginState.user == null ? SigninScaffold() : EditoralScaffold(),
          '/settings': (BuildContext context) => loginState.user == null ? SigninScaffold() : const SettingsScaffold(),
          '/profile/DUMMY': (BuildContext context) => const Text('B'),
          'article/DUMMY': (BuildContext context) => const Text('B'),
        },
      );
    });
  }
}
