import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class NativeChannel {
  static const MethodChannel _channel = MethodChannel(
    'com.example.device/native',
  );

  // 🔋 GET BATTERY LEVEL
  static Future<int> getBatteryLevel() async {
    try {
      final int? result = await _channel.invokeMethod<int>('getBatteryLevel');

      return result ?? -1;
    } on PlatformException catch (e) {
      debugPrint("Battery Error: ${e.message}");
      return -1;
    } catch (e) {
      debugPrint("Unknown Error: $e");
      return -1;
    }
  }

  // 🔥 SHOW NATIVE TOAST
  static Future<void> showToast(String message) async {
    try {
      await _channel.invokeMethod('showToast', {'message': message});
    } on PlatformException catch (e) {
      debugPrint("Toast Error: ${e.message}");
    } catch (e) {
      debugPrint("Unknown Error: $e");
    }
  }
}
