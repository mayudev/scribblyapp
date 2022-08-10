import 'package:flutter/material.dart';
import 'package:scribbly/types/novel.dart';
import 'package:scribbly/widgets/error_screen.dart';
import 'package:scribbly/widgets/result_card.dart';

class Results extends StatelessWidget {
  const Results({Key? key, required this.snapshot}) : super(key: key);

  final AsyncSnapshot<List<NovelResult>> snapshot;

  @override
  Widget build(BuildContext context) {
    if (snapshot.hasError) {
      return const Center(child: ErrorScreen());
    } else if (snapshot.hasData) {
      return ListView.builder(
        itemCount: snapshot.data!.length,
        itemBuilder: ((context, index) =>
            ResultCard(data: snapshot.data![index])),
      );
    } else {
      return const Center(child: CircularProgressIndicator());
    }
  }
}
