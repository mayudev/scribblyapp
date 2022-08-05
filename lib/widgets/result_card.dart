import 'package:flutter/material.dart';
import 'package:scribbly/types/novel.dart';

class ResultCard extends StatelessWidget {
  const ResultCard({Key? key, required this.data}) : super(key: key);

  final NovelResult data;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                data.coverUrl,
                height: 130.0,
                width: 81.0,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(data.title,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 18.0,
                        height: 1.6,
                      )),
                  Wrap(spacing: 8.0, children: [
                    _buildChip(
                      label: Text(data.author.username),
                      avatar: const Icon(Icons.person_outline),
                    ),
                    _buildChip(
                      label: Text(data.views),
                      avatar: const Icon(Icons.visibility_outlined),
                    ),
                    _buildChip(
                      label: Text(data.rating),
                      avatar: const Icon(Icons.star_outline),
                    ),
                    _buildChip(
                        label: Text('${data.chapters} chapters'),
                        avatar: const Icon(Icons.library_books_outlined))
                  ]),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildChip({required Widget avatar, required Widget label}) {
    return Chip(
      avatar: avatar,
      label: label,
      backgroundColor: Colors.transparent,
    );
  }
}
