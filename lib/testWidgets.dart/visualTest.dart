import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manager/constant.dart';
import 'package:task_manager/providers/streamBuilder.dart';

class VisualTest extends ConsumerStatefulWidget {
  const VisualTest({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _VisualTestState();
}

class _VisualTestState extends ConsumerState<VisualTest> {
  List<FlSpot> spots = [];
  double x = 0;
  double xMax = 60, xMin = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: 700,
      child: Consumer(
        builder: (context, ref, child) {
          final streams = ref.watch(cpuBuilder);

          return streams.when(
            data: (data) {
              if (spots.length >= 60) {
                spots.removeAt(0);
              }
              if (data.containsKey('id')) {
                double yValue = double.parse(
                  (100 - data['id']!).toStringAsFixed(2),
                );
                if (yValue.isNaN || yValue < 0) {
                  print("hi");
                }
                yValue >= 0
                    ? spots.add(FlSpot(x, yValue))
                    : spots.add(FlSpot(x, 0));
                x++;
              }
              if (x > 60) {
                xMax = x;
                xMin += 1;
              }
              return LineChart(
                LineChartData(
                  titlesData: FlTitlesData(show: false),
                  lineTouchData: LineTouchData(
                    enabled: false
                  ),

                  maxX: xMax,
                  minX: xMin,
                  maxY: 100,
                  minY: 0,
                  gridData: FlGridData(
                    show: true,
                    getDrawingHorizontalLine: (value) {
                      return FlLine(color: Color(0xff37434d), strokeWidth: 2);
                    },
                    getDrawingVerticalLine: (value) {
                      return FlLine(color: Color(0xff37434d), strokeWidth: 2);
                    },
                  ),
                  borderData: FlBorderData(
                    show: true,
                    border: Border.all(color: Color(0xff37434d), width: 2),
                  ),
                  lineBarsData: [
                    LineChartBarData(
                      spots: spots,
                      dotData: FlDotData(show: false),
                      isCurved: false,
                      gradient: LinearGradient(
                        colors: gradientColor
                            .map((color) => color.withOpacity(0.8))
                            .toList(),
                      ),
                      barWidth: 0,
                      belowBarData: BarAreaData(
                        show: true,
                        gradient: LinearGradient(
                          colors: gradientColor
                              .map((color) => color.withOpacity(0.7))
                              .toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            error: (error, stack) => Text('Error: $error'),
            loading: () => Text(""),
          );
        },
      ),
    );
  }
}
