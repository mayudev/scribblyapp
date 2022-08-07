import 'package:flutter/material.dart';
import 'package:scribbly/types/novel.dart';

class LibraryModel extends ChangeNotifier {
  List<Novel> _novels = [];

  List<Novel> get novels => _novels;

  void add(Novel novel) {
    _novels.add(novel);
    notifyListeners();
  }

  void remove(Novel novel) {
    _novels.removeWhere((element) => element.id == novel.id);
    print(_novels.length);
    notifyListeners();
  }

  bool has(int novelId) {
    try {
      _novels.firstWhere((element) => element.id == novelId);
      return true;
    } on StateError {
      return false;
    }
  }
}
