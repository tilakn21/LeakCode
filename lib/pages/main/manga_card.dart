// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Manga {
  final String id;
  final String title;
  final String imageUrl;
  final String pdfUrl;
  final bool isNSFW;
  final String externalLink;

  Manga({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.pdfUrl,
    required this.isNSFW,
    required this.externalLink,
  });
}

class MangaCard extends StatelessWidget {
  final Manga manga;

  const MangaCard({super.key, required this.manga});

  Future<void> _openExternalLink(
      BuildContext context, String externalLink) async {
    if (await canLaunchUrl(Uri.parse(externalLink))) {
      await launchUrl(Uri.parse(externalLink));
    } else {
      // Handle the case where the external link cannot be launched
      // You can display an error message or take other appropriate actions
      print('Could not launch $externalLink');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          _openExternalLink(context, manga.externalLink);
        },
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.network(
                  manga.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      manga.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  if (manga.isNSFW)
                    const Center(
                      child: Text(
                        'NSFW',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Colors.red,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddMangaCard extends StatelessWidget {
  final VoidCallback onTap;

  const AddMangaCard({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: const Center(
          child: Icon(Icons.add, size: 48),
        ),
      ),
    );
  }
}
