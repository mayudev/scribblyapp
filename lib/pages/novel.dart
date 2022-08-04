import 'package:flutter/material.dart';
import 'package:scribbly/types/chapter.dart';
import 'package:scribbly/types/novel.dart';
import 'package:scribbly/utils/chapters.dart';
import 'package:scribbly/utils/details.dart';
import 'package:scribbly/widgets/details.dart';
import 'package:scribbly/widgets/error_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class NovelPage extends StatefulWidget {
  const NovelPage({Key? key, required this.title, required this.id})
      : super(key: key);

  final String title;
  final int id;

  @override
  State<NovelPage> createState() => _NovelPageState();
}

class _NovelPageState extends State<NovelPage> {
  Future<NovelData> _getNovelData() async {
    final result = await Future.wait(
        [getNovelDetails(widget.id), getChapterList(widget.id)]);

    return NovelData(
      result[0] as NovelDetails,
      result[1] as List<Chapter>,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
              onPressed: () {
                _openBrowser();
              },
              tooltip: 'Open in browser',
              icon: const Icon(Icons.public))
        ],
      ),
      body: FutureBuilder(
        future: _getNovelData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: ErrorScreen());
          } else if (snapshot.hasData) {
            var data = snapshot.data as NovelData;

            return Details(data: data);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Future<void> _openBrowser() async {
    final url = 'https://www.scribblehub.com/series/${widget.id}';
    await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  }
}
