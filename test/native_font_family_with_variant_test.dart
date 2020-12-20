import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:native_font/src/native_font_family_with_variant.dart';
import 'package:native_font/src/native_font_variant.dart';

void main() {
  test('toString', () {
    const NativeFontVariant variant = NativeFontVariant(
        fontWeight: FontWeight.w100, fontStyle: FontStyle.normal);
    const NativeFontFamilyWithVariant familyWithVariant =
        NativeFontFamilyWithVariant(family: 'Foo', nativeFontVariant: variant);
    expect(familyWithVariant.toString(), 'Foo_100normal');
  });
}
