import 'dart:convert';

import 'user_model.dart';

class Article {
  late String slug;
  late String title;
  late String description;
  late String body;
  late List<String> tagList;
  late DateTime createdAt;
  late DateTime updatedAt;
  late bool favorited;
  late int favoritesCount;
  late UserProfile author;

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

  Article.fromMap(Map<String, dynamic> data) {
    slug = data['slug'];
    title = data['title'];
    description = data['description'];
    body = data['body'];
    tagList = List<String>.from(data['tagList']);
    createdAt = data['createdAt'];
    updatedAt = data['updatedAt'];
    favorited = data['favorited'];
    favoritesCount = data['favoritesCount'];
    author = UserProfile.fromMap(data['author']);
  }

  String toJson() {
    return '''
    {"article": 
      ${toJsonItem()}
    }
    ''';
  }

  String toJsonItem() {
    return '''
    {
      "slug": ${jsonEncode(slug)},
      "title": ${jsonEncode(title)},
      "description": ${jsonEncode(description)},
      "body": ${jsonEncode(body)},
      "tagList": ${jsonEncode(tagList)},
      "createdAt": ${jsonEncode(createdAt.toIso8601String())},
      "updatedAt": ${jsonEncode(updatedAt.toIso8601String())},
      "favorited": ${jsonEncode(favorited)},
      "favoritesCount": ${jsonEncode(favoritesCount)},
      "author": {
            "username": ${jsonEncode(author.username)},
            "following": ${jsonEncode(author.following)},
            "bio": ${jsonEncode(author.bio)},
            "image": ${jsonEncode(author.image)}
      }
    }
    ''';
  }

  Map<String, dynamic> toMap() {
    return {
      'slug': slug,
      'title': title,
      'description': description,
      'body': body,
      'tagList': tagList,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'favorited': favorited,
      'favoritesCount': favoritesCount,
      'author': author.toMap(),
    };
  }
}

class NewArticle {
  late String title;
  late String description;
  late String body;
  late List<String> tagList;

  NewArticle({required this.title, required this.description, required this.body, required this.tagList});

  NewArticle.fromMap(data) {
    title = data['title'];
    description = data['description'];
    body = data['body'];
    tagList = List<String>.from(data['tagList']);
  }
}

class ArticleList {
  final articleList = <Article>[];

  String toJson() {
    return '''
    {
      "articles": [${articleList.map((e) => e.toJsonItem()).join(',')}],
      "articlesCount": ${articleList.length}
    }
    ''';
  }
}
