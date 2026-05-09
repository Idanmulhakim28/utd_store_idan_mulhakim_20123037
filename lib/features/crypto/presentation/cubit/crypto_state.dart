import '../../domain/candle_model.dart';

class CryptoState {
  final double price;
  final bool loading;
  final List<double> history;
  final List<CandleModel> candles;

  CryptoState({
    required this.price,
    required this.loading,
    required this.history,
    required this.candles,
  });

  factory CryptoState.initial() {
    return CryptoState(price: 0, loading: true, history: [], candles: []);
  }

  CryptoState copyWith({
    double? price,
    bool? loading,
    List<double>? history,
    List<CandleModel>? candles,
  }) {
    return CryptoState(
      price: price ?? this.price,
      loading: loading ?? this.loading,
      history: history ?? this.history,
      candles: candles ?? this.candles,
    );
  }
}
