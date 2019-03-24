#import "AdmobUtilPlugin.h"

@implementation AdmobUtilPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"admob_util"
            binaryMessenger:[registrar messenger]];
  AdmobUtilPlugin* instance = [[AdmobUtilPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"isTestDevice" isEqualToString:call.method]) {
    result([NSNumber numberWithBool:NO]);
  } else {
    result(FlutterMethodNotImplemented);
  }
}

@end
