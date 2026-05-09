import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketService {
  final _channel = WebSocketChannel.connect(
    Uri.parse('wss://ws.coincap.io/prices?assets=bitcoin'),
  );

  Stream<String> get stream => _channel.stream.map((event) => event.toString());
}
