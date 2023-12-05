import 'package:flutter/material.dart';
import 'package:dispmoveis/views/splash_screen.dart';
import 'models/databasemanager.dart';

void main() {
  runApp(const MyApp());

  DatabaseManager.createDatabase();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
