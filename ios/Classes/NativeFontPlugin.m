#import "NativeFontPlugin.h"

static FontDataHandler _fontDataHandler;

@implementation NativeFontPlugin

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar {
  FlutterBasicMessageChannel *channel = [FlutterBasicMessageChannel messageChannelWithName:@"com.xuning.native_font"
                                                                           binaryMessenger:[registrar messenger]
                                                                                     codec:[FlutterBinaryCodec sharedInstance]];
  [channel setMessageHandler:^(id _Nullable message, FlutterReply _Nonnull callback) {
    if (!message || ![message isKindOfClass:[NSData class]]) {
      return;
    }
    NSError *error;
    NSDictionary *requestInfo = [NSJSONSerialization JSONObjectWithData:message options:kNilOptions error:&error];
    if (error) {
      return;
    }
    NSString *familyName = requestInfo[@"familyName"];
    NSInteger fontWeight = [requestInfo[@"weight"] integerValue];
    BOOL isItalic = [requestInfo[@"isItalic"] boolValue];
    NativeFontPlugin.fontDataHandler(familyName, fontWeight, isItalic, ^(NSData * _Nullable fontData) {
      callback(fontData);
    });
  }];
}

+ (FontDataHandler)fontDataHandler {
  return _fontDataHandler;
}

+ (void)setFontDataHandler:(FontDataHandler)fontDataHandler {
  _fontDataHandler = [fontDataHandler copy];
}

@end
