import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../config/system_values.dart' as config;

class TagService {
  final http.Client client;

  TagService(this.client);

  Future<List<String>> fetchPopularTags() async {
    final response = await client.get(Uri.parse('${config.sysValRoot}/tags'));
    return parseTags(response.body);
  }

  List<String> parseTags(dynamic responseBody) {
    if (responseBody.isNotEmpty) {
      var jsonObj = jsonDecode(responseBody);
      List<String> rtn = (jsonObj['tags'] as List<dynamic>).map((e) => (e as String)).toList();
      return rtn;
    } else {
      return List.empty();
    }
  }
}
