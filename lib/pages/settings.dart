import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool darkMode = false;

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  _loadData() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      darkMode = prefs.getBool('dark_mode') ?? false;
    });
  }

  _setProperty(String name, bool value) async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setBool(name, value);
  }

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontFamily: 'Nunito');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: SettingsList(sections: [
        SettingsSection(tiles: [
          SettingsTile.switchTile(
            initialValue: darkMode,
            onToggle: (newValue) {
              setState(() {
                darkMode = !darkMode;
                _setProperty('dark_mode', darkMode);
              });
            },
            leading: const Icon(Icons.dark_mode),
            title: const Text('Dark theme', style: textStyle),
          )
        ])
      ]),
    );
  }
}
