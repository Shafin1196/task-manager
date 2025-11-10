import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manager/constant.dart';
import 'package:task_manager/widgets/homeBody.dart';
import 'package:task_manager/widgets/visualization.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(margin: EdgeInsets.all(10), child: performance),
            Divider(height: 2, thickness: 2),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 2, child: Options()),
                  SizedBox(
                    height: double.infinity,
                    child: VerticalDivider(thickness: 2, width: 2),
                  ),
                  Expanded(
                    flex: 10,
                    child: Center(child: Visualization()),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
