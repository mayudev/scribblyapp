String trim(String? input) {
  return input?.trim().split(" ")[0] ?? 'Unknown';
}

String removeParenthesis(String? input) {
  return input?.replaceAll('(', '').replaceAll(')', '') ?? 'Unknown';
}
