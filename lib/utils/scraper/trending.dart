import 'package:scribbly/types/home_page.dart';
import 'package:scribbly/types/novel.dart';
import 'package:scribbly/utils/scraper/scraper.dart';
import 'package:scribbly/utils/util.dart';
import 'package:universal_html/html.dart';

Future<HomePageContents> getHomePage() async {
  final page = await scrapePage('https://www.scribblehub.com/');

  final carousels = page.querySelectorAll('.new-novels-carousel');

  final trending = parseCarousel(carousels[0]);
  final latest = parseCarousel(carousels[1]);

  return HomePageContents(trending, latest);
}

List<Novel> parseCarousel(Element element) {
  final container = element.querySelectorAll('.novel_carousel_img');

  final novels = container.map((novel) {
    final id = getNovelId(novel.querySelector('a')?.getAttribute('href'));
    final coverUrl = novel.querySelector('img')?.getAttribute('src');
    final title = novel.querySelector('.centered_novel')?.getAttribute('title');

    return Novel(id: id, title: title ?? 'Unknown', coverUrl: coverUrl ?? '');
  });

  return novels.toList();
}
