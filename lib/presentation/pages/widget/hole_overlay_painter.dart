import 'package:flutter/material.dart';

class HoleOverlayWidget extends CustomPainter {
  final Offset center;
  final double width; // Lebar oval
  final double height; // Tinggi oval

  HoleOverlayWidget({
    required this.center,
    required this.width,
    required this.height,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black.withOpacity(0.7) // Warna overlay
      ..style = PaintingStyle.fill;

    final overlayRect = Rect.fromLTWH(0, 0, size.width, size.height);

    // Membuat lubang berbentuk oval
    final ovalRect = Rect.fromCenter(
      center: center,
      width: width,
      height: height,
    );

    final holePath = Path()..addOval(ovalRect);

    // Menggabungkan overlay dengan lubang
    final path = Path.combine(
      PathOperation.difference,
      Path()..addRect(overlayRect),
      holePath,
    );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}


