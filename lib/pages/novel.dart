import 'package:flutter/material.dart';
import 'package:scribbly/types/chapter.dart';
import 'package:scribbly/types/novel.dart';
import 'package:scribbly/utils/chapters.dart';
import 'package:scribbly/utils/details.dart';
import 'package:scribbly/widgets/details.dart';
import 'package:scribbly/widgets/error_screen.dart';

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
      appBar: AppBar(title: Text(widget.title)),
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
}
