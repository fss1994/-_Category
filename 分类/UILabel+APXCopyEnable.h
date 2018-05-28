//
//  UILabel+APXCopyEnable.h
//  ZhongHeBao
//
//  Created by 云无心 on 2017/11/30.
//  Copyright © 2017年 zhbservice. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol APXLabelCopyIntercept <NSObject>

@optional
- (void)labelMenuDidCopyText;

@end

@interface UILabel (APXCopyEnable)

@property (nonatomic, assign) BOOL isCopyEnable;
@property (nonatomic, weak) id <APXLabelCopyIntercept> intercept;

@end
