import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/services/message_codec.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:native_font/src/native_font_family_with_variant.dart';
import 'package:native_font/src/native_font_loader.dart';
import 'package:native_font/src/native_font_variant.dart';

List<String> printLog = <String>[];

void overridePrint(Future<void> testFn()) {
  final ZoneSpecification spec =
      ZoneSpecification(print: (_, __, ___, String msg) {
    // Add to log instead of printing to stdout
    printLog.add(msg);
  });
  Zone.current.fork(specification: spec).run(testFn);
}

void main() {
  const BasicMessageChannel<ByteData> channel =
      BasicMessageChannel<ByteData>('com.xuning.native_font', BinaryCodec());

  TestWidgetsFlutterBinding.ensureInitialized();

  final NativeFontLoader loader = NativeFontLoader();

  channel.setMockMessageHandler((ByteData message) async {
    final String jsonString =
        const Utf8Decoder().convert(Uint8List.sublistView(message));
    final Map<String, dynamic> request = Map<String, dynamic>.from(
        jsonDecode(jsonString) as Map<dynamic, dynamic>);
    if (request['familyName'] == 'Test') {
      return ByteData(64);
    } else {
      return null;
    }
  });

  tearDown(() {
    printLog.clear();
    loader.clearCache();
  });

  test('load native font that not exist', () async {
    const NativeFontFamilyWithVariant familyWithVariant =
        NativeFontFamilyWithVariant(
      family: 'Foo',
      nativeFontVariant: NativeFontVariant(
        fontWeight: FontWeight.w100,
        fontStyle: FontStyle.normal,
      ),
    );
    overridePrint(() async {
      await loader.loadFontIfNeeded(familyWithVariant);
      expect(printLog.length, 1);
      expect(
        printLog[0],
        startsWith(
            'Error: Unable to load native font Foo (weight: 100, isItalic: false). Fall back to system font'),
      );
    });
  });

  test('load native font success', () async {
    const NativeFontFamilyWithVariant familyWithVariant =
        NativeFontFamilyWithVariant(
      family: 'Test',
      nativeFontVariant: NativeFontVariant(
        fontWeight: FontWeight.w100,
        fontStyle: FontStyle.normal,
      ),
    );
    overridePrint(() async {
      await loader.loadFontIfNeeded(familyWithVariant);
      expect(printLog.length, 0);
    });
  });
}
