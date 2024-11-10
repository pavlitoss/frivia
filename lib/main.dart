import 'package:flutter/material.dart';
import 'package:frivia/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Frivia',
        theme: ThemeData(
          fontFamily: "KodeMono",
          scaffoldBackgroundColor: const Color.fromRGBO(31, 31, 31, 1.0),
          useMaterial3: true,
        ),
        home: HomePage());
  }
}
