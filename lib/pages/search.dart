import 'package:flutter/material.dart';
import 'package:scribbly/utils/search.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<String> results = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          leading: const Icon(Icons.search, color: Colors.white),
          title: TextField(
            autofocus: true,
            onSubmitted: (query) async {
              final resp = await getSearchResults(query);
              setState(() {
                results = resp;
              });
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
      body: ListView.builder(
        itemCount: results.length,
        itemBuilder: ((context, index) =>
            ListTile(title: Text(results[index]))),
      ),
    );
  }
}
