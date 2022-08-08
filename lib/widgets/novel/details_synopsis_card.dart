import 'package:flutter/material.dart';
import 'package:scribbly/theme.dart';
import 'package:scribbly/types/novel.dart';
import 'package:scribbly/widgets/expandable_card.dart';

class DetailsSynopsisCard extends StatefulWidget {
  const DetailsSynopsisCard({Key? key, required this.details})
      : super(key: key);

  final NovelDetails details;

  @override
  State<DetailsSynopsisCard> createState() => _DetailsSynopsisCardState();
}

class _DetailsSynopsisCardState extends State<DetailsSynopsisCard> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final description = widget.details.details.trim();

    return Card(
      margin: cardMargin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _cardHeading(Icons.info, 'Synopsis'),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: SizedBox(
              width: double.infinity,
              child: ExpandableCardContainer(
                isExpanded: isExpanded,
                collapsedChild: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(description.length > 512
                        ? '${description.substring(0, 512)}...'
                        : description),
                    TextButton(
                        onPressed: () {
                          setState(() {
                            isExpanded = true;
                          });
                        },
                        child: const Text('Show more'))
                  ],
                ),
                expandedChild: SelectableText(
                  description,
                  style: const TextStyle(height: 1.5),
                ),
              ),
            ),
          ),
          _cardHeading(Icons.style, 'Genres'),
          _chips(
            child: Row(
              children: _genreChips(),
            ),
          ),
          _cardHeading(Icons.local_offer, 'Tags'),
          _chips(
            child: Row(
              children: _tagChips(),
            ),
          )
        ],
      ),
    );
  }

  Widget _cardHeading(IconData icon, String text,
      {List<Widget> trailing = const []}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(text),
      trailing: Wrap(
        children: trailing,
      ),
    );
  }

  Widget _chips({required Widget child}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: child,
      ),
    );
  }

  List<Widget> _genreChips() {
    return widget.details.genres
        .map((genre) => _genreChip(
              label: Text(genre),
            ))
        .toList();
  }

  List<Widget> _tagChips() {
    return widget.details.tags
        .map((genre) => _genreChip(
              label: Text(genre),
            ))
        .toList();
  }

  Widget _genreChip({label = Widget}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.0),
      child: Chip(
        label: label,
        padding: const EdgeInsets.all(2.0),
        labelStyle: const TextStyle(
          fontSize: 13.0,
        ),
      ),
    );
  }
}
