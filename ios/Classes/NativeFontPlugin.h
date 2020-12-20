#import <Flutter/Flutter.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * Common weight values roughly correspond to weight description words:
 *
 * 100 - Thin
 * 200 - Extra Light (Ultra Light)
 * 300 - Light
 * 400 - Regular (Normal、Plain)
 * 500 - Medium
 * 600 - Semi Bold (Demi Bold)
 * 700 - Bold
 * 800 - Extra Bold (Ultra Bold)
 * 900 - Black (Heavy)
 *
 * @discussion Why is it roughly corresponding? There are differences under some fonts. For example, in the division list of font weight description in Adobe Typekit fonts, it lists `Heavy` as 800 instead of 900. In addition, in the Photoshop and Sketch, `Ultra Light` is 100, and `Thin` is 200.
 */
typedef NS_ENUM(NSUInteger, FlutterFontWeight) {
  FlutterFontWeight100 = 100,
  FlutterFontWeight200 = 200,
  FlutterFontWeight300 = 300,
  FlutterFontWeight400 = 400,
  FlutterFontWeight500 = 500,
  FlutterFontWeight600 = 600,
  FlutterFontWeight700 = 700,
  FlutterFontWeight800 = 800,
  FlutterFontWeight900 = 900,
};

typedef void (^FontDataHandler)(NSString *familyName, FlutterFontWeight weight, BOOL isItalic, void (^callback)(NSData * _Nullable fontData));

@interface NativeFontPlugin : NSObject <FlutterPlugin>

@property (nonatomic, copy, class) FontDataHandler fontDataHandler;

@end

NS_ASSUME_NONNULL_END
