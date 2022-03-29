import 'package:mongo_dart/mongo_dart.dart';

import '../config/mongo_config.dart';
import '../exception/application_exceptions.dart';
import '../exception/security_exceptions.dart';
import '../model/comment_model.dart';
import 'user_service.dart';

class CommentService {
  final Db db;
  final UserService userService;

  CommentService(this.db, this.userService);

  /// Delete Comment
  Future<void> deleteComment(String slug, String id, String? currentUser) async {
    if (currentUser == null) {
      throw UnauthorizedException('User not logged in');
    }

    var col = db.collection(MongoCollection.comment);
    var check = await col.find(where.eq('id', id)).toList();
    if (check.isEmpty) {
      throw ApplicationException('Unknown comment id: ' + id);
    }
    var comment = Map<String, dynamic>.from(check.first);

    if (currentUser != comment['author']?['username']) {
      throw UnauthorizedException('User is now Author of the comment');
    }

    await col.deleteOne(where.eq('id', id));
  }

  /// Get Comments
  Future<CommentList> getComments(String slug) async {
    var col = db.collection(MongoCollection.comment);
    var check = await col.find(where.eq('slug', slug)).toList();
    var rtn = CommentList();
    if (check.isNotEmpty) {
      for (var comment in check) {
        rtn.commentList.add(Comment.fromMap(comment));
      }
      return rtn;
    } else {
      throw ApplicationException('Article not exists');
    }
  }

  /// Create a Comment
  Future<Comment> createComment(NewComment newComment, String slug, String? currentUser) async {
    if (currentUser == null) {
      throw UnauthorizedException('User not logged in');
    }
    var uuid = Uuid();
    var profile = await userService.getUserProfile(currentUser);
    var now = DateTime.now();
    var comment = Comment(uuid.v1(), slug, newComment.body, now, now, profile);
    var col = db.collection(MongoCollection.comment);
    await col.insert(comment.toMap());
    return comment;
  }
}
