import 'package:scribbly/types/author.dart';
import 'package:scribbly/types/errors.dart';
import 'package:scribbly/types/novel.dart';
import 'package:scribbly/utils/scraper/scraper.dart';
import 'package:universal_html/html.dart';

Future<NovelDetails> getNovelDetails(int novelId) async {
  final page = await scrapePage('$baseUrl$novelId/r/');

  final title = page.querySelector('.fic_title');
  final synopsis = page.querySelector('.wi_fic_desc');
  final cover = page.querySelector('.fic_image img');

  final coverUrl = cover?.getAttribute('src');

  if (title?.text == null || synopsis?.text == null || coverUrl == null) {
    throw MissingDataError();
  }

  // Stats
  final stats = page.querySelectorAll('.st_item');
  final views = parseStat(stats[0]);
  final favorites = parseStat(stats[1]);
  final chapters = parseStat(stats[2]);

  // Rating
  final ratingElement = page.querySelector('#ratefic_user span');
  final rating = parseRating(ratingElement);

  // Genres and tags
  final genresElements = page.querySelectorAll('.fic_genre');
  final tagsElements = page.querySelectorAll('.stag');

  final genres = parseTags(genresElements);
  final tags = parseTags(tagsElements);

  // Author details
  final authorNameElement = page.querySelector('.auth_name_fic');
  final author = parseAuthor(authorNameElement);

  final details = NovelDetails(
    id: novelId,
    title: title!.text!,
    details: synopsis!.text!,
    coverUrl: coverUrl,
    views: views,
    chapters: chapters,
    favorites: favorites,
    rating: rating,
    genres: genres,
    tags: tags,
    author: author,
  );

  return details;
}

String parseStat(Element statElement) {
  return statElement.childNodes[1].text?.trim() ?? 'Unknown';
}

String parseRating(Element? ratingElement) {
  return ratingElement?.childNodes[1].text ?? 'Unknown';
}

List<String> parseTags(List<Element> elements) {
  return elements.map((element) => element.text ?? 'Unknown').toList();
}

Author parseAuthor(Element? authorNameElement) {
  final profileUrl = authorNameElement?.parent?.getAttribute('href');

  return Author(
      profileUrl: profileUrl, username: authorNameElement?.text ?? 'Unknown');
}
