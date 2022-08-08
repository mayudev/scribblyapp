import 'package:flutter/material.dart';
import 'package:scribbly/types/misc.dart';
import 'package:scribbly/types/novel.dart';
import 'package:scribbly/utils/scraper/search.dart';
import 'package:scribbly/widgets/error_screen.dart';
import 'package:scribbly/widgets/result_card.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<NovelResult> results = [];
  LoadingState state = LoadingState.idle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          leading: const Icon(Icons.search, color: Colors.white),
          title: TextField(
            autofocus: true,
            onSubmitted: (query) async {
              setState(() {
                state = LoadingState.loading;
              });

              try {
                final resp = await getSearchResults(query);
                setState(() {
                  results = resp;
                  state = LoadingState.idle;
                });
              } catch (e) {
                setState(() {
                  state = LoadingState.error;
                });
              }
            },
            decoration: const InputDecoration(
              hintText: 'Search...',
              hintStyle: TextStyle(color: Colors.white60),
              border: InputBorder.none,
            ),
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: Builder(builder: (context) {
        if (state == LoadingState.idle) {
          if (results.isEmpty) {
            return const Center(child: Text('Type'));
          } else {
            return ListView.builder(
              itemCount: results.length,
              itemBuilder: ((context, index) =>
                  ResultCard(data: results[index])),
            );
          }
        } else if (state == LoadingState.loading) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return const Center(child: ErrorScreen());
        }
      }),
    );
  }
}
