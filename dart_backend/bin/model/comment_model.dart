import 'dart:convert';

import 'user_model.dart';

class Comment {
  late String id;
  late String slug;
  late String body;
  late DateTime createdAt;
  late DateTime updatedAt;
  late UserProfile author;

  Comment(this.id, this.slug, this.body, this.createdAt, this.updatedAt, this.author);

  String toJson() {
    return '''
    {"comment": 
      ${toJsonItem()}
    }
    ''';
  }

  String toJsonItem() {
    return '''
    { "id": ${jsonEncode(id)},
      "slug": ${jsonEncode(slug)},
      "body": ${jsonEncode(body)},
      "createdAt": ${jsonEncode(createdAt.toIso8601String())},
      "updatedAt": ${jsonEncode(updatedAt.toIso8601String())},
      "author": {
            "username": ${jsonEncode(author.username)},
            "following": ${jsonEncode(author.following)},
            "bio": ${jsonEncode(author.bio)},
            "image": ${jsonEncode(author.image)}
      }
    }
    ''';
  }

  Comment.fromMap(Map<String, dynamic> data) {
    id = data['id'];
    slug = data['slug'];
    body = data['body'];
    createdAt = data['createdAt'];
    updatedAt = data['updatedAt'];
    author = UserProfile.fromMap(data['author']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'slug': slug,
      'body': body,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'author': author.toMap(),
    };
  }
}

class NewComment {
  late String body;

  NewComment(this.body);

  NewComment.fromJson(data) {
    body = data['body'];
  }
}

class CommentList {
  final commentList = <Comment>[];

  String toJson() {
    return '''
    {
      "comments": [${commentList.map((e) => e.toJsonItem()).join(',')}],
      "commentsCount": ${commentList.length}
    }
    ''';
  }
}
