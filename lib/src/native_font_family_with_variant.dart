import 'native_font_variant.dart';

/// Represents a native font variant in Flutter-specific types.
class NativeFontFamilyWithVariant {
  const NativeFontFamilyWithVariant({
    required this.family,
    required this.nativeFontVariant,
  });

  final String family;
  final NativeFontVariant nativeFontVariant;

  /// Returns a font family name that is modified with additional [fontWeight]
  /// and [fontStyle] descriptions.
  ///
  /// This string is used as a key to store loaded fonts.
  @override
  String toString() => '${family}_$nativeFontVariant';
}
