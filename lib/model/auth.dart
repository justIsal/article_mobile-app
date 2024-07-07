class AuthModel {
  final String status;
  final String message;
  final String? token;

  AuthModel({
    required this.status,
    required this.message,
    this.token,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      status: json.containsKey('token') ? 'success' : 'failed',
      message: json['message'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'token': token,
    };
  }
}