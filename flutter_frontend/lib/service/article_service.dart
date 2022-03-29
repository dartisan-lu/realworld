import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../config/system_values.dart' as config;
import '../model/article_model.dart';

class ArticleService {
  final http.Client client;

  ArticleService(this.client);

  Future<Article?> fetchArticle(String id) async {
    final response = await client.get(Uri.parse('${config.sysValRoot}/articles/$id'));
    return parseArticle(response.body);
  }

  Future<List<Article>> fetchArticles() async {
    final response = await client.get(Uri.parse('${config.sysValRoot}/articles'));
    return parseArticles(response.body);
  }

  Future<void> createArticle(NewArticle article, String? token, Function success, Function error) async {
    if (token == null) {
      error();
      return;
    }
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'authorization': 'token $token'
    };

    var encode = jsonEncode(article.toJson());
    final response = await client.post(Uri.parse('${config.sysValRoot}/articles'), body: encode, headers: headers);
    if (response.statusCode == 200) {
      success();
    } else {
      error();
    }
  }

  Article? parseArticle(dynamic responseBody) {
    if (responseBody.isNotEmpty) {
      var jsonObj = jsonDecode(responseBody);
      return Article.fromJson(jsonObj['article']);
    }
    return null;
  }

  List<Article> parseArticles(dynamic responseBody) {
    if (responseBody.isNotEmpty) {
      var jsonObj = jsonDecode(responseBody);
      var articleListResponse = ArticleListResponse.fromJson(jsonObj);
      return articleListResponse.articles;
    } else {
      return List.empty();
    }
  }
}
