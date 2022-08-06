import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefsModel extends ChangeNotifier {
  bool _darkMode = false;

  bool get darkMode => _darkMode;

  PrefsModel() {
    _init();
  }

  _init() async {
    final prefs = await SharedPreferences.getInstance();

    _darkMode = prefs.getBool('dark_theme') ?? false;
    notifyListeners();
  }

  set darkMode(bool value) {
    _darkMode = value;
    _setBool('dark_theme', value);

    notifyListeners();
  }

  _setBool(String name, bool value) async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setBool(name, value);
  }
}
