import 'package:scribbly/utils/scraper.dart';
import 'package:universal_html/html.dart';

Future<List<String>> getSearchResults(String query) async {
  final url = 'https://www.scribblehub.com/?s=$query&post_type=fictionposts';

  final page = await scrapePage(url);

  final results = page.querySelectorAll('.search_main_box');
  return parseResults(results);
}

List<String> parseResults(Iterable<Element> elements) {
  return elements
      .map((element) =>
          element.querySelector('.search_title a')?.text ?? 'Unknown')
      .toList();
}
