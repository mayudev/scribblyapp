import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:scribbly/pages/reader.dart';
import 'package:scribbly/theme.dart';
import 'package:scribbly/types/chapter.dart';
import 'package:scribbly/types/novel.dart';
import 'package:scribbly/utils/read.dart';
import 'package:scribbly/widgets/novel/details_synopsis_card.dart';
import 'package:scribbly/widgets/novel/details_title_card.dart';

class Details extends StatefulWidget {
  const Details({Key? key, required this.data}) : super(key: key);

  final NovelData data;

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  bool reversed = false;

  UnmodifiableListView<Chapter> get chapterList => UnmodifiableListView(
      reversed ? widget.data.chapters.reversed : widget.data.chapters);

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      thumbVisibility: true,
      interactive: true,
      thickness: 10.0,
      radius: const Radius.circular(8.0),
      child: ListView(
        children: [
          DetailsTitleCard(data: widget.data, onReaderPush: _pushReader),
          DetailsSynopsisCard(details: widget.data.details),
          _chaptersCard(),
        ],
      ),
    );
  }

  Widget _chaptersCard() {
    var box = Hive.box<int>('state').listenable();

    return ValueListenableBuilder<Box<int>>(
        valueListenable: box,
        builder: (context, box, child) {
          var progress = box.get(widget.data.details.id);

          return Card(
              margin: cardMargin,
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.bookmark),
                    title: const Text('Chapters'),
                    trailing: Wrap(
                      children: [
                        IconButton(
                          onPressed: () {
                            _toggleReverse();
                          },
                          icon: const Icon(Icons.sort),
                          tooltip: 'Toggle reverse',
                        )
                      ],
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemCount: chapterList.length,
                    itemBuilder: (context, index) =>
                        _buildChapterItem(progress, box, index),
                  )
                ],
              ));
        });
  }

  Widget _buildChapterItem(int? progress, Box<int> box, int index) {
    return ListTile(
      title: Text(chapterList[index].title ?? 'Unknown',
          style: TextStyle(
              color: chapterRead(progress, chapterList[index].id)
                  ? Colors.white38
                  : Colors.white)),
      subtitle: Text(chapterList[index].publishedDate ?? 'Unknown'),
      onTap: () {
        _pushReader(chapterList[index]);
      },
      onLongPress: () {
        _openChapterItemContextMenu(progress, box, index);
      },
    );
  }

  void _openChapterItemContextMenu(int? progress, Box<int> box, int index) {
    bool isRead = chapterRead(progress, chapterList[index].id);

    showDialog(
        context: context,
        builder: (context) => SimpleDialog(
              title: Text(chapterList[index].title ?? 'Unknown'),
              children: [
                SimpleDialogOption(
                  onPressed: () {
                    if (isRead) {
                      final realIndex =
                          widget.data.chapters.indexOf(chapterList[index]);
                      if (realIndex != 0) {
                        box.put(widget.data.details.id,
                            widget.data.chapters[realIndex - 1].id);
                      } else {
                        box.delete(widget.data.details.id);
                      }
                    } else {
                      box.put(widget.data.details.id, chapterList[index].id);
                    }
                    Navigator.pop(context);
                  },
                  child: Text('Mark as ${isRead ? 'un' : ''}read'),
                )
              ],
            ));
  }

  void _toggleReverse() {
    setState(() {
      reversed = !reversed;
    });
  }

  void _pushReader(Chapter chapter) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ReaderPage(chapter: chapter)),
    );
  }
}
