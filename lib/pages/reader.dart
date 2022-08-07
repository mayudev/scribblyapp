import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:scribbly/types/chapter.dart';
import 'package:scribbly/utils/chapter.dart';
import 'package:scribbly/widgets/chapter_renderer.dart';
import 'package:scribbly/widgets/error_screen.dart';
import 'package:scribbly/widgets/reader_settings.dart';

class ReaderPage extends StatelessWidget {
  const ReaderPage({Key? key, required this.chapter}) : super(key: key);

  final Chapter chapter;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _getChapterData(),
        builder: (context, snapshot) {
          return Scaffold(
            appBar: AppBar(
              title: _renderTitle(snapshot.data),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.public),
                  tooltip: 'Open in web browser',
                ),
                IconButton(
                  onPressed: () {
                    _openSettings(context);
                  },
                  icon: const Icon(Icons.settings),
                  tooltip: 'Reader settings',
                )
              ],
            ),
            body: Builder(
              builder: (context) {
                if (snapshot.hasError) {
                  return const Center(child: ErrorScreen());
                } else if (snapshot.hasData) {
                  final data = snapshot.data as ChapterData;

                  return _readerPage(context, data);
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          );
        });
  }

  Future<void> _openSettings(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (builder) => ValueListenableBuilder<Box>(
            valueListenable: Hive.box('settings').listenable(),
            builder: (context, settings, widget) => ReaderSettings(
                  settings: settings,
                  reader: true,
                )));
  }

  Widget _renderTitle(Object? data) {
    try {
      data = data as ChapterData;
      return Text(data.title ?? 'Chapter');
    } catch (e) {
      return const Text('Chapter');
    }
  }

  Widget _readerPage(BuildContext context, ChapterData data) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ChapterRenderer(nodes: data.rawContents),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  onPressed: data.previousChapterId == null
                      ? null
                      : () => _openChapter(context, data.previousChapterId!),
                  icon: const Icon(Icons.chevron_left),
                  tooltip: 'Previous chapter',
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  onPressed: data.nextChapterId == null
                      ? null
                      : () => _openChapter(context, data.nextChapterId!),
                  icon: const Icon(Icons.chevron_right),
                  tooltip: 'Next chapter',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _openChapter(BuildContext context, int id) {
    final newChapter = Chapter(id: id);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => ReaderPage(chapter: newChapter)));
  }

  Future _getChapterData() {
    return getChapter(chapter.id);
  }
}
