import 'user_model.dart';

class Article {
  final String slug;
  final String title;
  final String description;
  final String body;
  final List<String> tagList;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool favorited;
  final int favoritesCount;
  final Profile author;

  Article(
      {required this.slug,
      required this.title,
      required this.description,
      required this.body,
      required this.tagList,
      required this.createdAt,
      required this.updatedAt,
      required this.favorited,
      required this.favoritesCount,
      required this.author});

  factory Article.fromJson(Map<dynamic, dynamic> json) {
    return Article(
        slug: json['slug'] as String,
        title: json['title'] as String,
        description: json['description'] as String,
        body: json['body'] as String,
        tagList: (json['tagList'] as List<dynamic>).map((e) => e as String).toList(),
        createdAt: json['createdAt'] != null ? DateTime.parse((json['createdAt'] as String)) : DateTime.now(),
        updatedAt: json['updatedAt'] != null ? DateTime.parse((json['updatedAt'] as String)) : DateTime.now(),
        favorited: json['favorited'] as bool,
        favoritesCount: json['favoritesCount'] as int,
        author: Profile.fromJson(json['author']));
  }
}

class NewArticle {
  late String title;
  late String description;
  late String body;
  late List<String> tagList;

  NewArticle({required this.title, required this.description, required this.body, required this.tagList});

  Map<String, dynamic> toJson() {
    var data = {
      'article': {'title': title, 'description': description, 'body': body, 'tagList': tagList}
    };
    return data;
  }
}

class ArticleListResponse {
  final List<Article> articles;
  final int articlesCount;

  ArticleListResponse({required this.articles, required this.articlesCount});

  factory ArticleListResponse.fromJson(dynamic json) {
    var articles = <Article>[];
    json['articles'].map((tagJson) => Article.fromJson(tagJson)).forEach((e) => articles.add((e as Article)));

    return ArticleListResponse(articles: articles, articlesCount: json['articlesCount'] as int);
  }
}
