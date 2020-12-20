import 'package:flutter/material.dart';

import 'package:native_font/native_font.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Native Fonts'),
        ),
        body: Column(
          children: <Widget>[
            Text(
              'Caveat (Download in native after 3s)',
              style: nativeFontTextStyle(
                fontFamily: 'Caveat',
                fontSize: 30,
              ),
            ),
            Text(
              'Roboto',
              style: nativeFontTextStyle(
                fontFamily: 'Roboto',
                fontSize: 30,
              ),
            ),
            Text(
              'Roboto Italic',
              style: nativeFontTextStyle(
                fontFamily: 'Roboto',
                fontSize: 30,
                fontStyle: FontStyle.italic,
              ),
            ),
            Text(
              'Roboto Medium',
              style: nativeFontTextStyle(
                fontFamily: 'Roboto',
                fontSize: 30,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              'Roboto Bold',
              style: nativeFontTextStyle(
                fontFamily: 'Roboto',
                fontSize: 30,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              'Roboto Bold Italic',
              style: nativeFontTextStyle(
                fontFamily: 'Roboto',
                fontSize: 30,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
