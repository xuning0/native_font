import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'native_font_family_with_variant.dart';

final NativeFontLoader nativeFontLoader = NativeFontLoader();

class NativeFontLoader {
  static const BasicMessageChannel<ByteData> _channel =
      BasicMessageChannel<ByteData>('com.xuning.native_font', BinaryCodec());

  // Keep track of the fonts that are loaded or currently loading in FontLoader
  // for the life of the app instance. Once a font is attempted to load, it does
  // not need to be attempted to load again, unless the attempted load resulted
  // in an error.
  final Set<String> _loadedFonts = <String>{};

  @visibleForTesting
  void clearCache() {
    _loadedFonts.clear();
  }

  Future<void> loadFontIfNeeded(
      NativeFontFamilyWithVariant familyWithVariant) async {
    final String familyWithVariantString = familyWithVariant.toString();
    // If this font has already already loaded or is loading, then there is no
    // need to attempt to load it again, unless the attempted load results in an
    // error.
    if (_loadedFonts.contains(familyWithVariantString)) {
      return;
    } else {
      _loadedFonts.add(familyWithVariantString);
    }

    final String fontFamily = familyWithVariant.family;
    final int fontWeight =
        (familyWithVariant.nativeFontVariant.fontWeight.index + 1) * 100;
    final bool isItalic =
        familyWithVariant.nativeFontVariant.fontStyle == FontStyle.italic;
    try {
      final Map<String, dynamic> message = <String, dynamic>{
        'familyName': fontFamily,
        'weight': fontWeight,
        'isItalic': isItalic,
      };
      final ByteData requestData =
          ByteData.sublistView(JsonUtf8Encoder().convert(message) as Uint8List);
      final Future<ByteData> fontData = _loadFontFileByteData(requestData);
      if (await fontData != null) {
        final FontLoader fontLoader = FontLoader(familyWithVariantString);
        fontLoader.addFont(fontData);
        fontLoader.load();
      } else {
        print(
            'Error: Unable to load native font $fontFamily (weight: $fontWeight, isItalic: $isItalic). Fall back to system font');
      }
    } catch (e) {
      _loadedFonts.remove(familyWithVariantString);
      print(
          'Error: Unable to load native font $fontFamily (weight: $fontWeight, isItalic: $isItalic) because the '
          'following exception occured:\n$e');
    }
  }

  Future<ByteData> _loadFontFileByteData(ByteData data) async {
    final ByteData fontData = await _channel.send(data);
    return fontData;
  }
}
