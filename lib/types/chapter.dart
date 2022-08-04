class Chapter {
  int? order;
  String? title;
  String? publishedDate;

  Chapter(
      {required this.order, required this.title, required this.publishedDate});

  @override
  String toString() {
    return 'Chapter(order: $order, title: $title, publishedDate: $publishedDate)';
  }
}
