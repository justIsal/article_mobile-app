class UserModel {
  final String id;
  final String name;
  final String email;
  final List<String>? savedArticles;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.savedArticles,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      savedArticles: json['savedArticles'] != null
          ? List<String>.from(json['savedArticles'])
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'email': email,
      'savedArticles': savedArticles ?? [],
    };
  }
}
