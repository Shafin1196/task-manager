
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manager/providers/streamBuilder.dart';

class Test extends ConsumerStatefulWidget {
  const Test({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TestState();
}

class _TestState extends ConsumerState<Test> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Consumer(builder: (context,ref,child){
          final streams=ref.watch(cpuBuilder);

          return streams.when(
            data: (data){
              return Column(
                children: [
                  for(var i in data.entries)
                  Text("${i.key} -> ${i.value}")
                ],
              );
            }, 
            error: (error,stack)=>Center(child: Text("Error"),), 
            loading: ()=>Center(child: CircularProgressIndicator(),)
            );
        }
        ),
      ),
    );
  }
}