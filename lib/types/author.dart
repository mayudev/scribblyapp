class Author {
  final String? profileUrl;
  final String username;

  Author({required this.profileUrl, required this.username});

  @override
  String toString() {
    return 'Author(profileUrl: $profileUrl, username: $username)';
  }
}
