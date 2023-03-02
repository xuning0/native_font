#import "AppDelegate.h"
#import "GeneratedPluginRegistrant.h"
@import native_font;
#import "Runner-Swift.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [GeneratedPluginRegistrant registerWithRegistry:self];
  
  [self configNativeFontForFlutter];
  
//   Swift Usage:
//  [SwiftUsage configNativeFontForFlutterInSwift];
  
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

- (void)configNativeFontForFlutter {
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
      [self mockDownload:^(NSData *data) {
        callback(data);
      }];
    }
  };
}

- (void)mockDownload:(void (^)(NSData *data))completion {
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    completion([NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Caveat-Regular" ofType:@"ttf"]]);
  });
}

@end
