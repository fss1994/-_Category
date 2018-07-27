//
//  APXVerifiCodeLabel.m
//  ZhongHeBao
//
//  Created by 云无心 on 2018/7/27.
//  Copyright © 2018年 zhbservice. All rights reserved.
//

#import "APXVerifiCodeLabel.h"

@implementation APXVerifiCodeLabel

- (void)setText:(NSString *)text
{
    [self setNeedsDisplay];
    [super setText:text];
}


- (void)drawRect:(CGRect)rect
{
    
//    CGRect rec = CGRectMake(0, 0, 200, 45);
    float width = rect.size.width / self.maxNum;
    float height = rect.size.height;
    
    for (int i = 0; i<self.text.length; i++) {
        
        CGRect tempR = CGRectMake(i*width, 0, width, height);
        // 这里要加密可以用图片
//        UIImage *dotImage = [UIImage imageNamed:@"dot"];
//        // 计算圆点的绘制区域
//        CGPoint securityDotDrawStartPoint =CGPointMake(width * i + (width - dotImage.size.width) /2.0, (tempRect.size.height - dotImage.size.height) / 2.0);
//        // 绘制圆点
//        [dotImage drawAtPoint:securityDotDrawStartPoint];
        
        NSString *charString = [NSString stringWithFormat:@"%c",[self.text characterAtIndex:i]];
        NSDictionary *attr = @{NSFontAttributeName:self.font};
        
        CGSize charSize = [charString sizeWithAttributes:attr];
        CGPoint middlePoint = CGPointMake(width*i + (width - charSize.width)/2, (tempR.size.height - charSize.height)/2);
        [charString drawAtPoint:middlePoint withAttributes:attr];
    }
    
    //绘制底部横线
    for (int k=0; k<self.maxNum; k++) {
        [self drawBottomLineWithRect:rect andIndex:k];
        [self drawSenterLineWithRect:rect andIndex:k];
    }
}
//绘制底部的线条
- (void)drawBottomLineWithRect:(CGRect)rect andIndex:(int)k{

    float width = rect.size.width / (float)self.maxNum;
    float height = rect.size.height;
    //1.获取上下文
    CGContextRef context =UIGraphicsGetCurrentContext();
    //2.设置当前上下问路径
    CGFloat lineHidth =0.25 * 1;
    CGFloat strokHidth =0.5 * 1;
    CGContextSetLineWidth(context, lineHidth);
    
    CGContextSetStrokeColorWithColor(context,[UIColor greenColor].CGColor);//底部颜色
    CGContextSetFillColorWithColor(context,[UIColor greenColor].CGColor);//内容的颜色
    
    CGRect rectangle =CGRectMake(k*width+width/10,height-lineHidth-strokHidth,width-width/5,strokHidth);
    CGContextAddRect(context, rectangle);
    CGContextStrokePath(context);
}
//绘制中间的输入的线条
- (void)drawSenterLineWithRect:(CGRect)rect andIndex:(int)k{
    if ( k==self.text.length ) {
        float width = rect.size.width / self.maxNum;
        float height = rect.size.height;
        //1.获取上下文
        CGContextRef context =UIGraphicsGetCurrentContext();
        CGContextSetLineWidth(context,0.5);
        /****  设置竖线的颜色 ****/
        CGContextSetStrokeColorWithColor(context,[UIColor greenColor].CGColor);//
        CGContextSetFillColorWithColor(context,[UIColor greenColor].CGColor);
        CGContextMoveToPoint(context, width * k + (width -1.0) /2.0, height/5);
        CGContextAddLineToPoint(context,  width * k + (width -1.0) /2.0,height-height/5);
        CGContextStrokePath(context);
    }
}


@end
