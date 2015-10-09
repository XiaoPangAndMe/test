//
//  UIView+ScreenShot.h
//  AiDingDing
//
//  Created by libohao on 14-10-16.
//  Copyright (c) 2014年 bestapp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ScreenShot)

-(UIImage*)screenShot;
- (UIImage*)screenShotAfterScreenUpdates:(BOOL)update;

@end
