import 'dart:isolate';

Future<int> calculateTax(int nimLast2Digit) async {
  final port = ReceivePort();

  await Isolate.spawn(_worker, [port.sendPort, nimLast2Digit]);

  return await port.first;
}

void _worker(List args) {
  final sendPort = args[0] as SendPort;
  final nim = args[1] as int;

  int result = 0;
  final loop = nim * 10000000;

  for (int i = 0; i < loop; i++) {
    result += (i % 3) - (i % 2);
  }

  sendPort.send(result);
}
