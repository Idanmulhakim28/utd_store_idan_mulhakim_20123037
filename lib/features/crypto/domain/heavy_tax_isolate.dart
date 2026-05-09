import 'dart:isolate';

Future<int> runTaxInIsolate(int nimLast2Digit) async {
  final receivePort = ReceivePort();

  await Isolate.spawn(_isolateTask, [receivePort.sendPort, nimLast2Digit]);

  return await receivePort.first;
}

void _isolateTask(List<dynamic> args) {
  final sendPort = args[0] as SendPort;
  final nim = args[1] as int;

  int result = 0;
  final loop = nim * 10000000;

  for (int i = 0; i < loop; i++) {
    result += (i % 3) - (i % 2);
  }

  sendPort.send(result);
}
