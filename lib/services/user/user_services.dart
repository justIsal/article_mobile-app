import 'dart:convert';
import 'package:article_mobile_app/model/user.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:article_mobile_app/utils/configs/api_config.dart';

class UserProvider {
  static String baseUrl = ApiConfig.baseUrl;

  Future<String> updateUser({
    required String id,
    required String name,
    required String email,
  }) async {
    try {
      final String url = '$baseUrl/user/$id/update';
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? accessToken = prefs.getString('accessToken');
      if (accessToken == null) {
        throw Exception('Access token not found');
      }

      final response = await http.put(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
          "Authorization": "Bearer $accessToken",
        },
        body: jsonEncode({
          "name": name,
          "email": email,
        }),
      );
      print(response.body);
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        final message = jsonResponse['message'];
        print('fdfdfdfkkg');
        print(message);
        return message;
      } else {
        throw Exception('Failed to update user');
      }
    } catch (err) {
      print(err);
      throw Exception('Failed to connect to the server');
    }
  }
}
