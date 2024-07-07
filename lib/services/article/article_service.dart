import 'dart:convert';
import 'package:article_mobile_app/model/article.dart';
import 'package:article_mobile_app/utils/configs/api_config.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ArticleService {
 static String baseUrl = ApiConfig.baseUrl;

  Future<List<Article>> fetchArticles() async {
    try {
      final String url = '$baseUrl/article';
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? accessToken = prefs.getString('accessToken');

      if (accessToken == null) {
        throw Exception('Access token not found');
      }

      final response = await http.get(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
          "Authorization": "Bearer $accessToken",
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseJson = jsonDecode(response.body);
        List<Article> articles = (responseJson['data'] as List)
            .map((article) => Article.fromJson(article))
            .toList();
        return articles;
      } else {
        throw Exception('Failed to load articles');
      }
    } catch (err) {
      print(err);
      throw Exception('Failed to connect to the server');
    }
  }
}