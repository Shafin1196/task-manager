import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manager/Screens/homeScreens.dart';
import 'package:task_manager/testWidgets.dart/strembuilderTest.dart';
import 'package:window_size/window_size.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // runApp( ProviderScope(child: MyApp()));
  setWindowMinSize(const Size(1000, 800));
  setWindowMaxSize(const Size(1000, 800));
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.dark,
      home: HomeScreen(),
      // home: Test(),
    );
  }
}
