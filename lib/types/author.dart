import 'package:scribbly/types/novel.dart';

class Author {
  final String? profileUrl;
  final String username;

  Author({required this.profileUrl, required this.username});

  @override
  String toString() {
    return 'Author(profileUrl: $profileUrl, username: $username)';
  }
}

class AuthorDetails extends Author {
  final String? avatarUrl;
  final String? about;

  AuthorDetails({
    super.profileUrl,
    required super.username,
    this.avatarUrl,
    this.about,
  });
}

class AuthorData {
  final AuthorDetails details;
  final List<NovelResult> novels;

  AuthorData({required this.details, required this.novels});
}
