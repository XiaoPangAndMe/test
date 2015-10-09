//
//  UIImageView+DashLine.m
//  AiDingDing
//
//  Created by libohao on 14/12/22.
//  Copyright (c) 2014年 bestapp. All rights reserved.
//

#import "UIImageView+DashLine.h"

@implementation UIImageView (DashLine)

-(void)createDashLineView
{
    CGRect frame = self.frame;
    //UIImageView *imageView1 = [[UIImageView alloc]initWithFrame:frame];
    
    
    UIGraphicsBeginImageContext(self.frame.size);   //开始画线
    [self.image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);  //设置线条终点形状
    
    
    CGFloat lengths[] = {10,5};
    CGContextRef line = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(line, [UIColor redColor].CGColor);
    
    CGContextSetLineDash(line, 0, lengths, 2);  //画虚线
    CGContextMoveToPoint(line, 0.0, 0.0);    //开始画线
    CGContextAddLineToPoint(line, frame.size.width, 0.0);
    CGContextAddLineToPoint(line, frame.size.width, frame.size.height);
    CGContextAddLineToPoint(line, 0, frame.size.height);
    CGContextAddLineToPoint(line, 0, 0);
    CGContextStrokePath(line);
    
    self.image = UIGraphicsGetImageFromCurrentImageContext();

}

@end
