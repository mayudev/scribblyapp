import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData buildTheme() {
  const primary = Color(0xff684b77);

  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: primary));

  var base = ThemeData(fontFamily: 'Nunito');

  return base.copyWith(
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light().copyWith(
      primary: primary,
      secondary: Colors.purple[800]!,
    ),
    primaryColor: primary,
    appBarTheme: const AppBarTheme().copyWith(
        backgroundColor: primary,
        titleTextStyle:
            const TextStyle(fontWeight: FontWeight.w400, fontSize: 20.0)),
  );
}

ThemeData buildDarkTheme() {
  const primary = Color.fromARGB(255, 204, 150, 231);

  var base = ThemeData.dark();

  final textTheme = base.textTheme.apply(fontFamily: 'Nunito');

  return base.copyWith(
    textTheme: textTheme,
    primaryTextTheme: textTheme,
    brightness: Brightness.dark,
    backgroundColor: Colors.black,
    scaffoldBackgroundColor: const Color.fromARGB(255, 33, 33, 33),
    cardColor: const Color.fromARGB(255, 45, 45, 45),
    colorScheme: const ColorScheme.dark().copyWith(
      background: Colors.black,
      primary: primary,
      secondary: primary,
    ),
  );
}
