import 'package:filimo_app/screens/intro/intro_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ّFilimo',
      theme: ThemeData(
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.green.shade400,
        ),

        primarySwatch: Colors.blue,
      ),
      home: const IntroPage(),
    );
  }
}

