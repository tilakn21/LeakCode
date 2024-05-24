import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Manga Grid',
      home: MangaGridScreen(
        mangaList: [
          // Your manga data list
          
        ],
      ),
    );
  }
}

class MangaGridScreen extends StatelessWidget {
  final List<Map<String, dynamic>> mangaList;

  const MangaGridScreen({super.key, required this.mangaList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manga Grid'),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          childAspectRatio: 0.7,
        ),
        itemCount: mangaList.length,
        itemBuilder: (context, index) {
          final mangaData = mangaList[index];
          return MangaGridItem(mangaData: mangaData);
        },
      ),
    );
  }
}

class MangaGridItem extends StatelessWidget {
  final Map<String, dynamic> mangaData;

  const MangaGridItem({super.key, required this.mangaData});

  @override
  Widget build(BuildContext context) {
    final localizedTitle = mangaData['localizedTitle']['en'] ?? '';
    final mainCover = mangaData['mainCover'];
    final contentRating = mangaData['contentRating'];
    final isNsfw = contentRating == 'suggestive' || contentRating == 'nsfw';

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: mainCover != null
                ? Image.network(
                    'https://uploads.mangadex.org/covers/${mainCover['id']}/cover_256x256.jpg',
                    fit: BoxFit.cover,
                  )
                : const SizedBox.shrink(),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  localizedTitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (isNsfw)
                  const Text(
                    'NSFW',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}