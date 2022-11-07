import 'package:flutter/material.dart';
import 'package:fizz_buzz_app/src/screens/home.dart';

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'FizzBuzz',
      home: HomePage()
    );
  }
}