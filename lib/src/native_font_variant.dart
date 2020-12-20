import 'dart:ui';

import 'package:flutter/foundation.dart';

/// Represents a native font variant in Flutter-specific types.
class NativeFontVariant {
  const NativeFontVariant({
    @required this.fontWeight,
    @required this.fontStyle,
  })  : assert(fontWeight != null),
        assert(fontStyle != null);

  final FontWeight fontWeight;
  final FontStyle fontStyle;

  /// Converts this [NativeFontVariant] to a specific variant name string, such as '400normal'.
  @override
  String toString() {
    final int fontWeightString = (fontWeight.index + 1) * 100;
    final String fontStyleString = fontStyle.toString().replaceAll('FontStyle.', '');
    return '$fontWeightString$fontStyleString';
  }
}
