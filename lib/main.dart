
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import 'screens/splash_screen.dart';




void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  //Hive.registerAdapter(WeatherModelAdapter());  // Register adapters for custom classes
  await Hive.openBox('weatherBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'আমার আবহাওয়া',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: Splash(),
    );
  }
}
