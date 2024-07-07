// models/comment.dart
class Comment {
  final String id;

  Comment({
    required this.id,
  });

  factory Comment.fromJson(String id) {
    return Comment(
      id: id,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
    };
  }
}
