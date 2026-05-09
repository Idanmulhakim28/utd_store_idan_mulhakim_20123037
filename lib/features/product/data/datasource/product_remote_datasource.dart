import '../../../../core/network/api_client.dart';
import '../models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts();
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final api = ApiClient();

  @override
  Future<List<ProductModel>> getProducts() async {
    final response = await api.get("/products");

    return (response as List).map((e) => ProductModel.fromJson(e)).toList();
  }
}
