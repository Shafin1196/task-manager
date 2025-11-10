import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manager/providers/getCpuInfo.dart';
import 'package:task_manager/providers/streamBuilder.dart';
import 'package:task_manager/testWidgets.dart/visualTest.dart';

class Visualization extends ConsumerStatefulWidget {
  const Visualization({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _VisualizationState();
}

class _VisualizationState extends ConsumerState<Visualization> {
  @override
  Widget build(BuildContext context) {
    final option = ref.watch(selectProvider);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40),
            Consumer(
              builder: (context, ref, child) {
                final model = ref.watch(cpuProvider);
                return model.when(
                  data: (data) {
                    return Row(
                      children: [
                        Text(option.toUpperCase(),
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold
                        ),
                        ),
                        Spacer(),
                        Text(data,
                        ),
                      ],
                    );
                  },
                  error: (error, stack) => Text(''),
                  loading: () => Text(""),
                );
              },
            ),
            SizedBox(height: 10),
            Row(children: [Text("% Utilization"), Spacer(), Text("100%")]),

            VisualTest(),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Text("0 sec"), Spacer(), Text("60 sec")],
            ),
            SizedBox(height: 10),
            Consumer(
              builder: (context, ref, child) {
                final streams = ref.watch(cpuBuilder);
                return streams.when(
                  data: (data) {
                    return Column(
                      children: [
                        if (data.containsKey('id'))
                          Text(
                            "Utilization\n${(100 - data['id']!).toStringAsFixed(2)} %",
                          ),
                      ],
                    );
                  },
                  error: (error, stack) => Center(child: Text("Error")),
                  loading: () => Center(child: CircularProgressIndicator()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
