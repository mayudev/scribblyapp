import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:scribbly/types/novel.dart';
import 'package:scribbly/widgets/library_card.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box>(
        valueListenable: Hive.box('library').listenable(),
        builder: (context, box, widget) {
          final libraryMap = box.toMap();

          return GridView.count(
            crossAxisCount: 3,
            childAspectRatio: 0.6,
            children: libraryMap.entries
                .map((value) => LibraryCard(
                      data: value.value as Novel,
                      isLibrary: true,
                    ))
                .toList(),
          );
        });
  }
}
