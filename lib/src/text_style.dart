import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';

import 'native_font_family_with_variant.dart';
import 'native_font_loader.dart';
import 'native_font_variant.dart';

/// Creates a [TextStyle] that uses the [fontFamily] for the requested
/// native font.
///
/// This function has a side effect of loading the font into the [FontLoader]
/// from the native bundle file system.
TextStyle nativeFontTextStyle({
  @required String fontFamily,
  TextStyle textStyle,
  Color color,
  Color backgroundColor,
  double fontSize,
  FontWeight fontWeight,
  FontStyle fontStyle,
  double letterSpacing,
  double wordSpacing,
  TextBaseline textBaseline,
  double height,
  Locale locale,
  Paint foreground,
  Paint background,
  List<Shadow> shadows,
  List<FontFeature> fontFeatures,
  TextDecoration decoration,
  Color decorationColor,
  TextDecorationStyle decorationStyle,
  double decorationThickness,
}) {
  assert(fontFamily != null);

  textStyle ??= const TextStyle();
  textStyle = textStyle.copyWith(
    color: color,
    backgroundColor: backgroundColor,
    fontSize: fontSize,
    fontWeight: fontWeight,
    fontStyle: fontStyle,
    letterSpacing: letterSpacing,
    wordSpacing: wordSpacing,
    textBaseline: textBaseline,
    height: height,
    locale: locale,
    foreground: foreground,
    background: background,
    shadows: shadows,
    fontFeatures: fontFeatures,
    decoration: decoration,
    decorationColor: decorationColor,
    decorationStyle: decorationStyle,
    decorationThickness: decorationThickness,
  );

  final NativeFontVariant variant = NativeFontVariant(
    fontWeight: textStyle.fontWeight ?? FontWeight.w400,
    fontStyle: textStyle.fontStyle ?? FontStyle.normal,
  );
  final NativeFontFamilyWithVariant familyWithVariant = NativeFontFamilyWithVariant(
    family: fontFamily,
    nativeFontVariant: variant,
  );

  nativeFontLoader.loadFontIfNeeded(familyWithVariant);

  return textStyle.copyWith(
    fontFamily: familyWithVariant.toString(),
    fontFamilyFallback: <String>[fontFamily],
  );
}
