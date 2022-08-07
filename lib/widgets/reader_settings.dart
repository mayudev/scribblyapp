import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ReaderSettings extends StatelessWidget {
  const ReaderSettings({Key? key, required this.settings, required this.reader})
      : super(key: key);

  final Box settings;
  final bool reader;

  @override
  Widget build(BuildContext context) {
    var fontSize = settings.get('fontSize', defaultValue: 18.0).toDouble();

    return SliderTheme(
      data: const SliderThemeData().copyWith(
        trackHeight: 1.0,
      ),
      child: Column(children: [
        ListTile(
          title: const Text('Reader settings'),
          trailing: reader
              ? IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.close))
              : null,
        ),
        ListTile(
          leading: const Icon(Icons.text_fields),
          title: const Text('Font size'),
          trailing: Text('${fontSize.toInt()}'),
        ),
        Slider(
          min: 14.0,
          max: 22.0,
          value: fontSize,
          onChanged: (value) {
            settings.put('fontSize', value.round());
          },
        ),
        ListTile(
          leading: const Icon(Icons.font_download),
          title: const Text('Font'),
          trailing: DropdownButton(
            onChanged: (val) {
              settings.put('fontFamily', val);
            },
            value: settings.get('fontFamily', defaultValue: 'Nunito'),
            items: _buildDropdownItems(),
          ),
        )
      ]),
    );
  }

  List<DropdownMenuItem<String>> _buildDropdownItems() {
    final fonts = [
      'Nunito',
      'PT Sans',
      'Roboto Slab',
      'Roboto',
      'Times New Roman',
    ];

    return fonts
        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
        .toList();
  }
}
