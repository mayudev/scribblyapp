import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scribbly/models/library.dart';
import 'package:scribbly/widgets/library_card.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
            'library')); /* Consumer<LibraryModel>(
      builder: (context, value, child) => GridView.count(
          crossAxisCount: 3,
          childAspectRatio: 0.6,
          children:
              value.novels.map((novel) => LibraryCard(data: novel)).toList()),
    ); */
  }
}
