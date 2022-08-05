import 'package:scribbly/types/chapter.dart';
import 'package:scribbly/utils/scraper.dart';
import 'package:scribbly/utils/util.dart';
import 'package:universal_html/html.dart';

var listUrl = 'https://www.scribblehub.com/wp-admin/admin-ajax.php';

Future<List<Chapter>> getChapterList(int novelId) async {
  final list = await scrapeChapterList(listUrl, novelId);

  final chapterElements = list.querySelectorAll('.toc_w').reversed;
  final chapters = parseChapters(chapterElements);

  return chapters;
}

List<Chapter> parseChapters(Iterable<Element> elements) {
  final chapters = elements.map((element) {
    final orderAttr = element.getAttribute('order');
    final order = orderAttr != null ? int.tryParse(orderAttr) : null;

    final linkElement = element.querySelector('A')!;

    final title = linkElement.text;
    final id = getChapterId(linkElement.getAttribute('href')!);
    final published = element.querySelector('.fic_date_pub')?.text;

    return Chapter(
        id: id, order: order, title: title, publishedDate: published);
  });

  return chapters.toList();
}
