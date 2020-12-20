# native_font

A Flutter plugin to load font files from native end, supporting ttf and otf formats. Many codes are inspired by [google_fonts](https://pub.dev/packages/google_fonts).

## Installation

To use this plugin, add `native_font` as a dependency in your pubspec.yaml file.

```yaml
dependencies:
  native_font: <latest version>
```

## Usage

First, register the font file data handler that can be used by Flutter on the native end as soon as possible.

- iOS

```objc
NativeFontPlugin.fontDataHandler = ^(NSString * _Nonnull familyName, FlutterFontWeight weight, BOOL isItalic, void (^ _Nonnull callback)(NSData * _Nullable)) {
  if ([familyName isEqualToString:@"Roboto"]) {
    NSString *fileName = @"Roboto-Regular.ttf";
    if (weight == FlutterFontWeight700) {
      fileName = isItalic ? @"Roboto-BoldItalic.ttf" : @"Roboto-Bold.ttf";
    } else if (weight == FlutterFontWeight400) {
      fileName = isItalic ? @"Roboto-Italic.ttf" : @"Roboto-Regular.ttf";
    } else if (weight == FlutterFontWeight500) {
      fileName = @"Roboto-Medium.ttf";
    }
    callback([NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:fileName ofType:nil]]);
  } else if ([familyName isEqualToString:@"Caveat"]) {
    // ...
  }
};
```

- Android

```java
NativeFontPlugin.setFontDataHandler((familyName, fontWeight, isItalic, fontCallBack) -> {
    if (familyName.equals("Roboto")) {
        int familyId = R.font.roboto_regular;
        if (fontWeight == FontStyle.FONT_WEIGHT_BOLD) { //700
            familyId = isItalic ? R.font.roboto_bold_italic : R.font.roboto_bold;
        } else if (fontWeight == FontStyle.FONT_WEIGHT_NORMAL) {
            familyId = isItalic ? R.font.roboto_italic : R.font.roboto_regular;
        } else if (fontWeight == FontStyle.FONT_WEIGHT_MEDIUM) {
            familyId = R.font.roboto_medium;
        }
        fontCallBack.onFontLoadCompleted(fontResToByteBuffer(familyId));
    } else if (familyName.equals("Caveat")) {
        // ...
    }
});
```

Then you can use `nativeFontTextStyle` on the Flutter end.

```dart
Text(
  'Foo',
  style: nativeFontTextStyle(
    fontFamily: 'Cardo',
    fontSize: 30,
  ),
),
```

## Notes

### About font weight

A font generally uses a ninth-order ordered value of 100~900 to divide its weight (the thickness of the font), and normal is equivalent to 400, and bold is equivalent to 700. In many cases, some general word descriptions are used to divide their weight. Common weight values roughly correspond to the word weight description words:

- 100 - Thin
- 200 - Extra Light (Ultra Light)
- 300 - Light
- 400 - Regular (Normal、Book、Roman)
- 500 - Medium
- 600 - Semi Bold (Demi Bold)
- 700 - Bold
- 800 - Extra Bold (Ultra Bold)
- 900 - Black (Heavy)

These words are included in the naming of regular font files. Why is it roughly corresponding? There are differences in some fonts. It may be 100 for Ultra Light, 200 for Thin, and 800 for Heavy.

### Fallback

When the unregistered font on the native end is used on the Flutter end or the callback font data cannot be loaded correctly, it will fall back to the default font and the text will always be displayed.

### Asynchronous loading

Thanks to the powerful [FontLoader](https://api.flutter.dev/flutter/services/FontLoader-class.html) function, the text will be automatically refreshed when the font data is called back to the flutter end.
