import 'package:article_mobile_app/model/article.dart';
import 'package:article_mobile_app/services/article/article_service.dart';
import 'package:flutter/material.dart';
import 'package:article_mobile_app/pages/home/card_list.dart';
import 'package:article_mobile_app/pages/home/carousel.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  late Future<List<Article>> _articlesFuture;

  @override
  void initState() {
    super.initState();
    _articlesFuture = ArticleService().fetchArticles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.blue,
        title: Text('Articles'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Title(
                  color: Colors.black,
                  child: Text(
                    'News Article',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              FutureBuilder<List<Article>>(
                future: _articlesFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No articles found'));
                  } else {
                    List<Article> articles = snapshot.data!;
                    return Column(
                      children: [
                        // Carousel(cardsData: articles.map((article) {
                        //   return {
                        //     'image': article.imgUrl,
                        //     'title': article.title,
                        //     'author': article.author,
                        //     'date': article.date,
                        //     'category': article.category,
                        //   };
                        // }).toList()),
                        SizedBox(height: 16.0),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Title(
                            color: Colors.black,
                            child: Text(
                              'Hot Article',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: articles.length,
                          itemBuilder: (context, index) {
                            return CardItem(
                              id: articles[index].id,
                              content: articles[index].content,
                              image: articles[index].imgUrl,
                              title: articles[index].title,
                              author: articles[index].author,
                              date: articles[index].date,
                              category: articles[index].category,
                              status: articles[index].status,
                              tag: articles[index].status,
                            );
                          },
                        ),
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
