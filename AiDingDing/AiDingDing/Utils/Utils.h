//
//  Utils.h
//  AiDingDing
//
//  Created by lzy on 14-9-3.
//  Copyright (c) 2014年 bestapp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Utils : NSObject
+ (void)showMessage:(NSString *)message inView:(UIView *)view;
+ (void)showMessage2:(NSString *)message inView:(UIView *)view;
+ (void)viewToRadius:(UIView *)view;

+(UIImage *)getImageFromView:(UIView *)view;

+(void)printAllFont;

+(void)setStatusBarStyleLight;
+(void)setStatusBarStyleDark;


@end
