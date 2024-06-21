import 'package:flutter/material.dart';
import 'package:task_tracker/screens/onboarding.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Tracker',
      theme: ThemeData(primaryColor: const Color(0xFF005CE7)),
      home: const OnboardingScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
