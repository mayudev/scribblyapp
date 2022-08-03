import 'package:scribbly/types/author.dart';

class NovelDetails {
  final String title;
  final String details;
  final String coverUrl;
  final String views;
  final String favorites;
  final String chapters;
  final String rating;

  final List<String> genres;
  final List<String> tags;

  final Author author;

  NovelDetails(
      {required this.title,
      required this.details,
      required this.coverUrl,
      required this.views,
      required this.favorites,
      required this.chapters,
      required this.rating,
      required this.genres,
      required this.tags,
      required this.author});

  @override
  String toString() {
    return 'NovelDetails(title: $title, coverUrl: $coverUrl, views: $views, '
        'favorites: $favorites, chapters: $chapters, rating: $rating, genres: ${genres.toString()})'
        'tags: ${tags.toString()}, author: ${author.toString()}';
  }
}
