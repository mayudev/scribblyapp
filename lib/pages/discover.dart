import 'package:flutter/material.dart';
import 'package:scribbly/pages/trending.dart';
import 'package:scribbly/types/home_page.dart';
import 'package:scribbly/types/novel.dart';
import 'package:scribbly/utils/scraper/trending.dart';
import 'package:scribbly/widgets/error_screen.dart';
import 'package:scribbly/widgets/library_card.dart';

class DiscoverPage extends StatelessWidget {
  const DiscoverPage({Key? key}) : super(key: key);

  Future<HomePageContents> _getTrending() async {
    return getHomePage();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _getTrending(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: ErrorScreen());
          } else if (snapshot.hasData) {
            final data = snapshot.data as HomePageContents;

            return ListView(
              children: [
                ListTile(
                  leading: const Icon(Icons.trending_up),
                  title: const Text('Trending'),
                  trailing: TextButton.icon(
                      onPressed: () => _openTrending(context),
                      icon: const Icon(Icons.more_horiz),
                      label: const Text('More')),
                ),
                _buildGridOf(data.trending),
                const ListTile(title: Text('Latest')),
                _buildGridOf(data.latest),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }

  void _openTrending(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const TrendingPage()));
  }

  Widget _buildGridOf(List<Novel> novels) {
    return GridView.count(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      crossAxisCount: 3,
      childAspectRatio: 0.6,
      children: novels.map((value) => LibraryCard(data: value)).toList(),
    );
  }
}
