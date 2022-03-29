import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../service/tag_service.dart';
import '../theme/app_theme.dart';

class PopularTags extends StatelessWidget {
  final tagService = TagService(http.Client());

  PopularTags({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
        future: tagService.fetchPopularTags(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isNotEmpty) {
              return Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.rwWhite,
                ),
                child: Wrap(
                  direction: Axis.horizontal,
                  spacing: 20,
                  runSpacing: 10,
                  children: [
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Popular Tags',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    ListView(primary: true, shrinkWrap: true, children: <Widget>[
                      Wrap(
                          spacing: 5,
                          runSpacing: 5,
                          children: List<Widget>.generate(snapshot.data!.length, // place the length of the array here
                              (int index) {
                            return Chip(
                                label: Text(
                                  snapshot.data![index],
                                  style: const TextStyle(color: Colors.white),
                                ),
                                backgroundColor: Theme.of(context).colorScheme.rwDarkGray);
                          }).toList())
                    ]),
                  ],
                ),
              );
            } else {
              return const Text('No tags are here... yet.');
            }
          }
          return const Text('Loading articles...');
        });
  }
}
