import 'package:flutter/material.dart';

class PriceCard extends StatelessWidget {
  final double price;
  final bool loading;

  const PriceCard({super.key, required this.price, required this.loading});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10)],
      ),
      child: loading
          ? const Row(
              children: [
                CircularProgressIndicator(),
                SizedBox(width: 10),
                Text("Loading BTC..."),
              ],
            )
          : Text(
              "BTC: \$${price.toStringAsFixed(2)}",
              style: const TextStyle(fontSize: 24),
            ),
    );
  }
}
