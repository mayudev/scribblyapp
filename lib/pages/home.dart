import 'package:flutter/material.dart';
import 'package:scribbly/pages/novel.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ScribblyApp')),
      body: Center(
        child: TextButton(
            onPressed: () {
              _openNovelPage(context, "Test Novel", 310493);
            },
            child: const Text('example novel page')),
      ),
    );
  }

  void _openNovelPage(BuildContext context, String title, int novelId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NovelPage(title: title, id: novelId),
      ),
    );
  }
}
