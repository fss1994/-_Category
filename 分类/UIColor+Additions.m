//
//  UIColor+Additions.m
//  ZhongHeBao
//
//  Created by yangyang on 2017/11/20.
//  Copyright © 2017年 zhbservice. All rights reserved.
//

#import "UIColor+Additions.h"

@implementation UIColor (Additions)

+ (nullable UIColor *)colorWithName:(NSString *)name {
    if (name.length == 0) return nil;
    if (@available(iOS 11.0, *)) {
        return [UIColor colorNamed:name];
    } else {
        return [self colorWithHexString:name];
    }
}

@end
