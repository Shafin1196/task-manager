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
      child: Column(
        children: [
          SizedBox(height: 40),
          Consumer(
            builder: (context, ref, child) {
              final model=ref.watch(cpuProvider);
              return model.when(
                data: (data){
                  return Padding(
                    padding: EdgeInsetsGeometry.only(left: 30,right: 30),
                    child: Row(children: [
                                    Text(option),
                                    Spacer(),
                                    Text(data),
                    
                                  ]
                                  ),
                  );
                }, 
                error:( error,stack)=>Text(''), 
                loading: ()=>Text("")
                );
            },
          ),
          SizedBox(height: 10),
          Expanded(child: VisualTest()),
          Consumer(
            builder: (context, ref, child) {
              final streams = ref.watch(cpuBuilder);
              return streams.when(
                data: (data) {
                  return Column(
                    children: [
                      for (var i in data.entries)
                        Text("${i.key} -> ${i.value}"),
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
    );
  }
}
