import 'package:flutter/material.dart';

import 'package:universal_html/html.dart' as html;

class SpecialElement extends StatelessWidget {
  const SpecialElement({
    Key? key,
    required this.node,
    required this.tag,
    required this.title,
    required this.icon,
  }) : super(key: key);

  final html.Element node;
  final String tag;
  final Widget title;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    final contents =
        node.querySelector(tag)?.innerText.trim().replaceAll("\n", "\n\n") ??
            '';

    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ListView(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        children: [
          ListTile(
            leading: icon,
            title: title,
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: SelectableText(contents,
                style: const TextStyle(fontSize: 16.0)),
          ),
        ],
      ),
    );
  }
}
