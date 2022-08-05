import 'package:universal_html/html.dart';

class Chapter {
  int id;
  int? order;
  String? title;
  String? publishedDate;

  Chapter(
      {required this.id,
      required this.order,
      required this.title,
      required this.publishedDate});

  @override
  String toString() {
    return 'Chapter(id: $id, order: $order, title: $title, publishedDate: $publishedDate)';
  }
}

class ChapterData extends Chapter {
  List<Node> rawContents;

  ChapterData({
    required super.id,
    required super.order,
    required super.title,
    required super.publishedDate,
    required this.rawContents,
  });
}
