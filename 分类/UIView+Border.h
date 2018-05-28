//
//  UIView+Border.h
//  ZhongHeBao
//
//  Created by 云无心 on 2018/1/3.
//  Copyright © 2018年 zhbservice. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Border)

- (void)addBottomBorderWithColor:(UIColor *)color andWidth:(CGFloat)borderWidth;

- (void)addLeftBorderWithColor:(UIColor *)color andWidth:(CGFloat)borderWidth;

- (void)addRightBorderWithColor:(UIColor *)color andWidth:(CGFloat)borderWidth;

- (void)addTopBorderWithColor:(UIColor *)color andWidth:(CGFloat)borderWidth;


@end
