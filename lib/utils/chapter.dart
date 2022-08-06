import 'package:scribbly/types/chapter.dart';
import 'package:scribbly/utils/scraper.dart';
import 'package:scribbly/utils/util.dart';
import 'package:universal_html/html.dart';

var base = 'https://www.scribblehub.com/read/0/chapter';

Future getChapter(int chapterId) async {
  final page = await scrapePage('$base/$chapterId');

  final title = page.querySelector('.chapter-title')?.text;
  final rawText = page.querySelector('.chp_raw')!;

  final nodes = rawText.childNodes;

  final previousButton = page.querySelector('.btn-prev');
  final nextButton = page.querySelector('.btn-next');

  return ChapterData(
    id: chapterId,
    order: null,
    title: title ?? 'Unknown',
    publishedDate: null,
    rawContents: nodes,
    previousChapterId: parseChapterLink(previousButton),
    nextChapterId: parseChapterLink(nextButton),
  );
}

int? parseChapterLink(Element? element) {
  final href = element?.getAttribute('href');

  if (href == null || href == '#') {
    return null;
  } else {
    final id = getChapterId(href);
    return id;
  }
}
