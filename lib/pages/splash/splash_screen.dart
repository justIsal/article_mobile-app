import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  CrossFadeState _crossFadeState = CrossFadeState.showFirst;
  splashcreenTime() async {
    await Future.delayed(
      const Duration(seconds: 2),
      () => setState(() {
        _crossFadeState = CrossFadeState.showSecond;
      }),
    );
    Future.delayed(
      const Duration(seconds: 2),
      () => Navigator.pushReplacementNamed(context, '/intro'),
    );
  }

  @override
  void initState() {
    splashcreenTime();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity, // Lebar penuh layar
        height: double.infinity,
        color: const Color(0xFF0A73D3),
        child: Center(
          child: AnimatedCrossFade(
            crossFadeState: _crossFadeState,
            sizeCurve: Curves.easeInCirc,
            duration: const Duration(seconds: 1),
            firstChild: const Text(
              "KELOMPOK 7",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            secondChild: const Text(
              "LAJEUNG!!!!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
