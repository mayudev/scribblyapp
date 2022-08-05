import 'package:scribbly/types/chapter.dart';
import 'package:scribbly/utils/scraper.dart';

var base = 'https://www.scribblehub.com/read/0/chapter';

Future getChapter(int chapterId) async {
  final page = await scrapePage('$base/$chapterId');

  final rawText = page.querySelector('.chp_raw')!;

  final nodes = rawText.childNodes;

  return ChapterData(
      id: chapterId,
      order: null,
      title: null,
      publishedDate: null,
      rawContents: nodes);
}
