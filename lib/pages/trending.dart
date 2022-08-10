import 'package:flutter/material.dart';
import 'package:scribbly/types/novel.dart';
import 'package:scribbly/utils/scraper/search.dart';
import 'package:scribbly/widgets/results.dart';

class TrendingPage extends StatelessWidget {
  const TrendingPage({Key? key}) : super(key: key);

  Future<List<NovelResult>> _getTrending() async {
    return getTrending();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trending'),
      ),
      body: FutureBuilder<List<NovelResult>>(
        future: _getTrending(),
        builder: (context, snapshot) => Results(snapshot: snapshot),
      ),
    );
  }
}
