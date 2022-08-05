import 'package:scribbly/types/author.dart';
import 'package:scribbly/types/novel.dart';
import 'package:scribbly/utils/scraper.dart';
import 'package:scribbly/utils/util.dart';
import 'package:universal_html/html.dart';

Future<List<NovelResult>> getSearchResults(String query) async {
  final url = 'https://www.scribblehub.com/?s=$query&post_type=fictionposts';

  final page = await scrapePage(url);

  final results = page.querySelectorAll('.search_main_box');
  return parseResults(results);
}

List<NovelResult> parseResults(Iterable<Element> elements) {
  return elements.map(parseResult).toList();
}

NovelResult parseResult(Element element) {
  final titleElement = element.querySelector('.search_title a');
  final id = getNovelId(titleElement?.getAttribute('href'));

  final title = titleElement?.text ?? 'Unknown';

  final cover = element.querySelector('img');

  final coverUrl = cover?.getAttribute('src') ?? 'unknown';
  final stats = element.querySelectorAll('.nl_stat');

  // Stats
  final views = parseStat(stats[0]);
  final chapters = parseStat(stats[2]);

  final rating = element.querySelector('.search_ratings')?.text;
  final ratingValue = removeParenthesis(rating);

  final authorElement = element.querySelector('.a_un_st a');
  final author = Author(
      profileUrl: authorElement?.getAttribute('href'),
      username: authorElement?.text ?? 'Unknown');

  return NovelResult(
      id: id,
      title: title,
      coverUrl: coverUrl,
      views: views,
      rating: ratingValue,
      author: author,
      chapters: chapters);
}

String parseStat(Node node) {
  return trim(node.childNodes[1].text);
}
