// models/article.dart
import 'comment.dart';

class Article {
  final String id;
  final String title;
  final String imgUrl;
  final String author;
  final String status;
  final String content;
  final List<String>? tag;
  final String date;
  final String category;
  final List<Comment>? comments;

  Article({
    required this.id,
    required this.title,
    required this.imgUrl,
    required this.author,
    required this.status,
    required this.content,
    this.tag,
    required this.date,
    required this.category,
    this.comments,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    var commentsList = json['comments'] as List;
    List<Comment> comments =
        commentsList.map((i) => Comment.fromJson(i)).toList();

    return Article(
      id: json['_id'],
      title: json['title'],
      imgUrl: json['imgUrl'],
      author: json['author'],
      status: json['status'],
      content: json['content'],
      tag: List<String>.from(json['tag']),
      date: json['date'],
      category: json['category'],
      comments: comments,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'imgUrl': imgUrl,
      'author': author,
      'status': status,
      'content': content,
      'tag': tag,
      'date': date,
      'category': category,
      'comments': comments?.map((comment) => comment.toJson()).toList(),
    };
  }
}

class ApiResponse {
  final String message;
  final List<Article> data;

  ApiResponse({
    required this.message,
    required this.data,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    var articlesList = json['data'] as List;
    List<Article> articles =
        articlesList.map((i) => Article.fromJson(i)).toList();

    return ApiResponse(
      message: json['message'],
      data: articles,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'data': data.map((article) => article.toJson()).toList(),
    };
  }
}
