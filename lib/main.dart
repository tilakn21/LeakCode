import 'package:flutter/material.dart';
import 'package:manga_mania/pages/auth/login_page.dart';
import 'package:manga_mania/pages/auth/sign_up_page.dart';
import 'package:manga_mania/pages/home/home_page.dart';
import 'package:manga_mania/pages/main/main_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Manga Mania',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        primaryColor: Colors.black,
        colorScheme: const ColorScheme.dark(),
      ),
      initialRoute: '/home',
      routes: {
        '/home': (context) => const HomePage(),
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignUpPage(),
        '/mainpage': (context) => const MainPage(),
      },
    );
  }
}
