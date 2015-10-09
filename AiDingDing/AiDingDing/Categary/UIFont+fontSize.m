//
//  UIFont+fontSize.m
//  AiDingDing
//
//  Created by libohao on 14/12/31.
//  Copyright (c) 2014年 bestapp. All rights reserved.
//

#import "UIFont+fontSize.h"

@implementation UIFont (fontSize)

+ (UIFont*)fontWithName:(NSString *)fontName minSize:(CGFloat)minSize maxSize:(CGFloat)maxSize constrainedToSize:(CGSize)labelSize forText:(NSString*)text {
    
    UIFont* font = [UIFont fontWithName:fontName size:maxSize];
    
    CGSize constraintSize = CGSizeMake(labelSize.width, MAXFLOAT);
    NSRange range = NSMakeRange(minSize, maxSize);
    
    int fontSize = 0;
    for (NSInteger i = maxSize; i > minSize; i--)
    {
        fontSize = ceil(((float)range.length + (float)range.location) / 2.0);
        
        font = [font fontWithSize:fontSize];
        CGSize size = [text sizeWithFont:font constrainedToSize:constraintSize lineBreakMode:UILineBreakModeWordWrap];
        if (size.height <= labelSize.height)
            range.location = fontSize;
        else
            range.length = fontSize - 1;
        
        if (range.length == range.location)
        {
            font = [font fontWithSize:range.location];
            break;
        }
    }
    
    return font;
}

@end
