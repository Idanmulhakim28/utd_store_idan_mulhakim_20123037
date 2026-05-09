import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_products.dart';
import 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final GetProducts getProducts;

  ProductCubit(this.getProducts) : super(ProductInitial());

  void fetchProducts() async {
    emit(ProductLoading());

    try {
      final data = await getProducts();
      print("DATA MASUK: $data");
      emit(ProductLoaded(data));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }
}
