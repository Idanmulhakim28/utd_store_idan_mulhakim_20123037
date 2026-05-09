import 'dart:convert';

import '../domain/crypto_repository.dart';
import 'websocket_service.dart';

class CryptoRepositoryImpl implements CryptoRepository {
  final WebSocketService service;

  CryptoRepositoryImpl(this.service);

  @override
  Stream<double> getBitcoinPrice() {
    return service.stream.map((event) {
      final data = jsonDecode(event);
      return double.parse(data['bitcoin'].toString());
    });
  }
}
