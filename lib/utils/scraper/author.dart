import 'package:scribbly/types/author.dart';
import 'package:scribbly/types/novel.dart';
import 'package:scribbly/utils/scraper/scraper.dart';
import 'package:scribbly/utils/scraper/search.dart';
import 'package:universal_html/html.dart';

Future<AuthorDetails> getAuthorData(int authorId) async {
  final url = 'https://www.scribblehub.com/profile/$authorId/r/';

  final page = await scrapePage(url);

  final username = page.querySelector('.auth_name_fic')?.text ?? 'Unknown';
  final about = readBio(page.querySelector('.user_bio_profile'));
  final avatar =
      page.querySelector('.fic_useravatar_profile img')?.getAttribute('src');

  return AuthorDetails(
      username: username, about: about, profileUrl: url, avatarUrl: avatar);
}

String? readBio(Element? container) {
  return container?.text;
}

Future<List<NovelResult>> getAuthorNovels(int authorId) async {
  final list = await scrapeAuthorNovels(authorId);

  return parseSearchResults(list);
}
