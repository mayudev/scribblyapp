import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:universal_html/html.dart' as html;

class ChapterRenderer extends StatelessWidget {
  const ChapterRenderer({Key? key, required this.nodes}) : super(key: key);

  final List<html.Node> nodes;

  @override
  Widget build(BuildContext context) {
    final paragraphs = nodes
        .where((node) => node.text != null && node.text != '\n')
        .map((node) {
      var style = const TextStyle();
      if (node.firstChild?.nodeName == 'I') {
        style = const TextStyle(fontStyle: FontStyle.italic);
      }

      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          node.text!,
          style: style,
        ),
      );
    });

    return ValueListenableBuilder<Box>(
        valueListenable: Hive.box('settings').listenable(),
        builder: (context, box, widget) {
          print('rebuilding mess');
          return DefaultTextStyle(
            style: TextStyle(
              fontFamily: 'Nunito',
              color: Theme.of(context).textTheme.bodyMedium!.color,
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
