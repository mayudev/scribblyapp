import 'dart:collection';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'package:scribbly/models/library.dart';
import 'package:scribbly/pages/reader.dart';
import 'package:scribbly/types/chapter.dart';
import 'package:scribbly/types/novel.dart';

const cardMargin = EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0);

class Details extends StatefulWidget {
  const Details({Key? key, required this.data}) : super(key: key);

  final NovelData data;

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  bool reversed = false;

  UnmodifiableListView<Chapter> get chapterList => UnmodifiableListView(
      reversed ? widget.data.chapters.reversed : widget.data.chapters);

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      thumbVisibility: true,
      interactive: true,
      thickness: 10.0,
      radius: const Radius.circular(8.0),
      child: ListView(
        children: [
          _titleCard(),
          _synopsisCard(),
          _chaptersCard(),
        ],
      ),
    );
  }

  Card _titleCard() {
    return Card(
        margin: cardMargin,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      widget.data.details.coverUrl,
                      width: 120.0,
                    ),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 4.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.data.details.title,
                          style: const TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                        Text(
                          widget.data.details.author.username,
                          style: const TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        Text(
                          '${widget.data.details.views} views\n${widget.data.details.chapters} chapters',
                          style: const TextStyle(
                            fontSize: 13.0,
                            height: 1.5,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(padding: const EdgeInsets.all(8.0), child: _actionRow())
          ],
        ));
  }

  Widget _actionRow() {
    return Wrap(
      spacing: 12.0,
      children: [
        _buildLibraryButton(),
        OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.book),
            label: const Text('Start reading')),
      ],
    );
  }

  Widget _buildLibraryButton() {
    var library = context.watch<LibraryModel>();

    if (library.has(widget.data.details.id)) {
      return ElevatedButton.icon(
          onPressed: () => _libraryRemove(library),
          icon: const Icon(Icons.remove),
          label: const Text('In library'));
    } else {
      return OutlinedButton.icon(
          onPressed: () => _libraryAdd(library),
          icon: const Icon(Icons.add),
          label: const Text('Add to library'));
    }
  }

  void _libraryAdd(LibraryModel library) {
    library.add(widget.data.details);

    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Novel added to library!')));
  }

  void _libraryRemove(LibraryModel library) {
    library.remove(widget.data.details);

    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Novel removed from library!')));
  }

  Card _synopsisCard() {
    return Card(
      margin: cardMargin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _cardHeading(Icons.info, 'Synopsis'),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: SelectableText(
              widget.data.details.details.trim(),
              style: const TextStyle(height: 1.5),
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
    return widget.data.details.genres
        .map((genre) => _genreChip(
              label: Text(genre),
            ))
        .toList();
  }

  List<Widget> _tagChips() {
    return widget.data.details.tags
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

  Card _chaptersCard() {
    return Card(
        margin: cardMargin,
        child: Column(
          children: [
            _cardHeading(Icons.bookmark, 'Chapters', trailing: [
              IconButton(
                onPressed: () {
                  _toggleReverse();
                },
                icon: const Icon(Icons.sort),
                tooltip: 'Toggle reverse',
              )
            ]),
            ListView.builder(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemCount: chapterList.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(chapterList[index].title ?? 'Unknown'),
                subtitle: Text(chapterList[index].publishedDate ?? 'Unknown'),
                onTap: () {
                  _pushReader(chapterList[index]);
                },
              ),
            )
          ],
        ));
  }

  void _toggleReverse() {
    setState(() {
      reversed = !reversed;
    });
  }

  void _pushReader(Chapter chapter) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ReaderPage(chapter: chapter)),
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
}
