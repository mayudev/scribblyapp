import 'package:flutter/material.dart';
import 'package:scribbly/types/novel.dart';

class LibraryModel extends ChangeNotifier {
  List<Novel> _novels = [];

  List<Novel> get novels => _novels;

  void add(Novel novel) {
    _novels.add(novel);
    notifyListeners();
  }
}
