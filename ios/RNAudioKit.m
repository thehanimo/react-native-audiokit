#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(RNAudioKit, NSObject)
RCT_EXTERN_METHOD(trim:(NSString *)file
                  start:(nonnull NSNumber *)start
                  end:(nonnull NSNumber *)end
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject
)

RCT_EXTERN_METHOD(getDuration:(NSString *)file
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject
)
@end
