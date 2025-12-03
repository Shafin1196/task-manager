import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manager/constant.dart';
import 'package:task_manager/providers/streamBuilder.dart';

class VisualTestdisk extends ConsumerStatefulWidget {
  const VisualTestdisk({super.key, required this.showGrid});
  final bool showGrid;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _VisualTestdiskState();
}

class _VisualTestdiskState extends ConsumerState<VisualTestdisk> {
  List<FlSpot> spots = [];
  double x = 0;
  double xMax = 60, xMin = 0;
  double yMax = 100;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: 700,
      child: Consumer(
        builder: (context, ref, child) {
          final streams = ref.watch(diskBuilder);
          return streams.when(
            data: (data) {
              // print(data);
              if (x > 60) {
                xMax = x;
                xMin += 1;
              }
              if (spots.length >= 63) {
                spots.removeAt(0);
              }
              if (data.containsKey('throughPut')) {
                double yValue = data["throughPut"]!;
                // print(yValue);
                spots.add(FlSpot(x, yValue));
                x++;
              }

              return LineChart(
                LineChartData(
                  titlesData: FlTitlesData(show: false),
                  clipData: FlClipData.all(),
                  lineTouchData: LineTouchData(enabled: false),
                  maxX: xMax,
                  minX: xMin,
                  maxY: data['max'],
                  minY: 0,
                  gridData: FlGridData(
                    show: widget.showGrid,
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
            error: (error, stack) => Center(child: Text("error$error")),
            loading: () => SizedBox.shrink(),
          );
        },
      ),
    );
  }
}
