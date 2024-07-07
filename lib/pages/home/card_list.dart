import 'package:flutter/material.dart';
import 'package:article_mobile_app/model/article.dart';
import 'package:article_mobile_app/pages/articles/articles_detail_screen.dart';
import 'package:intl/intl.dart';

class CardItem extends StatelessWidget {
  final String image;
  final String title;
  final String author;
  final String date;
  final String category;
  final String id;
  final String tag;
  final String status;
  final String content;

  CardItem({
    required this.image,
    required this.title,
    required this.author,
    required this.date,
    required this.id,
    required this.tag,
    required this.status,
    required this.category,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to ArticleDetailScreen with Article object
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ArticleDetailScreen(
              Article(
                id: id,
                status: status,
                title: title,
                content: content, // Optionally provide content
                date: date,
                imgUrl: image,
                author: author,
                category: category,
              ),
            ),
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.only(bottom: 10.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Image.network(
                image,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 200,
                    width: double.infinity,
                    color: Colors.grey,
                    child: Center(
                      child: Text(
                        'Image not available',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                gradient: LinearGradient(
                  colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              left: 10,
              right: 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'by $author',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        date,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
