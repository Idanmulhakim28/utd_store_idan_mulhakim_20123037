import '../data/websocket_service.dart';

class CryptoRepository {
  final WebSocketService service;

  CryptoRepository(this.service);

  Stream<double> getBitcoinPrice() {
    return service.stream.map((event) {
      final price = double.parse(event.replaceAll(RegExp(r'[^0-9.]'), ''));
      return price;
    });
  }
}
