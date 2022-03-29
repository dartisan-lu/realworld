import 'dart:convert';

class TagList {
  final tagList = <String>[];

  String toJson() {
    return '''
    {
      "tags": ${jsonEncode(tagList)}
    }
    ''';
  }
}
