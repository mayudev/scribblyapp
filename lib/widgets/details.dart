import 'package:flutter/material.dart';
import 'package:scribbly/types/novel.dart';

const cardMargin = EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0);

class Details extends StatelessWidget {
  const Details({Key? key, required this.data}) : super(key: key);

  final NovelData data;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Card(
            margin: cardMargin,
            child: Column(
              children: [
                Image.network(
                  data.details.coverUrl,
                  height: 220.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.details.title,
                        style: const TextStyle(
                          fontSize: 22.0,
                        ),
                      ),
                      Text(data.details.author.username,
                          style: const TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w300,
                          ))
                    ],
                  ),
                ),
              ],
            )),
        _synopsisCard(),
        _chaptersCard(),
      ],
    );
  }

  Card _synopsisCard() {
    return Card(
      margin: cardMargin,
      child: Column(
        children: [
          _cardHeading(Icons.info, 'Synopsis'),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: SelectableText(
              data.details.details.trim(),
              style: const TextStyle(height: 1.5),
            ),
          ),
        ],
      ),
    );
  }

  Card _chaptersCard() {
    return Card(
        margin: cardMargin,
        child: Column(
          children: [
            _cardHeading(Icons.bookmark, 'Chapters'),
            ListView.builder(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemCount: data.chapters.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(data.chapters[index].title ?? 'Unknown'),
                subtitle: Text(data.chapters[index].publishedDate ?? 'Unknown'),
                onTap: () {},
              ),
            )
          ],
        ));
  }

  Widget _cardHeading(IconData icon, String text) {
    return ListTile(
      leading: Icon(icon),
      title: Text(text),
    );
  }
}
