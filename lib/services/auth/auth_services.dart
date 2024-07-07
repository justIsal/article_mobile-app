import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:article_mobile_app/model/auth.dart';
import 'package:article_mobile_app/utils/configs/api_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthServices {
  static String baseUrl = ApiConfig.baseUrl;

  Future<AuthModel> login(
      {required String email, required String password}) async {
    try {
      final String url = '$baseUrl/user/signin';
      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
        },
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseJson = jsonDecode(response.body);
        print(response.body);

        if (responseJson['message'] == 'success') {
          // Save accessToken to SharedPreferences
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('accessToken', responseJson['token']);
          final user = {
            "id": responseJson['id'],
            "name": responseJson['name'],
            "email": responseJson['email'],
          };
          await prefs.setString('user', jsonEncode(user));
          print('Token saved: ${responseJson['token']}');
        }

        return AuthModel.fromJson(responseJson);
      } else {
        return AuthModel(
            status: "failed",
            message: "Login failed with status code: ${response.statusCode}");
      }
    } catch (err) {
      print(err);
      return AuthModel(
          status: "failed", message: "Tidak dapat terhubung ke server");
    }
  }

  Future<AuthModel> register(
      {required String name,
      required String email,
      required String password}) async {
    try {
      final String url = '$baseUrl/user/signup';
      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
        },
        body: jsonEncode({
          "name": name,
          "email": email,
          "password": password,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseJson = jsonDecode(response.body);
        print(response.body);

        if (responseJson['message'] == 'success') {
          // Save accessToken to SharedPreferences
          final user = {
            "id": responseJson['id'],
            "name": responseJson['name'],
            "email": responseJson['email'],
          };
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('accessToken', responseJson['token']);
          await prefs.setString('user', jsonEncode(user));
          print('Token saved: ${responseJson['token']}');
        }

        return AuthModel.fromJson(responseJson);
      } else {
        return AuthModel(
            status: "failed",
            message: "Login failed with status code: ${response.statusCode}");
      }
    } catch (err) {
      print(err);
      return AuthModel(
          status: "failed", message: "Tidak dapat terhubung ke server");
    }
  }

  Future<void> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('accessToken');
    print('Logout berhasil');
  }
}
