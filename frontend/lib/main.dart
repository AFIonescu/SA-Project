import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const DesignPatternsApp());
}

class DesignPatternsApp extends StatelessWidget {
  const DesignPatternsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Design Patterns',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
