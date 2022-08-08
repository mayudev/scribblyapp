import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:scribbly/pages/home.dart';
import 'package:scribbly/theme.dart';
import 'package:scribbly/types/novel.dart';

void main() async {
  await Hive.initFlutter();

  Hive.registerAdapter(NovelAdapter());
  await Hive.openBox('settings');
  await Hive.openBox('library');
  await Hive.openBox<int>('state');

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
