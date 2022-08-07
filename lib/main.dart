import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:scribbly/pages/home.dart';
import 'package:scribbly/theme.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('settings');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final settings = Hive.box('settings');

  @override
  Widget build(BuildContext context) {
    var listenable = settings.listenable(keys: ['darkMode']);

    return ValueListenableBuilder<Box>(
        valueListenable: listenable,
        builder: (context, box, widget) {
          return MaterialApp(
            title: 'ScribblyApp',
            theme: buildTheme(),
            darkTheme: buildDarkTheme(),
            themeMode: box.get('darkMode', defaultValue: false)
                ? ThemeMode.dark
                : ThemeMode.light,
            home: const HomePage(),
          );
        });
  }
}
