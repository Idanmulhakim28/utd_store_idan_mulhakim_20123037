import 'package:flutter/material.dart';

class CryptoChart extends StatelessWidget {
  final List<double> data;

  const CryptoChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      width: double.infinity,
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(color: Colors.black.withAlpha(15), blurRadius: 8),
        ],
      ),

      child: data.isEmpty
          ? const Center(child: Text("Belum ada data grafik"))
          : CustomPaint(painter: ChartPainter(data), size: Size.infinite),
    );
  }
}

class ChartPainter extends CustomPainter {
  final List<double> data;

  ChartPainter(this.data);

  @override
  void paint(Canvas canvas, Size size) {
    final paintLine = Paint()
      ..color = Colors.green
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final path = Path();

    final maxPrice = data.reduce((a, b) => a > b ? a : b);
    final minPrice = data.reduce((a, b) => a < b ? a : b);

    for (int i = 0; i < data.length; i++) {
      final x = i * size.width / (data.length - 1);

      final normalized = (data[i] - minPrice) / (maxPrice - minPrice);

      final y = size.height - (normalized * size.height);

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    canvas.drawPath(path, paintLine);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
