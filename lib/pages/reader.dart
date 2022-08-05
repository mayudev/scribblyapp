import 'package:flutter/material.dart';
import 'package:scribbly/types/chapter.dart';
import 'package:scribbly/utils/chapter.dart';
import 'package:scribbly/widgets/chapter_renderer.dart';
import 'package:scribbly/widgets/error_screen.dart';

class ReaderPage extends StatelessWidget {
  const ReaderPage({Key? key, required this.chapter}) : super(key: key);

  final Chapter chapter;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(chapter.title ?? 'Chapter'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.public),
            tooltip: 'Open in web browser',
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings),
            tooltip: 'Reader settings',
          )
        ],
      ),
      body: FutureBuilder(
        future: _getChapterData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: ErrorScreen());
          } else if (snapshot.hasData) {
            final data = snapshot.data as ChapterData;

            return ChapterRenderer(nodes: data.rawContents);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Future _getChapterData() {
    return getChapter(chapter.id);
  }
}
