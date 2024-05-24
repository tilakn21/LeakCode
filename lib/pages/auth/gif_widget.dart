import 'package:flutter/material.dart';

class GifWidget extends StatelessWidget {
  const GifWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'lib/pages/home/images/manga-goku.gif',
      fit: BoxFit.cover,
      height: MediaQuery.of(context).size.height,
    );
  }
}
