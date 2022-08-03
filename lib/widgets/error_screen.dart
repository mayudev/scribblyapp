import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.error,
          size: 48.0,
          color: Colors.red.shade300,
        ),
        const Text(
          'An error has occurred.',
          style: TextStyle(fontSize: 20.0),
        ),
      ],
    );
  }
}
