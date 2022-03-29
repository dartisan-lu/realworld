import 'user_model.dart';

class Comment {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String body;
  final Profile author;

  Comment(
      {required this.id, required this.createdAt, required this.updatedAt, required this.body, required this.author});

  factory Comment.fromJson(Map<dynamic, dynamic> json) {
    return Comment(
        id: json['id'],
        createdAt: json['createdAt'] != null ? DateTime.parse((json['createdAt'] as String)) : DateTime.now(),
        updatedAt: json['updatedAt'] != null ? DateTime.parse((json['updatedAt'] as String)) : DateTime.now(),
        body: json['body'] as String,
        author: Profile.fromJson(json['author']));
  }
}
