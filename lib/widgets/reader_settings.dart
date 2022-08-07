import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ReaderSettings extends StatelessWidget {
  const ReaderSettings({Key? key, required this.settings}) : super(key: key);

  final Box settings;

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
          trailing: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.close)),
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
            onChanged: (val) {},
            value: 'Nunito',
            items: const [
              DropdownMenuItem(
                value: 'Nunito',
                child: Text('Nunito'),
              )
            ],
          ),
        )
      ]),
    );
  }
}
