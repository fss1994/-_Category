//
//  APXVerifiCodeView.m
//  ZhongHeBao
//
//  Created by 云无心 on 2018/7/27.
//  Copyright © 2018年 zhbservice. All rights reserved.
//

#import "APXVerifiCodeView.h"

#import "APXVerifiCodeLabel.h"

static int const maxInputNum = 6;

@interface APXVerifiCodeView () <UITextFieldDelegate>

// 用于获取键盘输入的内容，实际不显示
@property (nonatomic,strong)UITextField *textField;

// 显示验证码Label
@property (nonatomic,strong) APXVerifiCodeLabel *codeLabel;

//验证码
@property (nonatomic,copy,readwrite)NSString *vertificationCode;
@end


@implementation APXVerifiCodeView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.textField];
        [self insertSubview:self.textField atIndex:0];
        [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.edges.mas_equalTo(UIEdgeInsetsZero);
        }];
        

        self.codeLabel.font = self.textField.font;
        self.codeLabel.maxNum = maxInputNum;
        [self addSubview:self.codeLabel];
        [self.codeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.edges.mas_equalTo(UIEdgeInsetsZero);
        }];

        
        
    }
    return self;
}



#pragma mark ------ UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    // 判断是不是“删除”字符
    if (string.length !=0) {
        //不是“删除”字符
        // 判断验证码/密码的位数是否达到预定的位数
        if (textField.text.length < maxInputNum) {
            self.codeLabel.text = [textField.text stringByAppendingString:string];
            self.vertificationCode = self.codeLabel.text;
            if (self.codeLabel.text.length == maxInputNum) {
                /******* 通过协议将验证码返回当前页面  ******/
                if ([self.delegate respondsToSelector:@selector(verifiCodeViewInputCode:)]){
                    [self.delegate verifiCodeViewInputCode:self.vertificationCode];
                }
            }
            return YES;
        } else {
            return NO;
        }
    } else {
        //是“删除”字符
        self.codeLabel.text = [textField.text substringToIndex:textField.text.length -1];
        self.vertificationCode = self.codeLabel.text;
        return YES;
    }
}


#pragma mark - becomeFirstResponder
-(void)becomeFirstResponder{
    [self.textField becomeFirstResponder];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.textField becomeFirstResponder];
}


#pragma mark - getter
- (UITextField *)textField
{
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.hidden = YES;
        _textField.keyboardType = UIKeyboardTypeNumberPad;
        _textField.delegate = self;
        _textField.font = [UIFont systemFontOfSize:25];
    }
    return _textField;
}

- (UILabel *)codeLabel
{
    if (!_codeLabel) {
        _codeLabel = [[APXVerifiCodeLabel alloc] init];
    }
    return _codeLabel;
}

@end
