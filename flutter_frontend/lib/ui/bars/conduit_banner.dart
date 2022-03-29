import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../state/login_state.dart';

class ConduitBanner extends StatelessWidget {
  const ConduitBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginState>(builder: (context, loginState, child) {
      if (loginState.user == null) {
        return Container(
            child: Center(
              child: Column(
                children: const [
                  Text(
                    'conduit',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 56,
                    ),
                  ),
                  Text(
                    'A place to share your Flutter knowledge.',
                    style: TextStyle(color: Colors.white, fontSize: 28),
                  ),
                ],
              ),
            ),
            color: Theme.of(context).primaryColor,
            padding: const EdgeInsets.fromLTRB(0, 32, 0, 32));
      } else {
        return const SizedBox();
      }
    });
  }
}
