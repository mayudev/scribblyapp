import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const cardMargin = EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0);

ThemeData buildTheme() {
  const primary = Color(0xFF7A50A4);

  var base = ThemeData(fontFamily: 'Nunito');

  return base.copyWith(
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light().copyWith(
      primary: primary,
      secondary: Colors.purple[800]!,
    ),
    primaryColor: primary,
    appBarTheme: const AppBarTheme().copyWith(
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Color(0xFF583A77),
      ),
      backgroundColor: primary,
    ),
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
    appBarTheme: const AppBarTheme().copyWith(
      systemOverlayStyle: const SystemUiOverlayStyle().copyWith(
        statusBarColor: Colors.black,
      ),
    ),
    snackBarTheme: base.snackBarTheme.copyWith(
      backgroundColor: Colors.black,
      contentTextStyle: const TextStyle(color: Colors.white),
    ),
  );
}
