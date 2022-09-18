import 'package:flutter/material.dart';
import 'package:flutter_real_world_example_app/state/login_state.dart';
import 'package:flutter_real_world_example_app/ui/real_world_app.dart';
import 'package:provider/provider.dart';

import 'configure_nonweb.dart' if (dart.library.html) 'configure_web.dart';

void main() {
  configureApp();
  runApp(const ProviderContextApp());
}

class ProviderContextApp extends StatelessWidget {
  const ProviderContextApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginState(),
      child: const SelectionArea(
        child: RealWorldApp(),
      ),
    );
  }
}
