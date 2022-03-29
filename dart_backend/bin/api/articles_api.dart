import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../config/system_values.dart';
import '../exception/security_exceptions.dart';
import '../model/article_model.dart';
import '../model/comment_model.dart';
import '../model/error_model.dart';
import '../service/article_favorite_service.dart';
import '../service/article_service.dart';
import '../service/comment_service.dart';

class ArticlesApi {
  ArticleService articleService;
  ArticleFavoriteService articleFavoriteService;
  CommentService commentService;

  ArticlesApi(this.articleService, this.articleFavoriteService, this.commentService);

  /// Get Articles
  Future<Response> getArticles(Request request) async {
    try {
      final currentUser = request.headers[sysValCurrentUser];
      final tag = request.url.queryParameters['tag'];
      final author = request.url.queryParameters['author'];
      final favorited = request.url.queryParameters['favorited'];
      final limit =
          request.url.queryParameters['limit'] == null ? 20 : int.parse(request.url.queryParameters['limit']!);
      final offset =
          request.url.queryParameters['offset'] == null ? 0 : int.parse(request.url.queryParameters['offset']!);

      var json = await articleService.getArticles(tag, author, favorited, currentUser, limit, offset);
      return Response(200, body: json.toJson());
    } catch (error) {
      print(error);
      return Response(422);
    }
  }

  /// Create Articles
  Future<Response> createArticle(Request request) async {
    final body = await request.readAsString();
    final Map<String, dynamic> data = json.decode(body);

    var errors = validateNewArticle(data['article']);
    if (errors.isNotEmpty()) {
      return Response(422, body: errors.toJson());
    }

    try {
      final currentUser = request.headers[sysValCurrentUser];
      final newArticle = NewArticle.fromMap(data['article']);
      var json = await articleService.createArticle(newArticle, currentUser);
      return Response(200, body: json.toJson());
    } on UnauthorizedException catch (error) {
      return Response(401, body: error.report.toJson());
    } catch (error) {
      print(error);
      return Response(422);
    }
  }

  /// Get Article Feed
  Future<Response> getArticleFeed(Request request) async {
    try {
      final currentUser = request.headers[sysValCurrentUser];
      final limit =
          request.url.queryParameters['limit'] == null ? 20 : int.parse(request.url.queryParameters['limit']!);
      final offset =
          request.url.queryParameters['offset'] == null ? 0 : int.parse(request.url.queryParameters['offset']!);

      var json = await articleService.getArticleFeed(currentUser, limit, offset);
      return Response(200, body: json.toJson());
    } catch (error) {
      print(error);
      return Response(422);
    }
  }

  /// Get Article
  Future<Response> getArticle(Request request) async {
    try {
      final currentUser = request.headers[sysValCurrentUser];
      final slug = request.params['slug'];
      if (slug == null) {
        var errors = ErrorReport.singleError('slug is required');
        return Response(422, body: errors.toJson());
      }

      var json = await articleService.getArticle(slug, currentUser);
      return Response(200, body: json.toJson());
    } catch (error) {
      print(error);
      return Response(422);
    }
  }

  /// Update Article
  Future<Response> updateArticle(Request request) async {
    final body = await request.readAsString();
    final Map<String, dynamic> data = json.decode(body);

    var errors = validateUpdateArticle(data['article']);
    if (errors.isNotEmpty()) {
      return Response(422, body: errors.toJson());
    }

    try {
      final currentUser = request.headers[sysValCurrentUser];
      final slug = request.params['slug'];
      if (slug == null) {
        var errors = ErrorReport.singleError('slug is required');
        return Response(422, body: errors.toJson());
      }
      var json = await articleService.updateArticle(data['article'], slug, currentUser);
      return Response(200, body: json.toJson());
    } on UnauthorizedException catch (error) {
      return Response(401, body: error.report.toJson());
    } catch (error) {
      print(error);
      return Response(422);
    }
  }

  /// Delete Article
  Future<Response> deleteArticle(Request request) async {
    try {
      final currentUser = request.headers[sysValCurrentUser];
      final slug = request.params['slug'];
      if (slug == null) {
        var errors = ErrorReport.singleError('slug is required');
        return Response(422, body: errors.toJson());
      }
      await articleService.deleteArticle(slug, currentUser);
      return Response(200);
    } on UnauthorizedException catch (error) {
      return Response(401, body: error.report.toJson());
    } catch (error) {
      print(error);
      return Response(422);
    }
  }

  /// Get Comments of Article
  Future<Response> getCommentsOfArticle(Request request) async {
    try {
      final slug = request.params['slug'];
      if (slug == null) {
        var errors = ErrorReport.singleError('slug is required');
        return Response(422, body: errors.toJson());
      }

      var json = await commentService.getComments(slug);
      return Response(200, body: json.toJson());
    } catch (error) {
      print(error);
      return Response(422);
    }
  }

  /// Add Comment to Article
  Future<Response> addCommentToArticle(Request request) async {
    final body = await request.readAsString();
    final Map<String, dynamic> data = json.decode(body);
    final currentUser = request.headers[sysValCurrentUser];

    var errors = validateNewComment(data['comment']);
    if (errors.isNotEmpty()) {
      return Response(422, body: errors.toJson());
    }

    try {
      final slug = request.params['slug'];
      if (slug == null) {
        var errors = ErrorReport.singleError('slug is required');
        return Response(422, body: errors.toJson());
      }
      var json = await commentService.createComment(NewComment.fromJson(data['comment']), slug, currentUser);
      return Response(200, body: json.toJson());
    } on UnauthorizedException catch (error) {
      return Response(401, body: error.report.toJson());
    } catch (error) {
      print(error);
      return Response(422);
    }
  }

  /// Delete Comment of Article
  Response deleteCommentOfArticle(Request request) {
    try {
      final currentUser = request.headers[sysValCurrentUser];
      final slug = request.params['slug'];
      if (slug == null) {
        var errors = ErrorReport.singleError('slug is required');
        return Response(422, body: errors.toJson());
      }
      final id = request.params['id'];
      if (id == null) {
        var errors = ErrorReport.singleError('comment id is required');
        return Response(422, body: errors.toJson());
      }
      commentService.deleteComment(slug, id, currentUser);
      return Response(200);
    } on UnauthorizedException catch (error) {
      return Response(401, body: error.report.toJson());
    } catch (error) {
      print(error);
      return Response(422);
    }
  }

  /// favorite Article
  Future<Response> favoriteArticle(Request request) async {
    try {
      final currentUser = request.headers[sysValCurrentUser];
      final slug = request.params['slug'];
      if (slug == null) {
        var errors = ErrorReport.singleError('slug is required');
        return Response(422, body: errors.toJson());
      }
      var json = await articleFavoriteService.favoriteArticle(slug, currentUser);
      return Response(200, body: json.toJson());
    } on UnauthorizedException catch (error) {
      return Response(401, body: error.report.toJson());
    } catch (error) {
      print(error);
      return Response(422);
    }
  }

  /// unfavorite Article
  Future<Response> unfavoriteArticle(Request request) async {
    try {
      final currentUser = request.headers[sysValCurrentUser];
      final slug = request.params['slug'];
      if (slug == null) {
        var errors = ErrorReport.singleError('slug is required');
        return Response(422, body: errors.toJson());
      }
      var json = await articleFavoriteService.unfavoriteArticle(slug, currentUser);
      return Response(200, body: json.toJson());
    } on UnauthorizedException catch (error) {
      return Response(401, body: error.report.toJson());
    } catch (error) {
      print(error);
      return Response(422);
    }
  }

  /// Handler
  Handler get handler {
    final _handler = Router()
      ..get('/', (Request request) => getArticles(request))
      ..post('/', (Request request) => createArticle(request))
      ..get('/feed', (Request request) => getArticleFeed(request))
      ..get('/<slug>', (Request request) => getArticle(request))
      ..put('/<slug>', (Request request) => updateArticle(request))
      ..delete('/<slug>', (Request request) => deleteArticle(request))
      ..get('/<slug>/comments', (Request request) => getCommentsOfArticle(request))
      ..post('/<slug>/comments', (Request request) => addCommentToArticle(request))
      ..delete('/<slug>/comments/<id>', (Request request) => deleteCommentOfArticle(request))
      ..post('/<slug>/favorite', (Request request) => favoriteArticle(request))
      ..delete('/<slug>/favorite', (Request request) => unfavoriteArticle(request));
    return _handler;
  }

  /// Validate New Article
  ErrorReport validateNewArticle(dynamic article) {
    if (article == null) {
      return ErrorReport.singleError('article is required');
    }
    var report = ErrorReport();

    if (article['title'] == null) {
      report.addError('title is required');
    }
    if (article['description'] == null) {
      report.addError('description is required');
    }
    if (article['body'] == null) {
      report.addError('body is required');
    }
    return report;
  }

  /// Validate New Article
  ErrorReport validateUpdateArticle(dynamic article) {
    if (article == null) {
      return ErrorReport.singleError('article is required');
    }
    var report = ErrorReport();

    if (article['title'] == null && article['description'] == null && article['body'] == null) {
      report.addError('At least one element [title,description,body] is required');
    }
    return report;
  }

  /// Validate New Comment
  ErrorReport validateNewComment(dynamic comment) {
    if (comment == null) {
      return ErrorReport.singleError('comment is required');
    }
    var report = ErrorReport();

    if (comment['body'] == null) {
      report.addError('body is required');
    }
    return report;
  }
}
