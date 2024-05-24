// ignore_for_file: depend_on_referenced_packages, library_private_types_in_public_api, avoid_print

import 'dart:io';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class MangaViewerPage extends StatefulWidget {
  final String pdfUrl;

  const MangaViewerPage({super.key, required this.pdfUrl});

  @override
  _MangaViewerPageState createState() => _MangaViewerPageState();
}

class _MangaViewerPageState extends State<MangaViewerPage> {
  late String _pdfPath;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchPdfBytes();
  }

  Future<void> _fetchPdfBytes() async {
    try {
      final response = await http.get(Uri.parse(widget.pdfUrl));
      final pdfBytes = response.bodyBytes;

      // Create a temporary file to store the PDF bytes
      final tempDir = await getTemporaryDirectory();
      final tempFile = File('${tempDir.path}/temp_pdf.pdf');
      await tempFile.writeAsBytes(pdfBytes);

      setState(() {
        _pdfPath = tempFile.path;
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading PDF: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Viewer'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : PDFView(
              filePath: _pdfPath,
              enableSwipe: true,
              swipeHorizontal: true,
              autoSpacing: false,
              pageFling: true,
              pageSnap: true,
              defaultPage: 0,
              fitEachPage: true,
              preventLinkNavigation: false,
            ),
    );
  }
}