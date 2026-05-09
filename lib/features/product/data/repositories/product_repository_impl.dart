import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasource/product_remote_datasource.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remote;

  ProductRepositoryImpl(this.remote);

  @override
  Future<List<Product>> getProducts() async {
    final data = await remote.getProducts();

    // 🔥 NIM 20123037 → GANJIL
    return data.map((e) {
      return Product(
        id: e.id,
        title: "${e.title} [Diskon 10%]",
        price: e.price,
        image: e.image,
      );
    }).toList();
  }
}
