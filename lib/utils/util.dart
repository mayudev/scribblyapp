String trim(String? input) {
  return input?.trim().split(" ")[0] ?? 'Unknown';
}

String removeParenthesis(String? input) {
  return input?.replaceAll('(', '').replaceAll(')', '') ?? 'Unknown';
}

int getNovelId(String? url) {
  if (url == null) return 0;

  final uri = Uri.parse(url);
  final id = int.parse(uri.pathSegments[1]);

  return id;
}

int getChapterId(String url) {
  final uri = Uri.parse(url);
  final id = int.parse(uri.pathSegments[3]);

  return id;
}
