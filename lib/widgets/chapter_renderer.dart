import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:scribbly/utils/util.dart';
import 'package:scribbly/widgets/chapter/node_renderer.dart';
import 'package:universal_html/html.dart' as html;

class ChapterRenderer extends StatelessWidget {
  const ChapterRenderer({Key? key, required this.nodes}) : super(key: key);

  final List<html.Element> nodes;

  @override
  Widget build(BuildContext context) {
    final paragraphs = nodes
        .where((node) => node.text != null && node.text != '\n')
        .map((node) => NodeRenderer(node: node));

    return ValueListenableBuilder<Box>(
        valueListenable: Hive.box('settings').listenable(),
        builder: (context, box, widget) {
          return DefaultTextStyle(
            style: TextStyle(
              fontFamily: box.get('fontFamily', defaultValue: 'Nunito'),
              color: Theme.of(context).textTheme.bodyMedium!.color,
              height: calculateFontHeight(
                  box.get('fontHeight', defaultValue: 7).toDouble().round()),
              fontSize: box.get('fontSize', defaultValue: 18.0).toDouble(),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: paragraphs.toList(),
              ),
            ),
          );
        });
  }
}
