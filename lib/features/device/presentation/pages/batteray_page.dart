import 'package:flutter/material.dart';
import '../../../../core/platform/native_channel.dart';

class BatteryPage extends StatefulWidget {
  const BatteryPage({super.key});

  @override
  State<BatteryPage> createState() => _BatteryPageState();
}

class _BatteryPageState extends State<BatteryPage> {
  int battery = -1;
  bool loading = false;

  Future<void> getBattery() async {
    setState(() => loading = true);

    final level = await NativeChannel.getBatteryLevel();

    setState(() {
      battery = level;
      loading = false;
    });
  }

  Future<void> showToast() async {
    await NativeChannel.showToast("Halo dari Flutter 🚀");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Battery Native")),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Battery: $battery%"),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: getBattery,
              child: const Text("Get Battery"),
            ),

            ElevatedButton(
              onPressed: showToast,
              child: const Text("Show Toast"),
            ),
          ],
        ),
      ),
    );
  }
}
