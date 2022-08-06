import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scribbly/models/prefs.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontFamily: 'Nunito');
    var prefs = context.watch<PrefsModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: SettingsList(sections: [
        SettingsSection(tiles: [
          SettingsTile.switchTile(
            initialValue: prefs.darkMode,
            activeSwitchColor: Theme.of(context).colorScheme.primary,
            onToggle: (newValue) {
              setState(() {
                prefs.darkMode = !prefs.darkMode;
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
