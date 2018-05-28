//
//  UIScreen+Additions.h
//  ZhongHeBao
//
//  Created by yangyang on 2017/9/19.
//  Copyright © 2017年 zhbservice. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScreen (Additions)

@property (nonatomic, readonly) CGSize size;
@property (nonatomic, readonly) CGFloat width;
@property (nonatomic, readonly) CGFloat height;

+ (CGRect)bounds;
+ (CGSize)size;
+ (CGFloat)width;
+ (CGFloat)height;

+ (CGFloat)statusBarHeight;
+ (CGFloat)navigationBarHeight;
+ (CGFloat)safeBottomMargin;
+ (CGFloat)tabBarHeight;

// e.g. 640x1136
+ (NSString *)resolution;

@end
