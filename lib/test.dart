import 'package:flutter/material.dart';
import 'package:week_3_blabla_project/screens/test_bla_button_screen.dart';
import 'screens/ride_pref/ride_pref_screen.dart';
import 'theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      // home: Scaffold(body: RidePrefScreen()),
      home: const TestBlaButtonScreen(), // Set the test screen as the home
    );
  }
}
