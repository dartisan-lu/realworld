import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../theme/app_theme.dart';

class FooterBar extends StatelessWidget {
  const FooterBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Theme.of(context).colorScheme.rwWhite,
        child: Container(
            margin: const EdgeInsets.fromLTRB(100, 20, 100, 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                    onTap: () => launch('https://angular-realworld.netlify.app/'),
                    child: Text(
                      'conduit',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 20,
                      ),
                    )),
                Text(
                  ' © 2021. An interactive learning project from ',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.rwLightGray,
                    fontSize: 14,
                  ),
                ),
                InkWell(
                    onTap: () => launch('https://thinkster.io/'),
                    child: Text(
                      'Thinkster',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 14,
                      ),
                    )),
                Text(
                  '. Code licensed under MIT.',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.rwLightGray,
                    fontSize: 14,
                  ),
                ),
              ],
            )));
  }
}
