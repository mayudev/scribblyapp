import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:scribbly/theme.dart';
import 'package:scribbly/types/chapter.dart';
import 'package:scribbly/types/novel.dart';

class DetailsTitleCard extends StatelessWidget {
  const DetailsTitleCard(
      {Key? key, required this.data, required this.onReaderPush})
      : super(key: key);

  final NovelData data;

  final Function(Chapter chapter) onReaderPush;

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: cardMargin,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      data.details.coverUrl,
                      width: 120.0,
                    ),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 4.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data.details.title,
                          style: const TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                        Text(
                          data.details.author.username,
                          style: const TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        Text(
                          '${data.details.views} views\n${data.details.chapters} chapters',
                          style: const TextStyle(
                            fontSize: 13.0,
                            height: 1.5,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
                padding: const EdgeInsets.all(8.0), child: _buildActionRow())
          ],
        ));
  }

  Widget _buildActionRow() {
    return Wrap(
      spacing: 12.0,
      children: [
        ValueListenableBuilder<Box>(
            valueListenable: Hive.box('library').listenable(),
            builder: (context, box, widget) =>
                _buildLibraryButton(context, box)),
        ValueListenableBuilder<Box<int>>(
            valueListenable: Hive.box<int>('state').listenable(),
            builder: (context, box, child) {
              var state = box.get(data.details.id);

              if (state == null) {
                return OutlinedButton.icon(
                    onPressed: () {
                      onReaderPush(data.chapters[0]);
                    },
                    icon: const Icon(Icons.book),
                    label: const Text('Start reading'));
              } else {
                return OutlinedButton.icon(
                    onPressed: () {
                      final lastChapterIndex = data.chapters
                          .indexWhere((element) => element.id == state);

                      if (lastChapterIndex + 1 < data.chapters.length) {
                        onReaderPush(data.chapters[lastChapterIndex + 1]);
                      }
                    },
                    icon: const Icon(Icons.book),
                    label: const Text('Continue reading'));
              }
            }),
      ],
    );
  }

  Widget _buildLibraryButton(BuildContext context, Box library) {
    final exists = library.containsKey(data.details.id);

    if (exists) {
      return ElevatedButton.icon(
          onPressed: () => _libraryRemove(context, library),
          icon: const Icon(Icons.remove),
          label: const Text('In library'));
    } else {
      return OutlinedButton.icon(
          onPressed: () => _libraryAdd(context, library),
          icon: const Icon(Icons.add),
          label: const Text('Add to library'));
    }
  }

  void _libraryAdd(BuildContext context, Box library) {
    library.put(data.details.id, data.details);

    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Novel added to library!')));
  }

  void _libraryRemove(BuildContext context, Box library) {
    library.delete(data.details.id);

    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Novel removed from library!')));
  }
}
