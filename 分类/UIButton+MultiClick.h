//
//  UIButton+MultiClick.h
//  button多次点击
//
//  Created by 云无心 on 2018/5/25.
//  Copyright © 2018年 云无心. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (MultiClick)

/** 按钮重复点击的时间间隔,以秒为单位 **/
- (void)setRepeatEventInterval:(NSTimeInterval)repeatEventInterval;

@end
