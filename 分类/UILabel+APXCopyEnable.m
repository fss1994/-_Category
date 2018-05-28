//
//  UILabel+APXCopyEnable.m
//  ZhongHeBao
//
//  Created by 云无心 on 2017/11/30.
//  Copyright © 2017年 zhbservice. All rights reserved.
//

#import "UILabel+APXCopyEnable.h"

@implementation UILabel (APXCopyEnable)


- (void)attachTapHandler
{
    self.userInteractionEnabled = YES;
    UILongPressGestureRecognizer *gesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self addGestureRecognizer:gesture];
}

//  处理手势相应事件
- (void)handleTap:(UIGestureRecognizer *)gesture {
  
    // 如果已有menu,return
    if ([[UIMenuController sharedMenuController] isMenuVisible]) {
        return;
    }
    [self becomeFirstResponder];
//    UIMenuItem *item = [[UIMenuItem alloc] initWithTitle:@"复制" action:@selector(copyText:)];
//    [[UIMenuController sharedMenuController] setMenuItems:[NSArray arrayWithObject:item]];
//    [[UIMenuController sharedMenuController] setTargetRect:self.bounds inView:self];
//    [[UIMenuController sharedMenuController] setMenuVisible:YES animated:YES];

    [self copyText:nil];
}

//  复制时执行的方法
- (void)copyText:(id)sender {
  
    if([self.intercept respondsToSelector:@selector(labelMenuDidCopyText)]){
        [self.intercept labelMenuDidCopyText];
        return;
    }
        
    UIPasteboard *pBoard = [UIPasteboard generalPasteboard];
    //  因为有时候 label 中设置的是attributedText  而 UIPasteboard 的string只能接受 NSString 类型 所以要做相应的判断
    if (self.text) {
        pBoard.string = self.text;
    } else {
        pBoard.string = self.attributedText.string;
    }
    NSLog(@"%@",pBoard.string);
}


- (BOOL)canBecomeFirstResponder
{
    return [objc_getAssociatedObject(self, @selector(isCopyEnable)) boolValue];
}

- (void)setIsCopyEnable:(BOOL)isCopyEnable
{
    objc_setAssociatedObject(self, @selector(isCopyEnable), [NSNumber numberWithBool:isCopyEnable], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (isCopyEnable) {
        [self attachTapHandler];
        NSLog(@"--------------");
    }
}

- (void)setIntercept:(id<APXLabelCopyIntercept>)intercept
{
    objc_setAssociatedObject(self, @selector(intercept), intercept, OBJC_ASSOCIATION_ASSIGN);
}

- (id<APXLabelCopyIntercept>)intercept
{
    return objc_getAssociatedObject(self, _cmd);
}

- (BOOL)isCopyEnable
{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

@end
