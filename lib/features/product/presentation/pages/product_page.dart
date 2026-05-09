import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/platform/native_channel.dart';

import '../../../bookmark/presentation/pages/bookmark_page.dart';
import '../../../crypto/presentation/pages/bitcoin_page.dart';
import '../../../device/presentation/pages/batteray_page.dart';

import '../cubit/product_cubit.dart';
import '../cubit/product_state.dart';
import '../widgets/product_card.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  int battery = 0;

  @override
  void initState() {
    super.initState();
    loadBattery();
  }

  Future<void> loadBattery() async {
    final level = await NativeChannel.getBatteryLevel();

    if (!mounted) return;

    setState(() {
      battery = level;
    });
  }

  IconData getBatteryIcon() {
    if (battery >= 90) return Icons.battery_full;
    if (battery >= 60) return Icons.battery_5_bar;
    if (battery >= 30) return Icons.battery_3_bar;
    return Icons.battery_alert;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<ProductCubit>()..fetchProducts(),

      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color.fromARGB(255, 58, 143, 212),
          foregroundColor: Colors.white,
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
                style: TextStyle(fontSize: 12, color: Colors.white70),
              ),
            ],
          ),

          actions: [
            // 🔋 BATTERY
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const BatteryPage()),
                );
              },

              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),

                child: Row(
                  children: [
                    Icon(getBatteryIcon(), color: Colors.white),

                    const SizedBox(width: 4),

                    Text(
                      "$battery%",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // 🔖 BOOKMARK
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

        // 🔥 FLOATING BUTTON CRYPTO
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
