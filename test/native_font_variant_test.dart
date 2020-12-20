import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:native_font/src/native_font_variant.dart';

void main() {
  test('toString', () {
    const NativeFontVariant variant = NativeFontVariant(
        fontWeight: FontWeight.w100, fontStyle: FontStyle.normal);
    expect(variant.toString(), '100normal');

    const NativeFontVariant variant2 = NativeFontVariant(
        fontWeight: FontWeight.w400, fontStyle: FontStyle.italic);
    expect(variant2.toString(), '400italic');
  });
}
