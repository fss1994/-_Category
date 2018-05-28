//
//  UIView+Dragable.h
//  ZhongHeBao
//
//  Created by yangyang on 2017/10/9.
//  Copyright © 2017年 zhbservice. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, APXDragableModel) {
    APXDragableModelOne = 1,
    APXDragableModelTwo = 2,
};

@interface UIView (Dragable)

@property (nonatomic, assign) APXDragableModel dragableModel;

- (void)addDragableActionWithEnd:(void (^)(CGRect endFrame))endBlock;

@end
