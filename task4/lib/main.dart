import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:task4/presentation/home/pages/home_page.dart';
import 'package:task4/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialDependencies();
  await GetStorage.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task 4',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}
