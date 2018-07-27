//
//  APXVerifiCodeView.h
//  ZhongHeBao
//
//  Created by 云无心 on 2018/7/27.
//  Copyright © 2018年 zhbservice. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol VerifiCodeViewDelegate <NSObject>

- (void)verifiCodeViewInputCode:(NSString *)code;

@end



@interface APXVerifiCodeView : UIView

@property (weak, nonatomic) id<VerifiCodeViewDelegate> delegate;

//验证码
@property (nonatomic,copy,readonly)NSString *vertificationCode;

- (void)becomeFirstResponder; 

@end
