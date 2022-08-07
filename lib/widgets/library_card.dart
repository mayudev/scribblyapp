import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:scribbly/pages/novel.dart';
import 'package:scribbly/types/novel.dart';

class LibraryCard extends StatelessWidget {
  const LibraryCard({Key? key, required this.data}) : super(key: key);

  final Novel data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: InkWell(
        onTap: () => _openNovel(context),
        onLongPress: () => _openActionsDialog(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  data.coverUrl,
                  height: 180,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Text(data.title)
          ],
        ),
      ),
    );
  }

  void _openNovel(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => NovelPage(title: data.title, id: data.id)),
    );
  }

  void _openActionsDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) => SimpleDialog(
              title: Text(data.title),
              children: [
                SimpleDialogOption(
                  onPressed: () {
                    Navigator.pop(context);
                    _removeThis();
                  },
                  child: const Text('Remove from library'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                )
              ],
            ));
  }

  void _removeThis() {
    final library = Hive.box('library');
    library.delete(data.id);
  }
}
