import 'package:flutter/material.dart';
import 'package:scribbly/types/novel.dart';
import 'package:scribbly/utils/details.dart';
import 'package:scribbly/widgets/error_screen.dart';

class NovelPage extends StatefulWidget {
  const NovelPage({Key? key, required this.title, required this.id})
      : super(key: key);

  final String title;
  final int id;

  @override
  State<NovelPage> createState() => _NovelPageState();
}

class _NovelPageState extends State<NovelPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: FutureBuilder(
        future: parseNovelDetails(widget.id),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: ErrorScreen());
          } else if (snapshot.hasData) {
            var data = snapshot.data as NovelDetails;

            // TODO animation
            if (_currentIndex == 0) {
              return Text(data.details);
            } else {
              return Text('aa');
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Overview'),
          BottomNavigationBarItem(
              icon: Icon(Icons.library_books), label: 'Chapters')
        ],
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
