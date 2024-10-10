import 'package:flutter/material.dart';
import 'package:task2/presentation/home/pages/home_page.dart';
import 'package:task2/service_locator.dart';

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
      title: 'Task 2',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
