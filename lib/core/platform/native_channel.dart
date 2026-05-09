import 'package:flutter/services.dart';

class NativeChannel {
  static const MethodChannel _channel = MethodChannel(
    'com.example.device/native',
  );

  static Future<int> getBatteryLevel() async {
    try {
      final result = await _channel.invokeMethod<int>('getBatteryLevel');
      return result ?? -1;
    } catch (e) {
      return -1;
    }
  }

  static Future<void> showToast(String message) async {
    try {
      await _channel.invokeMethod('showToast', {'message': message});
    } catch (e) {
      // ignore
    }
  }
}
