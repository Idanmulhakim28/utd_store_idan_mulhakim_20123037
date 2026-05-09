import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/crypto_cubit.dart';
import '../cubit/crypto_state.dart';
import '../widgets/price_card.dart';
import '../widgets/candlestick_chart.dart';
import '../../../../core/utils/tax_isolate.dart';

class BitcoinPage extends StatefulWidget {
  const BitcoinPage({super.key});

  @override
  State<BitcoinPage> createState() => _BitcoinPageState();
}

class _BitcoinPageState extends State<BitcoinPage> {
  bool _started = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // 🔥 AMAN DARI CONTEXT ERROR
    if (!_started) {
      context.read<CryptoCubit>().start();
      _started = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Crypto Live + Candlestick"),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [
            // 🔥 PRICE REALTIME
            BlocBuilder<CryptoCubit, CryptoState>(
              builder: (context, state) {
                return PriceCard(price: state.price, loading: state.loading);
              },
            ),

            const SizedBox(height: 20),

            // 🔥 CANDLESTICK CHART
            BlocBuilder<CryptoCubit, CryptoState>(
              builder: (context, state) {
                final candles = state.candles;

                return CandlestickChart(candles: candles);
              },
            ),

            const SizedBox(height: 20),

            // 🔥 ISOLATE TAX
            ElevatedButton(
              onPressed: () async {
                final result = await calculateTax(37);

                if (!context.mounted) return;

                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text("Hasil Pajak: $result")));
              },
              child: const Text("Kalkulasi Pajak Kripto"),
            ),
          ],
        ),
      ),
    );
  }
}
