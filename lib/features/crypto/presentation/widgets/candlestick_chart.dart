import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../domain/candle_model.dart';

class CandlestickChart extends StatelessWidget {
  final List<CandleModel> candles;

  const CandlestickChart({super.key, required this.candles});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,

          gridData: const FlGridData(show: false),
          borderData: FlBorderData(show: false),

          titlesData: const FlTitlesData(show: false),

          barGroups: candles.asMap().entries.map((entry) {
            final index = entry.key;
            final candle = entry.value;

            final isUp = candle.close >= candle.open;

            return BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  toY: candle.high,
                  fromY: candle.low,
                  width: 6,
                  color: isUp ? Colors.green : Colors.red,
                  rodStackItems: [
                    BarChartRodStackItem(
                      candle.open,
                      candle.close,
                      isUp ? Colors.green : Colors.red,
                    ),
                  ],
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
