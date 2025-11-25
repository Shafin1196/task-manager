import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manager/providers/getCpuInfo.dart';
import 'package:task_manager/providers/streamBuilder.dart';
import 'package:task_manager/testWidgets.dart/visualTest.dart';
import 'package:task_manager/testWidgets.dart/visualTestMem.dart';
import 'package:task_manager/testWidgets.dart/visulaTestNet.dart';

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
                        Text(
                          option.toUpperCase(),
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        option == "cpu" ? Text(data['model name']!) : Text(""),
                      ],
                    );
                  },
                  error: (error, stack) => Text(''),
                  loading: () => Text(""),
                );
              },
            ),
            SizedBox(height: 10),
            Row(
              children: [
                option == "cpu"
                    ? Text("% Utilization")
                    : option == 'memory'
                    ? Text("Memory usages")
                    : Text('Throughput'),
                Spacer(),
                option == "cpu"
                    ? Text("100%")
                    : option == 'memory'
                    ? Consumer(
                        builder: (context, ref, child) {
                          final ramStream = ref.watch(ramBuilder);
                          return ramStream.when(
                            data: (data) {
                              return Text("${data['total']!} GB");
                            },
                            error: (error, stack) => Text('error!!!'),
                            loading: () => Text(''),
                          );
                        },
                      )
                    : Consumer(
                        builder: (context, ref, child) {
                          final streams = ref.watch(networkBuilder);
                          return streams.when(
                            data: (data){
                              return Text("${data['max']} kbps");
                            },
                            error: (error,stack)=> Center(child: Text("$error"),),
                            loading: ()=>Text(""),
                          );
                        },
                      ),
              ],
            ),
            option == "cpu"
                ? VisualTest(showGrid: true,)
                : option == "memory"
                ? Visualtestmem(showGrid: true,)
                : VisualtestNet(showGrid: true,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Text("0 sec"), Spacer(), Text("60 sec")],
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Color(0xff1d1b20),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  option == "cpu"
                      ? Consumer(
                          builder: (context, ref, child) {
                            final streams = ref.watch(cpuBuilder);
                            return streams.when(
                              data: (data) {
                                return Column(
                                  children: [
                                    if (data.containsKey('id'))
                                      Text(
                                        "Utilization${' ' * 21}: ${(100 - data['id']!).toStringAsFixed(2)} %\n",
                                      ),
                                  ],
                                );
                              },
                              error: (error, stack) =>
                                  Center(child: Text("Error")),
                              loading: () =>
                                  Center(child: CircularProgressIndicator()),
                            );
                          },
                        )
                      : SizedBox.shrink(),
                  option == "cpu"
                      ? Consumer(
                          builder: (context, ref, child) {
                            final cpuInfo = ref.watch(cpuProvider);
                            return cpuInfo.when(
                              data: (data) {
                                return Column(
                                  children: [
                                    Text(
                                      "Cores${' ' * 30}: ${data['cpu cores']!} \n\nBase Speed${' ' * 19}: ${data['cpu MHz']!} MHz\n\nCache size${' ' * 21}: ${data['cache size']!}",
                                    ),
                                  ],
                                );
                              },
                              error: (error, stack) =>
                                  Center(child: Text("Error")),
                              loading: () =>
                                  Center(child: CircularProgressIndicator()),
                            );
                          },
                        )
                      :option == "memory"? Consumer(
                          builder: (context, ref, child) {
                            final ramInfo = ref.watch(ramBuilder);
                            return ramInfo.when(
                              data: (data) {
                                return Column(
                                  children: [
                                    Text(
                                      "Total Memory${' ' * 20}: ${data['total']!} GB \n\nIn use${' ' * 35}: ${data['used']!} GB\n\nAvailable${' ' * 29}: ${data['available']!} GB\n\nCache memory${' ' * 18}: ${data['cache']!} GB",
                                    ),
                                  ],
                                );
                              },
                              error: (error, stack) =>
                                  Center(child: Text("Error")),
                              loading: () =>
                                  Center(child: CircularProgressIndicator()),
                            );
                          },
                        ):Consumer(
                          builder: (context, ref, child) {
                            final netInfo = ref.watch(networkBuilder);
                            return netInfo.when(
                              data: (data) {
                                return Column(
                                  children: [
                                    Text(
                                      'Send              :  ${data['up']} kbps\n\nRecieve         :  ${data['down']} kbps'
                                    ),
                                  ],
                                );
                              },
                              error: (error, stack) =>
                                  Center(child: Text("Error")),
                              loading: () =>
                                  Center(child: CircularProgressIndicator()),
                            );
                          },
                        )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
