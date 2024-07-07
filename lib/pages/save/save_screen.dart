import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:article_mobile_app/model/article.dart';
import 'package:article_mobile_app/pages/home/card_list.dart';
import 'package:article_mobile_app/services/article/article_service.dart';

class SaveScreen extends StatefulWidget {
  const SaveScreen({super.key});

  @override
  _SaveScreenState createState() => _SaveScreenState();
}

class _SaveScreenState extends State<SaveScreen> {
  late Future<List<Article>> _articlesFuture;
  final List<Article> _savedArticles = [];

  @override
  void initState() {
    super.initState();
    _loadSavedArticles();
  }

  Future<void> _loadSavedArticles() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Article> articles = await ArticleService().fetchArticles();
    
    setState(() {
      _savedArticles.clear();
      for (Article article in articles) {
        bool isFavorite = prefs.getBool('favorite_${article.id}') ?? false;
        if (isFavorite) {
          _savedArticles.add(article);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.blue,
        title: Text('Save'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                ),
              ),
              SizedBox(height: 16.0),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: _savedArticles.length,
                itemBuilder: (context, index) {
                  Article article = _savedArticles[index];
                  return CardItem(
                    image: article.imgUrl,
                    content: article.content,
                    id: article.id.toString(), // Assuming id is a String or can be converted to String
                    status: article.status,
                    tag: article.status,
                    title: article.title,
                    author: article.author,
                    date: article.date,
                    category: article.category,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
