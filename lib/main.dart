import 'package:article_mobile_app/pages/account/account_screen.dart';
import 'package:article_mobile_app/pages/account/profile_screen.dart';
import 'package:article_mobile_app/pages/articles/articles_screen.dart';
import 'package:article_mobile_app/pages/auth/login_screen.dart';
import 'package:article_mobile_app/pages/auth/register_screen.dart';
import 'package:article_mobile_app/pages/home/navigation_bar.dart';
import 'package:article_mobile_app/pages/intro/intro_screen.dart';
import 'package:article_mobile_app/pages/save/save_screen.dart';
import 'package:article_mobile_app/pages/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? accessToken = prefs.getString('accessToken');
  print(accessToken);
  runApp(MyApp(initialRoute: accessToken == null ? '/login' : '/home'));
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.white,
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      initialRoute: initialRoute,
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/intro': (context) => const IntroScreen(),
        '/home': (context) => const Navigation(),
        '/article': (context) => const ArticleScreen(),
        '/save': (context) => const SaveScreen(),
        '/profile': (context) => ProfileScreen(),
        '/account': (context) => AccountScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
      },
    );
  }
}
