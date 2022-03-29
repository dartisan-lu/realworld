import 'package:flutter/material.dart';

import '/ui/widget/feed_tab_panel.dart';
import '../bars/conduit_banner.dart';
import '../bars/footer_bar.dart';
import '../bars/menu_bar.dart';

class WelcomeScaffold extends StatelessWidget {
  const WelcomeScaffold({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const MenuBar()),
      body: Column(children: const [
        ConduitBanner(),
        FeedTabPanel(),
        FooterBar(),
      ]),
    );
  }
}
