import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/crypto_repository.dart';
import 'crypto_state.dart';

class CryptoCubit extends Cubit<CryptoState> {
  final CryptoRepository repository;

  CryptoCubit(this.repository) : super(CryptoState.initial());

  void start() {
    repository.getBitcoinPrice().listen((price) {
      final updatedHistory = List<double>.from(state.history)..add(price);

      print("🔥 PRICE UPDATE: $price");

      emit(
        state.copyWith(
          price: price,
          loading: false,
          history: updatedHistory,
          candles: state.candles,
        ),
      );
    });
  }
}
