import 'package:article_mobile_app/pages/account/account_screen.dart';
import 'package:article_mobile_app/pages/articles/articles_screen.dart';
import 'package:article_mobile_app/pages/home/home_screen.dart';
import 'package:article_mobile_app/pages/save/save_screen.dart';
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _Navigation();
}

class _Navigation extends State<Navigation> {
  /// Controller to handle PageView and also handles initial page
  final _pageController = PageController(initialPage: 0);

  /// Controller to handle bottom nav bar and also handles initial page
  final NotchBottomBarController _controller =
      NotchBottomBarController(index: 0);

  int maxCount = 5;

  @override
  void dispose() {
    _pageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// widget list
    final List<Widget> bottomBarPages = [
      HomeScreen(),
      ArticleScreen(),
      SaveScreen(),
      AccountScreen(),
    ];
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(
            bottomBarPages.length, (index) => bottomBarPages[index]),
      ),
      extendBody: true,
      bottomNavigationBar: (bottomBarPages.length <= maxCount)
          ? AnimatedNotchBottomBar(
              /// Provide NotchBottomBarController
              notchBottomBarController: _controller,
              color: Color(0xFF0A73D3),
              showLabel: true,
              // textOverflow: TextOverflow.visible,
              // maxLine: 1,
              // shadowElevation: 5,
              kBottomRadius: 28.0,

              // notchShader: const SweepGradient(
              //   startAngle: 0,
              //   endAngle: pi / 2,
              //   colors: [Colors.red, Colors.green, Colors.orange],
              //   tileMode: TileMode.mirror,
              // ).createShader(Rect.fromCircle(center: Offset.zero, radius: 8.0)),
              notchColor: Color(0xFF0A73D3),

              /// restart app if you change removeMargins
              removeMargins: false,
              bottomBarWidth: 500,
              showShadow: false,
              durationInMilliSeconds: 300,

              itemLabelStyle: const TextStyle(fontSize: 10),
              elevation: 1,
              bottomBarItems: const [
                BottomBarItem(
                    inActiveItem: Icon(
                      Icons.home_filled,
                      color: Colors.white,
                    ),
                    activeItem: Icon(
                      Icons.home_filled,
                      color: Colors.white,
                    ),
                    itemLabelWidget: Text(
                      'Home',
                      style: TextStyle(fontSize: 10, color: Colors.white),
                    )),
                BottomBarItem(
                    inActiveItem: Icon(Icons.article, color: Colors.white),
                    activeItem: Icon(
                      Icons.article,
                      color: Colors.white,
                    ),
                    // itemLabel: 'articles',
                    itemLabelWidget: Text(
                      'Articles',
                      style: TextStyle(fontSize: 10, color: Colors.white),
                    )),
                BottomBarItem(
                    inActiveItem: Icon(
                      Icons.favorite,
                      color: Colors.white,
                    ),
                    activeItem: Icon(
                      Icons.favorite,
                      color: Colors.white,
                    ),
                    itemLabelWidget: Text(
                      'Save',
                      style: TextStyle(fontSize: 10, color: Colors.white),
                    )),
                BottomBarItem(
                    inActiveItem: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                    activeItem: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                    itemLabelWidget: Text(
                      'Account',
                      style: TextStyle(fontSize: 10, color: Colors.white),
                    )),
              ],
              onTap: (index) {
                _pageController.jumpToPage(index);
              },
              kIconSize: 24.0,
            )
          : null,
    );
  }
}
