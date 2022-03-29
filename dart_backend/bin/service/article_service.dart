import 'package:mongo_dart/mongo_dart.dart';

import '../config/mongo_config.dart';
import '../exception/application_exceptions.dart';
import '../exception/security_exceptions.dart';
import '../model/article_model.dart';
import 'user_service.dart';

class ArticleService {
  final Db db;
  final UserService userService;

  ArticleService(this.db, this.userService);

  Future<ArticleList> getArticles(
      String? tag, String? author, String? favorited, String? currentUser, int limit, int offset) async {
    var col = db.collection(MongoCollection.article);
    SelectorBuilder? criteria;
    if (tag != null) criteria = (where.oneFrom('tag', [tag]));
    if (author != null) criteria = (where.match('author', author));
    if (favorited != null) criteria = (where.match('favorited', favorited));
    var check = await col
        .modernFind(selector: criteria, limit: limit > 0 ? limit : null, skip: offset > 0 ? offset : null)
        .toList();

    var rtn = ArticleList();
    for (var article in check) {
      rtn.articleList.add(Article.fromMap(article));
    }
    return rtn;
  }

  Future<Article> createArticle(NewArticle newArticle, String? currentUser) async {
    if (currentUser == null) {
      throw UnauthorizedException('User not logged in');
    }
    var profile = await userService.getUserProfile(currentUser);
    var now = DateTime.now();
    var article = Article(
        slug: slugify(newArticle.title),
        title: newArticle.title,
        description: newArticle.description,
        body: newArticle.body,
        tagList: newArticle.tagList,
        createdAt: now,
        updatedAt: now,
        favorited: false,
        favoritesCount: 0,
        author: profile);

    var col = db.collection(MongoCollection.article);
    await col.insert(article.toMap());

    return article;
  }

  Future<ArticleList> getArticleFeed(String? currentUser, int limit, int offset) async {
    if (currentUser == null) {
      throw UnauthorizedException('User not logged in');
    }

    var following = await userService.following(currentUser);
    var col = db.collection(MongoCollection.article);
    var check = await col
        .modernFind(
            selector: where.nin('author', following), limit: limit > 0 ? limit : null, skip: offset > 0 ? offset : null)
        .toList();

    var rtn = ArticleList();
    for (var article in check) {
      rtn.articleList.add(Article.fromMap(article));
    }
    return rtn;
  }

  Future<Article> getArticle(String slug, String? currentUser) async {
    var col = db.collection(MongoCollection.article);
    var check = await col.find(where.eq('slug', slug)).toList();
    if (check.isEmpty) {
      throw ApplicationException('Unknown article: ' + slug);
    }
    var article = check.first;

    return Article.fromMap(article);
  }

  Future<Article> updateArticle(Map<String, dynamic> articleResponse, String slug, String? currentUser) async {
    if (currentUser == null) {
      throw UnauthorizedException('User not logged in');
    }

    var col = db.collection(MongoCollection.article);
    var check = await col.find(where.eq('slug', slug)).toList();
    if (check.isEmpty) {
      throw ApplicationException('Unknown article: ' + slug);
    }
    var article = check.first;

    if (currentUser != article['author']?['username']) {
      throw UnauthorizedException('User is now Author of the article');
    }

    if (articleResponse.containsKey('title')) article['title'] = articleResponse['title'];
    if (articleResponse.containsKey('description')) article['description'] = articleResponse['description'];
    if (articleResponse.containsKey('body')) article['body'] = articleResponse['body'];

    article['updatedAt'] = DateTime.now();

    await col.update(where.eq('slug', slug), article);

    return Article.fromMap(article);
  }

  Future<void> deleteArticle(String slug, String? currentUser) async {
    if (currentUser == null) {
      throw UnauthorizedException('User not logged in');
    }

    var col = db.collection(MongoCollection.article);
    var check = await col.find(where.eq('slug', slug)).toList();
    if (check.isEmpty) {
      throw ApplicationException('Unknown article: ' + slug);
    }
    var article = Map<String, dynamic>.from(check.first);

    if (currentUser != article['author']?['username']) {
      throw UnauthorizedException('User is now Author of the article');
    }

    await col.deleteOne(where.eq('slug', slug));
  }

  String slugify(String text) {
    var rtn = text.replaceAll(RegExp(r'[^\w\s]+'), '').replaceAll(' ', '_');
    return '${rtn}_${DateTime.now().millisecond}';
  }
}
