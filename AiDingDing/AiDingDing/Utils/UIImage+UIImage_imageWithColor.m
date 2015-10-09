//
//  UIImage+UIImage_imageWithColor.m
//  allinns_business
//
//  Created by libohao on 14-8-13.
//  Copyright (c) 2014年 bestapp. All rights reserved.
//

#import "UIImage+UIImage_imageWithColor.h"

@implementation UIImage (UIImage_imageWithColor)

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
