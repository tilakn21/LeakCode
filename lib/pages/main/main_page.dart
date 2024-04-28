// Manga Model
// Manga Model
import 'dart:convert';
import 'dart:html';
import 'dart:typed_data';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:manga_mania/pages/main/manga_card.dart';

class PdfViewerPage extends StatefulWidget {
  final String pdfUrl;

  PdfViewerPage({required this.pdfUrl});

  @override
  _PdfViewerPageState createState() => _PdfViewerPageState();
}

class _PdfViewerPageState extends State<PdfViewerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Viewer'),
      ),
      body: PDFView(
        filePath: widget.pdfUrl,
        enableSwipe: true,
        swipeHorizontal: true,
        autoSpacing: false,
        pageFling: true,
        pageSnap: true,
        defaultPage: 0,
        fitPolicy: FitPolicy.BOTH,
        preventLinkNavigation: false,
      ),
    );
  }
}

// Main Page
class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List<Manga> mangas = [
    Manga(
      id: '1',
      title: 'Naruto',
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/en/9/94/NarutoCoverTankobon1.jpg',
      isNSFW: false,
      pdfUrl: "lib/pdfs/testpdf_1.pdf",
    ),
    Manga(
      id: '2',
      title: 'One Piece',
      imageUrl:
          'https://m.media-amazon.com/images/M/MV5BM2YwYTkwNjItNGQzNy00MWE1LWE1M2ItOTMzOGI1OWQyYjA0XkEyXkFqcGdeQXVyMTUzMTg2ODkz._V1_FMjpg_UX1000_.jpg',
      isNSFW: false,
      pdfUrl: "lib/pdfs/testpdf_2.pdf",
    ),
    Manga(
      id: '3',
      title: 'Attack On Titan',
      imageUrl:
          'https://m.media-amazon.com/images/I/71S8O-3xLVL._AC_UF1000,1000_QL80_.jpg',
      isNSFW: true,
      pdfUrl: "lib/pdfs/testpdf_3.pdf",
    ),
    Manga(
      id: '4',
      title: 'Shonen Jump',
      imageUrl:
          'https://m.media-amazon.com/images/I/81X5Wy1uMUL._AC_UF1000,1000_QL80_.jpg',
      isNSFW: true,
      pdfUrl: "lib/pdfs/testpdf_4.pdf",
    ),
    Manga(
      id: '5',
      title: 'Vagabond',
      imageUrl:
          'https://www.japantimes.co.jp/wp-content/uploads/2017/01/p22-kosaka-vaga-a-20170108.jpg',
      isNSFW: false,
      pdfUrl: "lib/pdfs/testpdf_4.pdf",
    ),
    Manga(
      id: '6',
      title: 'Fullmetal Alchemy',
      imageUrl:
          'https://m.media-amazon.com/images/I/61GWN9NPJvL._AC_UF1000,1000_QL80_.jpg',
      isNSFW: true,
      pdfUrl: "lib/pdfs/testpdf_4.pdf",
    ),
    Manga(
      id: '7',
      title: 'Chainsaw Man',
      imageUrl:
          'https://d28hgpri8am2if.cloudfront.net/book_images/onix/cvr9781974709939/chainsaw-man-vol-1-9781974709939_hr.jpg',
      isNSFW: true,
      pdfUrl: "lib/pdfs/testpdf_4.pdf",
    ),
  ];

  void _openPdf(BuildContext context, String pdfFilePath) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PdfViewerPage(pdfUrl: pdfFilePath),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: [
            Container(
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'Manga Mania',
                  style: GoogleFonts.mPlus1p(
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const Spacer(),
            IconButton(
              onPressed: () {
                // Handle manga action
                Navigator.pushNamed(context, '/manga');
              },
              icon: const Icon(Icons.menu_book),
            ),
            const Text(
              'Manga',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            const SizedBox(width: 16),
            IconButton(
              onPressed: () {
                // Handle favorite action
              },
              icon: const Icon(Icons.favorite_border),
            ),
            const Text(
              'Favorites',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          // Add the background image
          Positioned.fill(
            child: Image.asset(
              'lib/pages/home/images/bg.png',
              fit: BoxFit.cover,
              color: Colors.black.withOpacity(0.4),
              colorBlendMode: BlendMode.colorBurn,
            ),
          ),
          // Add the grid view
          GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              childAspectRatio: 0.7,
            ),
            itemCount: mangas.length + 1, // Add 1 for the "Add" card
            itemBuilder: (context, index) {
              if (index == mangas.length) {
                // Render the "Add" card
                return Card(
                  child: InkWell(
                    onTap: () {
                      // Handle "Add" card tap
                    },
                    child: Center(
                      child: Icon(Icons.add),
                    ),
                  ),
                );
              } else {
                return MangaCard(
                  manga: mangas[index],
                  onTapPdf: () {
                    _openPdf(context, mangas[index].pdfUrl);
                  },
                );
              }
            },
          ),
        ],
      ),
    );
  }

  void _showAddMangaDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        String title = '';
        String imageUrl = '';
        String pdfUrl = '';
        bool isNSFW = false;

        return AlertDialog(
          title: Text('Add Manga'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) {
                  title = value;
                },
                decoration: InputDecoration(
                  hintText: 'Manga Title',
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                onChanged: (value) {
                  imageUrl = value;
                },
                decoration: InputDecoration(
                  hintText: 'Image URL',
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                onChanged: (value) {
                  pdfUrl = value;
                },
                decoration: InputDecoration(
                  hintText: 'PDF URL',
                ),
              ),
              SizedBox(height: 16.0),
              CheckboxListTile(
                title: Text('NSFW'),
                value: isNSFW ?? false,
                onChanged: (value) {
                  setState(() {
                    isNSFW = value ?? false;
                  });
                },
                activeColor: Colors.black,
                checkColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (title.isNotEmpty &&
                    imageUrl.isNotEmpty &&
                    pdfUrl.isNotEmpty) {
                  final newManga = Manga(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    title: title,
                    imageUrl: imageUrl,
                    pdfUrl: pdfUrl,
                    isNSFW: isNSFW,
                  );
                  setState(() {
                    mangas.add(newManga);
                  });
                  Navigator.of(context).pop();
                }
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
