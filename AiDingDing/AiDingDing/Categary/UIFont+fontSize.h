//
//  UIFont+fontSize.h
//  AiDingDing
//
//  Created by libohao on 14/12/31.
//  Copyright (c) 2014年 bestapp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (fontSize)
+ (UIFont*)fontWithName:(NSString *)fontName minSize:(CGFloat)minSize maxSize:(CGFloat)maxSize constrainedToSize:(CGSize)labelSize forText:(NSString*)text ;

@end
