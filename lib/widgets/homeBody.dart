import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manager/providers/getCpuInfo.dart';
import 'package:task_manager/testWidgets.dart/visualTest.dart';

class Options extends ConsumerWidget {
  const Options({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Consumer(
          builder: (context, ref, child) {
            // ignore: unused_local_variable
            final select = ref.watch(selectProvider);
            return Container(
              margin: EdgeInsets.all(15),
              child: SizedBox(
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    ref.read(selectProvider.notifier).state = "cpu";
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 10,
                    shadowColor: Colors.black12,
                    padding: EdgeInsets.all(10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(5),
                    ),
                  ),
                  child: Row(
                    children: [
                      SizedBox(height: 50, width: 80, child: VisualTest()),
                      SizedBox(width: 20),
                      Text("CPU"),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        Consumer(
          builder: (context, ref, child) {
            // ignore: unused_local_variable
            final select = ref.watch(selectProvider);
            return Container(
              margin: EdgeInsets.all(15),
              child: SizedBox(
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    ref.read(selectProvider.notifier).state = "ram";
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 10,
                    shadowColor: Colors.black12,
                    padding: EdgeInsets.all(10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(5),
                    ),
                  ),
                  child: Row(
                    children: [
                      // SizedBox(
                      // height: 50,
                      // width: 80,
                      // child: VisualTest(),
                      // ),
                      SizedBox(width: 20),
                      Text("Memory"),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        Consumer(
          builder: (context, ref, child) {
            // ignore: unused_local_variable
            final select = ref.watch(selectProvider);
            return Container(
              margin: EdgeInsets.all(15),
              child: SizedBox(
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    ref.read(selectProvider.notifier).state = "disk";
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 10,
                    shadowColor: Colors.black12,
                    padding: EdgeInsets.all(10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(5),
                    ),
                  ),
                  child: Row(
                    children: [
                      // SizedBox(
                      // height: 50,
                      // width: 80,
                      // child: VisualTest(),
                      // ),
                      SizedBox(width: 20),
                      Text("Disk"),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        Consumer(
          builder: (context, ref, child) {
            // ignore: unused_local_variable
            final select = ref.watch(selectProvider);
            return Container(
              margin: EdgeInsets.all(15),
              child: SizedBox(
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    ref.read(selectProvider.notifier).state = "GPU";
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 10,
                    shadowColor: Colors.black12,
                    padding: EdgeInsets.all(10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(5),
                    ),
                  ),
                  child: Row(
                    children: [
                      // SizedBox(
                      // height: 50,
                      // width: 80,
                      // child: VisualTest(),
                      // ),
                      SizedBox(width: 20),
                      Text("GPU"),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
