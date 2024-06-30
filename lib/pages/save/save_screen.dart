import 'package:flutter/material.dart';

class SaveScreen extends StatefulWidget {
  const SaveScreen({super.key});

  @override
  _SaveScreenState createState() => _SaveScreenState();
}

class _SaveScreenState extends State<SaveScreen> {
  final List<Map<String, String>> cardsData = [
    {
      'image':
          'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
      'title': 'Flutter bahasa pemrograman dart',
      'author': 'Author 1',
      'date': '2024-06-22',
      'category': 'tech'
    },
    {
      'image': 'https://via.placeholder.com/300',
      'title': 'FLutter menyenangkan',
      'author': 'Author 2',
      'date': '2024-06-21',
      'category': 'tech'
    },
    {
      'image':
          'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
      'title': 'Pemrograman mobile',
      'author': 'Author 3',
      'date': '2024-06-20',
      'category': 'tech'
    },
  ];
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
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                ),
              ),
              SizedBox(height: 16.0),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: cardsData.length,
                itemBuilder: (context, index) {
                  return CardItem(
                    image: cardsData[index]['image']!,
                    title: cardsData[index]['title']!,
                    author: cardsData[index]['author']!,
                    date: cardsData[index]['date']!,
                    category: cardsData[index]['category']!,
                  );
                },
              ),
            ],
          ),
        )));
  }
}
