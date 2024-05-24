import 'package:flutter/material.dart';
import 'package:manga_mania/pages/auth/sign_in_page.dart';
import 'package:manga_mania/pages/auth/gif_widget.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        color: Colors.white, // Set background color to white
        child: const Row(
          children: [
            Expanded(
              flex: 2,
              child: SignInPage(),
            ),
            Expanded(
              flex: 3,
              child: GifWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
