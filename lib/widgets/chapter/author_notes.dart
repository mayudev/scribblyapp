import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:universal_html/html.dart' as html;

class AuthorNotes extends StatelessWidget {
  const AuthorNotes({Key? key, required this.node}) : super(key: key);

  final html.Element node;

  @override
  Widget build(BuildContext context) {
    final contents = node
            .querySelector('.wi_authornotes_body')
            ?.innerText
            .trim()
            .replaceAll("\n", "\n\n") ??
        '';

    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ListView(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        children: [
          const ListTile(
            leading: Icon(Icons.rate_review),
            title: Text("Author's note"),
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
