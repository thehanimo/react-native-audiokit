//
//  RNAudioKit.m
//
//  Created by Hani Mohammed on 02/04/20.
//  Copyright © 2020 Hani Mohammed. All rights reserved.
//

#import <React/RCTBridgeModule.h>
@interface RCT_EXTERN_MODULE(RNAudioKit, NSObject)
RCT_EXTERN_METHOD(trimAudio:(NSString *)file
                  start:(nonnull NSNumber *)start
                  end:(nonnull NSNumber *)end
                    resolver:(RCTPromiseResolveBlock)resolve
                    rejecter:(RCTPromiseRejectBlock)reject
)
@end
