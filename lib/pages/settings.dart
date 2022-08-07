import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:scribbly/widgets/reader_settings.dart';
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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ValueListenableBuilder<Box>(
        valueListenable: Hive.box('settings').listenable(),
        builder: (context, box, widget) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SettingsList(
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  sections: [
                    SettingsSection(tiles: [
                      SettingsTile.switchTile(
                        initialValue: box.get('darkMode', defaultValue: false),
                        activeSwitchColor:
                            Theme.of(context).colorScheme.primary,
                        onToggle: (newValue) {
                          box.put('darkMode', newValue);
                        },
                        leading: const Icon(Icons.dark_mode),
                        title: const Text('Dark theme', style: textStyle),
                      ),
                    ])
                  ]),
              ReaderSettings(settings: box, reader: false)
            ],
          );
        },
      ),
    );
  }
}
