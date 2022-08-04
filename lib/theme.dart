import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData buildTheme() {
  const primary = Color(0xff684b77);

  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: primary));

  var base = ThemeData(fontFamily: 'Nunito');

  return base.copyWith(
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light().copyWith(
      primary: primary,
      secondary: Colors.red[200]!,
    ),
    primaryColor: primary,
    appBarTheme: const AppBarTheme().copyWith(
        backgroundColor: primary,
        titleTextStyle:
            const TextStyle(fontWeight: FontWeight.w400, fontSize: 20.0)),
  );
}
