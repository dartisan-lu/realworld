import 'package:flutter/material.dart';

import '../scaffold/signin_scaffold.dart';
import '../scaffold/signup_scaffold.dart';

class SigninOrSignup extends StatelessWidget {
  const SigninOrSignup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      InkWell(
          onTap: () {
            Navigator.pushAndRemoveUntil(
                context, MaterialPageRoute(builder: (_) => SigninScaffold()), (route) => false);
          },
          child: Text(
            'Sign in',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 14,
            ),
          )),
      const Text(' or '),
      InkWell(
          onTap: () {
            Navigator.pushAndRemoveUntil(
                context, MaterialPageRoute(builder: (_) => SignupScaffold()), (route) => false);
          },
          child: Text(
            'sign up',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 14,
            ),
          )),
      const Text(' to add comments on this article.')
    ]);
  }
}
