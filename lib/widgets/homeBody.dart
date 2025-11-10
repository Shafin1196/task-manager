import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manager/providers/getCpuInfo.dart';

class Options extends ConsumerWidget {
  const Options({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Consumer(builder: (context,ref,child){
            final select=ref.watch(selectProvider);
            return Container(
              margin: EdgeInsets.all(15),
              child: ElevatedButton.icon(
              onPressed: (){
                ref.read(selectProvider.notifier).state="cpu";
                
              }, 
              label: Text("CPU"),
              icon: Icon(Icons.rate_review),
              ),
            );
           }),
          Consumer(builder: (context,ref,child){
            final select=ref.watch(selectProvider);
            return Container(
              margin: EdgeInsets.all(15),
              child: ElevatedButton.icon(
              onPressed: (){
                ref.read(selectProvider.notifier).state="memory";
              }, 
              label: Text("Memory"),
              icon: Icon(Icons.rate_review),
              ),
            );
           }),
           Consumer(builder: (context,ref,child){
            final select=ref.watch(selectProvider);
            return Container(
              margin: EdgeInsets.all(15),
              child: ElevatedButton.icon(
              onPressed: (){
                ref.read(selectProvider.notifier).state="disk";
              }, 
              label: Text("Disk"),
              icon: Icon(Icons.rate_review),
              ),
            );
           }),
           Consumer(builder: (context,ref,child){
            final select=ref.watch(selectProvider);
            return Container(
              margin: EdgeInsets.all(15),
              child: ElevatedButton.icon(
              onPressed: (){
                ref.read(selectProvider.notifier).state="gpu";
              }, 
              label: Text("GPU"),
              icon: Icon(Icons.rate_review),
              ),
            );
           }),
        ],
      
    );
  }
}