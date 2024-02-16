import 'package:flutter/material.dart';
import 'package:pitch_pulse_football_world/graphs.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PlayerProgressChart(),
    );
  }
}
