import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/injection.dart';
import '../../../bookmark/presentation/pages/bookmark_page.dart';
import '../../../crypto/presentation/pages/bitcoin_page.dart';

import '../cubit/product_cubit.dart';
import '../cubit/product_state.dart';
import '../widgets/product_card.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<ProductCubit>()..fetchProducts(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color.fromARGB(255, 58, 143, 212),
          foregroundColor: Colors.black,
          centerTitle: true,
          title: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text(
                "Products",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(height: 2),
              Text(
                "Idan Mulhakim",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),

          // 🔖 BOOKMARK
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: IconButton(
                icon: const Icon(Icons.bookmark, color: Colors.white, size: 28),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const BookmarkPage()),
                  );
                },
              ),
            ),
          ],
        ),

        body: BlocBuilder<ProductCubit, ProductState>(
          builder: (context, state) {
            if (state is ProductLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is ProductLoaded) {
              return ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: state.products.length,
                itemBuilder: (_, i) {
                  final product = state.products[i];

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: ProductCard(
                      productId: product.id,
                      title: product.title,
                      image: product.image,
                      price: product.price,
                    ),
                  );
                },
              );
            }

            if (state is ProductError) {
              return const Center(child: Text("Gagal mengambil data"));
            }

            return const SizedBox();
          },
        ),

        // 🔥 TOMBOL CRYPTO (lebih jelas)
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.orange,
          elevation: 8,
          icon: const Icon(Icons.show_chart, color: Colors.white),
          label: const Text(
            "Crypto",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const BitcoinPage()),
            );
          },
        ),

        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }
}
