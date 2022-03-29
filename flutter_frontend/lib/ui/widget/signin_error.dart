import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../state/login_state.dart';

class SigninError extends StatelessWidget {
  const SigninError({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginState>(builder: (context, loginState, child) {
      if (loginState.errorMessage == null) {
        return const SizedBox.shrink();
      } else {
        return Text(
          loginState.errorMessage!,
          style: const TextStyle(color: Colors.red, fontSize: 16, fontWeight: FontWeight.bold),
        );
      }
    });
  }
}
