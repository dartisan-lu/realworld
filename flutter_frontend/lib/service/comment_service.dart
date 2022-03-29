import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../config/system_values.dart' as config;
import '../model/comment_model.dart';

class CommentService {
  final http.Client client;

  CommentService(this.client);

  Future<List<Comment>> fetchComments(String id) async {
    final response = await client.get(Uri.parse('${config.sysValRoot}/articles/$id/comments'));
    return parseComments(response.body);
  }

  List<Comment> parseComments(dynamic responseBody) {
    if (responseBody.isNotEmpty) {
      var jsonObj = jsonDecode(responseBody);
      var comments = <Comment>[];
      jsonObj['comments'].map((tagJson) => Comment.fromJson(tagJson)).forEach((e) => comments.add((e as Comment)));
      return comments;
    } else {
      return List.empty();
    }
  }

  Future<void> createComment(String comment, String slug, String token) async {
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'authorization': 'token $token'
    };
    dynamic body = {
      'comment': {'body': comment}
    };
    var encode = jsonEncode(body);
    await client.post(Uri.parse('${config.sysValRoot}/articles/${slug}/comments'), body: encode, headers: headers);
  }
}
