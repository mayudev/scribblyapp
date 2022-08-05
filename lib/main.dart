import 'package:flutter/material.dart';
import 'package:scribbly/pages/home.dart';
import 'package:scribbly/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ScribblyApp',
      theme: buildTheme(),
      home: const HomePage(),
    );
  }
}
