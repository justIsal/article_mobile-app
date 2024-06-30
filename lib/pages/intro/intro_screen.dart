import 'package:flutter/material.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: double.infinity, 
      padding: EdgeInsets.all(20),
      height: double.infinity,
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: const EdgeInsets.only(bottom: 1.0),
                child: Image.asset(
                  'assets/images/intro.png',
                  width: 320,
                )),
            const Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: Text.rich(
                  TextSpan(
                    text: 'Welcome to ',
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Readss',
                        style: TextStyle(color: Color(0xFF0A73D3)),
                      ),
                    ],
                  ),
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                )),
            const Padding(
              padding: EdgeInsets.only(bottom: 10.0),
              child: Text.rich(
                TextSpan(
                  text: 'Blogs on wide range of topics ',
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Simplified',
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                ),
                style: TextStyle(fontSize: 16),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/login');
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    side: const BorderSide(
                        color: Colors.black,
                        width: 1), // Border color and width
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // Border radius
                    )),
                child: const Text('Explore',
                    style: TextStyle(color: Colors.black)))
          ],
        ),
      ),
    ));
  }
}
