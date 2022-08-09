import 'package:universal_html/html.dart';

class Chapter {
  int id;
  int? order;
  String? title;
  String? publishedDate;

  Chapter({required this.id, this.order, this.title, this.publishedDate});

  @override
  String toString() {
    return 'Chapter(id: $id, order: $order, title: $title, publishedDate: $publishedDate)';
  }
}

class ChapterData extends Chapter {
  List<Element> rawContents;

  int novelId;

  int? previousChapterId;
  int? nextChapterId;

  ChapterData({
    required super.id,
    required super.order,
    required super.title,
    required super.publishedDate,
    required this.rawContents,
    required this.novelId,
    required this.previousChapterId,
    required this.nextChapterId,
  });
}
