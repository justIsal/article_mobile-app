import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:article_mobile_app/pages/home/card_list.dart';

class Carousel extends StatefulWidget {
  final List<Map<String, String>> cardsData;

  Carousel({
    required this.cardsData,
  });

  @override
  State<StatefulWidget> createState() {
    return _CarouselState();
  }
}

class _CarouselState extends State<Carousel> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Column(
        children: [
          Expanded(
            child: CarouselSlider(
              items: widget.cardsData.map((item) {
                return CardItem(
                  image: item['image']!,
                  title: item['title']!,
                  author: item['author']!,
                  date: item['date']!,
                  category: item['category']!,
                  id: item['id']!,
                  tag: item['tag']!,
                  status: item['status']!,
                  content: item['content']!,
                );
              }).toList(),
              carouselController: _controller,
              options: CarouselOptions(
                autoPlay: true,
                enlargeCenterPage: true,
                aspectRatio: 2.0,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                },
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.cardsData.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () => _controller.animateToPage(entry.key),
                child: Container(
                  width: 12.0,
                  height: 12.0,
                  margin: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 4.0,
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black)
                        .withOpacity(_current == entry.key ? 0.9 : 0.4),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
