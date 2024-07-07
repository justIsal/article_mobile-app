import 'package:article_mobile_app/model/article.dart';
import 'package:article_mobile_app/services/article/article_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:article_mobile_app/pages/articles/articles_detail_screen.dart';

class ItemListView extends StatelessWidget {
  final String categoryd;

  ItemListView(this.categoryd);

  @override
  Widget build(BuildContext context) {
    print('Memanggil ItemListView dengan categoryd: $categoryd');
    return FutureBuilder<List<Article>>(
      future: ArticleService().fetchArticles(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No articles found'));
        } else {
          // snapshot.data!.forEach((item) => print(item.category));
          print('Memanggil ItemListView dengan categoryd: $categoryd');
          List<Article> articles = snapshot.data!;
          if (categoryd != 'All') {
            articles = articles
                .where((article) => article.category == categoryd)
                .toList();
          }
          return ListView.builder(
            itemCount: articles.length,
            itemBuilder: (context, index) {
              final article = articles[index];
              return ListTile(
                leading: Image.network(
                  article.imgUrl,
                  width: 60,
                  height: 60,
                ),
                title: Text(
                  article.title,
                  style: TextStyle(
                    color: Color(0xFF0A73D3),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // subtitle: Column(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     Text(article.content),
                //     SizedBox(height: 4),
                //     Text(
                //       article.date,
                //       style: TextStyle(color: Colors.grey, fontSize: 12),
                //     ),
                //   ],
                // ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ArticleDetailScreen(article),
                    ),
                  );
                },
              );
            },
          );
        }
      },
    );
  }
}
