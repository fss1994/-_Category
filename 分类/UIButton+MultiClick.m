//
//  UIButton+MultiClick.m
//  button多次点击
//
//  Created by 云无心 on 2018/5/25.
//  Copyright © 2018年 云无心. All rights reserved.
//

#import "UIButton+MultiClick.h"
#import <objc/runtime.h>


static char * const repeatEventIntervalKey  = "APX_repeatEventIntervalKey";
static char * const previousClickTimeKey    = "APX_previousClickTimeKey";


@implementation UIButton (MultiClick)

+ (void)load
{

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        
        Method methodA = class_getInstanceMethod(self , @selector(sendAction:to:forEvent:));
        Method methodB = class_getInstanceMethod(self , @selector(change_sendAction:to:forEvent:));
        
        method_exchangeImplementations(methodA, methodB);
    });
    
}


- (void)change_sendAction:(SEL)action to:(id)target forEvent:(UIEvent*)event
{

    NSTimeInterval time = [[[NSDate alloc] init] timeIntervalSince1970];
    if (time - self.previousClickTime < self.repeatEventInterval) {
        return;
    }
    
    // 如果间隔时间大于0
    if (self.repeatEventInterval > 0) {
        self.previousClickTime = [[[NSDate alloc] init] timeIntervalSince1970];
    }
    // 已在load中与系统的sendAction:to:forEvent:方法交换方法实现，所以下面调用的还是系统的方法
    [self change_sendAction:action to:target forEvent:event];

}

- (void)setRepeatEventInterval:(NSTimeInterval)repeatEventInterval {
    
    objc_setAssociatedObject(self, repeatEventIntervalKey, @(repeatEventInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSTimeInterval)repeatEventInterval {
    
    NSTimeInterval repeatEventIn = (NSTimeInterval)[objc_getAssociatedObject(self, repeatEventIntervalKey) doubleValue];
    
    // 如果外界设置的重复点击的时间间隔大于0，就按照用户设置的去处理，如果用户设置的间隔时间小于或等于0，就按照无间隔处理
    if (repeatEventIn >= 0) {
        return repeatEventIn;
    }
    
    return 0.0;
}


- (void)setPreviousClickTime:(NSTimeInterval)previousClickTime {
    
    objc_setAssociatedObject(self, previousClickTimeKey, @(previousClickTime), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (NSTimeInterval)previousClickTime {
    
    NSTimeInterval previousEventTime = [objc_getAssociatedObject(self, previousClickTimeKey) doubleValue];
    if (previousEventTime != 0) {
        
        return previousEventTime;
    }
    
    return 1.0;
}


@end
