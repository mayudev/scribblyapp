import 'package:scribbly/types/author.dart';
import 'package:scribbly/types/chapter.dart';

class NovelData {
  final NovelDetails details;
  final List<Chapter> chapters;

  NovelData(this.details, this.chapters);
}

class Novel {
  final String title;
  final String coverUrl;

  Novel({required this.title, required this.coverUrl});
}

class NovelResult extends Novel {
  final String views;
  final String rating;
  final String chapters;

  final Author author;

  NovelResult(
      {required super.title,
      required super.coverUrl,
      required this.views,
      required this.rating,
      required this.author,
      required this.chapters});
}

class NovelDetails extends NovelResult {
  final String details;
  final String favorites;

  final List<String> genres;
  final List<String> tags;

  NovelDetails(
      {required super.title,
      required this.details,
      required super.coverUrl,
      required super.views,
      required this.favorites,
      required super.chapters,
      required super.rating,
      required this.genres,
      required this.tags,
      required super.author});

  @override
  String toString() {
    return 'NovelDetails(title: $title, coverUrl: $coverUrl, views: $views, '
        'favorites: $favorites, chapters: $chapters, rating: $rating, genres: ${genres.toString()})'
        'tags: ${tags.toString()}, author: ${author.toString()}';
  }
}
