import 'package:flutter/material.dart';

import '../../../model/user_model.dart';

class MenuBarUser extends StatelessWidget {
  final User data;

  const MenuBarUser(this.data, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
          child: CircleAvatar(
            radius: 10,
            backgroundImage: NetworkImage(data.image),
          )),
      Wrap(direction: Axis.vertical, children: [
        Text(
          data.username,
          style: const TextStyle(
            color: Color(0xdd00004d),
            fontSize: 16,
          ),
        )
      ]),
    ]);
  }
}
