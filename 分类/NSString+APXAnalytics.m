//
//  NSString+APXAnalytics.m
//  APXAnalytics
//
//  Created by yangyang on 24/04/2017.
//  Copyright © 2017 yangyang. All rights reserved.
//

#import "NSString+APXAnalytics.h"

#import "KeyChainStore.h"
#import "APXAnalyticsConstants.h"

@implementation NSString (APXAnalytics)

+ (NSString *)UUIDString {
    static NSString * shareUUIDString = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *uuidString = [KeyChainStore load:kAPXKeyChain];
        if (uuidString == nil || uuidString.length == 0) {
            NSString *UUIDString = [UIDevice currentDevice].identifierForVendor.UUIDString;
            [KeyChainStore save:kAPXKeyChain data:UUIDString];
            uuidString = UUIDString;
        }
        shareUUIDString = [NSString stringWithString:uuidString];
    });
    return shareUUIDString;
}

+ (NSString *)timeStamp {
    NSTimeInterval timeStamp = [[NSDate date] timeIntervalSince1970];
    return [NSString stringWithFormat:@"%lf",timeStamp];
}

@end
