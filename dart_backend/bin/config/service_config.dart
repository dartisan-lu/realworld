import 'package:mongo_dart/mongo_dart.dart';

import '../service/article_favorite_service.dart';
import '../service/article_service.dart';
import '../service/comment_service.dart';
import '../service/tag_service.dart';
import '../service/user_service.dart';
import 'environment_config.dart';

class ServiceConfig {
  late final UserService userService;
  late final TagService tagService;
  late final ArticleService articleService;
  late final ArticleFavoriteService articleFavoriteService;
  late final CommentService commentService;

  ServiceConfig(Db db, EnvironmentConfig environmentConfig) {
    userService = UserService(db, environmentConfig);
    tagService = TagService(db);
    articleService = ArticleService(db, userService);
    articleFavoriteService = ArticleFavoriteService(db);
    commentService = CommentService(db, userService);
  }
}
