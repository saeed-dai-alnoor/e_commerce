import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyCustomCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;
  final String price;

  const MyCustomCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AspectRatio(
          aspectRatio: 0.75, // ✅ نسبة العرض إلى الارتفاع ثابتة
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              color: Colors.grey[300],
              child: CachedNetworkImage(
                imageUrl: imagePath,
                fit: BoxFit.fill,
                placeholder: (context, url) => const Icon(
                  Icons.image, // أيقونة صورة
                  size: 60,
                  color: Colors.grey,
                ),
                errorWidget: (context, url, error) => const Icon(
                  Icons.broken_image, // أيقونة صورة مكسورة
                  size: 60,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: GoogleFonts.inter(fontSize: 14, color: Colors.grey[600]),
        ),
        const SizedBox(height: 4),
        Text(
          price,
          style: GoogleFonts.inter(
            fontSize: 16,
            color: Color(0xFF00C569),
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
