import 'package:flutter/material.dart';
import 'package:lotus/home.dart';
import 'package:lotus/home1.dart';
import 'package:lotus/pages/ai.dart';
import 'package:lotus/pages/meds.dart';
import 'login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lotus',
      debugShowCheckedModeBanner: false,
      home: AI(),
    );
  }
}
