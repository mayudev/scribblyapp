import 'package:flutter/material.dart';
import 'package:scribbly/widgets/chapter/special_element.dart';
import 'package:universal_html/html.dart' as html;

class NodeRenderer extends StatelessWidget {
  const NodeRenderer({Key? key, required this.node}) : super(key: key);

  final html.Element node;

  Widget _wrap(Widget element) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: element,
    );
  }

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
        case 'SPAN':
          if (firstChild.parent?.style.textAlign == 'center') {
            return _wrap(Center(child: Text(node.text!)));
          }
          break;
        case 'DIV':
          if (firstChild.parent?.className == 'wi_authornotes') {
            return SpecialElement(
              tag: '.wi_authornotes_body',
              node: node.parent!,
              title: const Text("Author's note"),
              icon: const Icon(Icons.rate_review),
            );
          } else if (firstChild.parent?.className == 'wi_news') {
            return SpecialElement(
                node: node.parent!,
                tag: '.wi_news_body',
                title: const Text('Announcement'),
                icon: const Icon(Icons.feed));
          }
      }
    }

    return _wrap(
      Text(
        node.text!,
        style: style,
      ),
    );
  }
}
