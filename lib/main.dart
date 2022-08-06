import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scribbly/models/library.dart';
import 'package:scribbly/models/prefs.dart';
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PrefsModel()),
        ChangeNotifierProvider(create: (context) => LibraryModel())
      ],
      child: Consumer<PrefsModel>(
          builder: (context, value, child) {
            return MaterialApp(
              title: 'ScribblyApp',
              theme: buildTheme(),
              darkTheme: buildDarkTheme(),
              themeMode: value.darkMode ? ThemeMode.dark : ThemeMode.light,
              home: child,
            );
          },
          child: const HomePage()),
    );
  }
}
