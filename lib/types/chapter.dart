class Chapter {
  int? order;
  String? title;

  Chapter({required this.order, required this.title});

  @override
  String toString() {
    return 'Chapter(order: $order, title: $title)';
  }
}
