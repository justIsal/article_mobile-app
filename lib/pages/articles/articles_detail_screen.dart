import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:article_mobile_app/model/article.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ArticleDetailScreen extends StatefulWidget {
  final Article article;

  ArticleDetailScreen(this.article);

  @override
  _ArticleDetailScreenState createState() => _ArticleDetailScreenState();
}

class _ArticleDetailScreenState extends State<ArticleDetailScreen> {
  final TextEditingController _commentController = TextEditingController();
  final List<Map<String, dynamic>> _comments = [];
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _loadFavoriteStatus();
  }

  Future<void> _loadFavoriteStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isFavorite = prefs.getBool('favorite_${widget.article.id}') ?? false;
    });
  }

  void _toggleFavorite() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isFavorite = !isFavorite;
    });
    await prefs.setBool('favorite_${widget.article.id}', isFavorite);
    print('Icon ${isFavorite ? 'favorite' : 'favorite_border_rounded'}');
  }

  void _addComment() {
    final comment = _commentController.text;
    final now = DateTime.now();

    if (comment.isNotEmpty) {
      setState(() {
        _comments.add({
          'name': "Jhon doe",
          'comment': comment,
          'time': now,
        });
        _commentController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border_rounded,
            ),
            onPressed: _toggleFavorite,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16),
              Text(
                widget.article.title.toUpperCase(),
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
                    '${timeago.format(DateTime.parse(widget.article.date))}',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Image.network(widget.article.imgUrl),
              SizedBox(height: 8),
              Text(
                widget.article.content,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8),
              Stack(
                children: [
                  TextFormField(
                    controller: _commentController,
                    maxLines: 6,
                    decoration: InputDecoration(
                      hintText: 'Masukkan komentar di sini',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Komentar tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  Positioned(
                    right: 10,
                    bottom: 10,
                    child: FloatingActionButton(
                      backgroundColor: Colors.black,
                      mini: true,
                      onPressed: _addComment,
                      child: const Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text(
                'Komentar:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _comments.length,
                itemBuilder: (context, index) {
                  final commentData = _comments[index];
                  final timeAgo = timeago.format(commentData['time']);

                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 4.0),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 172, 214, 248),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: ListTile(
                      leading: Icon(Icons.person),
                      title: Text(commentData['comment']),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${commentData['name']}',
                              style: TextStyle(fontSize: 12),
                            ),
                            Text(
                              '$timeAgo',
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ),
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
