import 'package:flutter/material.dart';
import 'package:scribbly/pages/library.dart';
import 'package:scribbly/pages/novel.dart';
import 'package:scribbly/pages/search.dart';
import 'package:scribbly/pages/settings.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with RestorationMixin {
  final RestorableInt _index = RestorableInt(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ScribblyApp'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const SearchPage()));
            },
            icon: const Icon(Icons.search),
            tooltip: 'Search',
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SettingsPage()));
            },
            icon: const Icon(Icons.settings),
            tooltip: 'Settings',
          )
        ],
      ),
      body: IndexedStack(
        index: _index.value,
        children: _pages(),
      ),
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }

  List<Widget> _pages() {
    return [
      const LibraryPage(),
      const Text('page 2'),
    ];
  }

  Widget _buildBottomNavigation() {
    return BottomNavigationBar(
        currentIndex: _index.value,
        onTap: (i) => setState(() => _index.value = i),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.collections_bookmark),
            label: 'Library',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Discover',
          ),
        ]);
  }

  void _openNovelPage(BuildContext context, String title, int novelId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NovelPage(title: title, id: novelId),
      ),
    );
  }

  @override
  String get restorationId => 'home_page';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_index, 'nav_bar_index');
  }
}
