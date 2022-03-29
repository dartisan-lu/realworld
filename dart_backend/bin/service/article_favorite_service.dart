import 'package:mongo_dart/mongo_dart.dart';

import '../config/mongo_config.dart';
import '../exception/security_exceptions.dart';
import '../exception/user_exceptions.dart';

class ArticleFavoriteService {
  final Db db;

  ArticleFavoriteService(this.db);

  favoriteArticle(String slug, String? currentUser) async {
    if (currentUser == null) {
      throw UnauthorizedException('User not logged in');
    }

    var col = db.collection(MongoCollection.user);
    var check = await col.find(where.eq('username', currentUser)).toList();
    if (check.isEmpty) {
      throw UserLoginException('Unknown user');
    }

    var user = check.first;
    if (user['favorite'] == null) {
      user['favorite'] = [slug];
    } else {
      (user['favorite'] as List).add(slug);
    }

    await col.update({"username": currentUser}, user);
  }

  unfavoriteArticle(String slug, String? currentUser) async {
    if (currentUser == null) {
      throw UnauthorizedException('User not logged in');
    }

    var col = db.collection(MongoCollection.user);
    var check = await col.find(where.eq('username', currentUser)).toList();
    if (check.isEmpty) {
      throw UserLoginException('Unknown user');
    }

    var user = check.first;
    if (user['favorite'] != null) {
      (user['favorite'] as List).remove(slug);
    }

    await col.update({"username": currentUser}, user);
  }
}
