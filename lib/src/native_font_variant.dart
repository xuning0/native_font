import 'dart:ui';

/// Represents a native font variant in Flutter-specific types.
class NativeFontVariant {
  const NativeFontVariant({
    required this.fontWeight,
    required this.fontStyle,
  });

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
