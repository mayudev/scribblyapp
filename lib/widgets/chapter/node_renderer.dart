import 'package:flutter/material.dart';
import 'package:scribbly/widgets/chapter/author_notes.dart';
import 'package:universal_html/html.dart' as html;

class NodeRenderer extends StatelessWidget {
  const NodeRenderer({Key? key, required this.node}) : super(key: key);

  final html.Element node;

  @override
  Widget build(BuildContext context) {
    var style = const TextStyle();

    if (node.children.isNotEmpty) {
      final firstChild = node.children[0];

      switch (firstChild.nodeName) {
        case 'I':
        case 'EM':
          style = const TextStyle(fontStyle: FontStyle.italic);
          break;
        case 'B':
          style = const TextStyle(fontWeight: FontWeight.bold);
          break;
        case 'DIV':
          if (firstChild.parent?.className == 'wi_authornotes') {
            return AuthorNotes(node: node.parent!);
          }
      }
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        node.text!,
        style: style,
      ),
    );
  }
}
