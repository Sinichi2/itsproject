import 'package:flutter/material.dart';
import 'screens/opening_screen.dart';
import 'components/navigationbar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FLOW',
      home: SplashScreen(),
    );
  }
}
