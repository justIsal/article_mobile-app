import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;


class ArticleDetailScreen extends StatefulWidget {
  final String title;
  final String description;
  final String date;
  final String image;

  ArticleDetailScreen(this.title, this.description, this.date, this.image);

  @override
  _ArticleDetailScreenState createState() => _ArticleDetailScreenState();
}

class _ArticleDetailScreenState extends State<ArticleDetailScreen> {

  bool isFavorite = false;

  void _toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });
    print('Icon ${isFavorite ? 'favorite' : 'favorite_border_rounded'}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text('Detail'), centerTitle: true, actions: <Widget>[
        IconButton(
          icon: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border_rounded,
          ),
          onPressed: _toggleFavorite,
        ),
      ]),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16),
              Text(
                widget.title.toUpperCase(),
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 2),
              Row(
                children: [
                  Icon(Icons.access_time, color: Colors.grey, size: 18),
                  SizedBox(width: 4),
                  Text(
                    '${timeago.format(DateTime.now())}', // Access the date from widget
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Image.network(widget.image),
              SizedBox(height: 8),
              Text(
                flutterInfo, // Access the description from widget
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
