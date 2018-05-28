//
//  UIView+Dragable.m
//  ZhongHeBao
//
//  Created by yangyang on 2017/10/9.
//  Copyright © 2017年 zhbservice. All rights reserved.
//

#import "UIView+Dragable.h"
#import <objc/runtime.h>

static void *apx_dragablePanGesture_identifier = &apx_dragablePanGesture_identifier;

@implementation UIView (Dragable)

- (void)addDragableActionWithEnd:(void (^)(CGRect endFrame))endBlock {
    // 添加拖拽手势
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanAction:)];
    [self addGestureRecognizer:panGestureRecognizer];
    
    objc_setAssociatedObject(self, apx_dragablePanGesture_identifier, endBlock, OBJC_ASSOCIATION_COPY);
}

- (void)handlePanAction:(UIPanGestureRecognizer *)sender {
    CGPoint translation = [sender translationInView:[sender.view superview]];

    CGFloat senderHalfViewWidth = sender.view.width / 2;
    CGFloat senderHalfViewHeight = sender.view.height / 2;

    CGFloat centerX = sender.view.center.x + translation.x;
    CGFloat centerY = sender.view.center.y + translation.y;
    __block CGPoint viewCenter = CGPointMake(centerX, centerY);
    
    if (sender.state == UIGestureRecognizerStateEnded) {
        if (centerX > [sender.view superview].width / 2) {
            viewCenter.x = [sender.view superview].width - senderHalfViewWidth;
        } else {
            viewCenter.x = senderHalfViewWidth;
        }
        if ((centerX - senderHalfViewWidth) <= 12) {
            viewCenter.x = senderHalfViewWidth;
        }
        if ((centerX + senderHalfViewWidth) >= ([sender.view superview].width - 12)) {
            viewCenter.x = [sender.view superview].width - senderHalfViewWidth;
        }
        [UIView animateWithDuration:0.4 animations:^{
            sender.view.center = viewCenter;
        } completion:^(BOOL finished) {
            void (^endBlock)(CGRect endFrame) = objc_getAssociatedObject(self, apx_dragablePanGesture_identifier);
            if (endBlock) {
                endBlock(sender.view.frame);
            }
        }];
        [sender setTranslation:CGPointMake(0, 0) inView:[sender.view superview]];
    } else {
        if (sender.view.dragableModel == APXDragableModelOne) {
            if (centerY - senderHalfViewHeight <= UIScreen.navigationBarHeight) {
                viewCenter.y = senderHalfViewHeight + UIScreen.navigationBarHeight;
            }
        } else if (sender.view.dragableModel == APXDragableModelTwo) {
            if (centerY - senderHalfViewHeight <= UIScreen.navigationBarHeight + 38) {
                viewCenter.y = senderHalfViewHeight + UIScreen.navigationBarHeight + 38;
            }
        }
        if (centerY + senderHalfViewHeight >= [sender.view superview].height) {
            viewCenter.y = [sender.view superview].height - senderHalfViewHeight;
        }
        sender.view.center = viewCenter;
        [sender setTranslation:CGPointMake(0, 0) inView:[sender.view superview]];
    }
}

- (void)setDragableModel:(APXDragableModel)dragableModel {
    objc_setAssociatedObject(self, @selector(dragableModel), @(dragableModel), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (APXDragableModel)dragableModel {
    return [objc_getAssociatedObject(self, _cmd) integerValue];
}

@end
