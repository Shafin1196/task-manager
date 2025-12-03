import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manager/constant.dart';
import 'package:task_manager/providers/streamBuilder.dart';

class VisualtestNet extends ConsumerStatefulWidget {
  const VisualtestNet({super.key,required this.showGrid});
  final bool showGrid;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _VisualtestNetState();
}

class _VisualtestNetState extends ConsumerState<VisualtestNet> {

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
          final streams = ref.watch(networkBuilder);

          return streams.when(
            data: (data) {
              if (spots.length >= 63) {
                spots.removeAt(0);
              }
              if (x > 60) {
                xMax = x;
                xMin += 1;
              }
              if (data.containsKey('throughPut')) {
                double yValue = data['throughPut']!;
                yValue >= 0
                    ? spots.add(FlSpot(x, yValue))
                    : spots.add(FlSpot(x, 0));
                x++;
              }
              
              
              
              return 
              LineChart(
                LineChartData(
                  titlesData: FlTitlesData(show: false),
                  lineTouchData: LineTouchData(
                    enabled: false
                  ),
                  clipData: FlClipData.all(),
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
            error: (error, stack) => Text('Error: $error'),
            loading: () => Center(child: CircularProgressIndicator(),),
          );
        },
      ),
    );
  }
}