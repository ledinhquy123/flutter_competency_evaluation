import 'package:flutter/material.dart';
import 'package:task1/presentation/home/pages/home_page.dart';
import 'package:task1/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task 1',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}
