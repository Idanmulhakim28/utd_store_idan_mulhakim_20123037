import 'package:flutter/material.dart';

import '../../../../core/di/injection.dart';
import '../../../bookmark/domain/repositories/bookmark_repository.dart';

class ProductCard extends StatelessWidget {
  final int productId;
  final String title;
  final String image;
  final double price;

  const ProductCard({
    super.key,
    required this.productId,
    required this.title,
    required this.image,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),

      padding: const EdgeInsets.all(14),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(15),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 🔥 Gambar Produk
          ClipRRect(
            borderRadius: BorderRadius.circular(12),

            child: Image.network(
              image,
              width: 85,
              height: 85,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(width: 14),

          // 🔥 Info Produk
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,

                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  "Rp $price",

                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2563EB),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 10),

          // 🔥 Tombol Bookmark BESAR & JELAS
          Material(
            color: Colors.red.shade50,
            borderRadius: BorderRadius.circular(14),

            child: InkWell(
              borderRadius: BorderRadius.circular(14),

              onTap: () async {
                final repo = locator<BookmarkRepository>();

                await repo.saveBookmark({
                  'product_id': productId,
                  'title': title,
                  'image': image,
                  'price': price,
                  'saved_at': DateTime.now().toString(),
                });

                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Berhasil ditambahkan ke Bookmark"),
                    ),
                  );
                }
              },

              child: const Padding(
                padding: EdgeInsets.all(12),

                child: Icon(Icons.favorite_border, color: Colors.red, size: 28),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
