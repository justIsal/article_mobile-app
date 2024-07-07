import 'package:article_mobile_app/pages/articles/item_list_article.dart';
import 'package:flutter/material.dart';

class ArticleScreen extends StatefulWidget {
  const ArticleScreen({Key? key}) : super(key: key);

  @override
  _ArticleScreenState createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Color(0xFF0A73D3),
        title: Text('Articles'),
        centerTitle: true,
      ),
      body: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            title: TextField(
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
            bottom: TabBar(
              indicatorColor: Color(0xFF0A73D3), // Warna indikator tab aktif
              labelColor: Color(0xFF0A73D3), // Warna teks tab aktif
              unselectedLabelColor: Colors.black,
              tabs: [
                Tab(text: 'All'),
                Tab(text: 'technology'),
                Tab(text: 'health'),
                Tab(text: 'science'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              ItemListView('All'),
              ItemListView('technology'),
              ItemListView('health'),
              ItemListView('science'),
              // Placeholder untuk tab 'All'
            ],
          ),
        ),
      ),
    );
  }
}
