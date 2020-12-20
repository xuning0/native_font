import 'package:flutter/foundation.dart';

import 'native_font_variant.dart';

/// Represents a native font variant in Flutter-specific types.
class NativeFontFamilyWithVariant {
  const NativeFontFamilyWithVariant({
    @required this.family,
    @required this.nativeFontVariant,
  })  : assert(family != null),
        assert(nativeFontVariant != null);

  final String family;
  final NativeFontVariant nativeFontVariant;

  /// Returns a font family name that is modified with additional [fontWeight]
  /// and [fontStyle] descriptions.
  ///
  /// This string is used as a key to store loaded fonts.
  @override
  String toString() => '${family}_$nativeFontVariant';
}
