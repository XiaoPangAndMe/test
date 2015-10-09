//
//  UILabel+StringFrame.m
//  zhouzhe
//
//  Created by libohao on 14-10-5.
//  Copyright (c) 2014年 zhouzhe. All rights reserved.
//

#import "UILabel+StringFrame.h"

@implementation UILabel (StringFrame)


- (CGSize)boundingRectWithSize:(CGSize)size
{
    NSDictionary *attribute = @{NSFontAttributeName: self.font};
    
    CGSize retSize = [self.text boundingRectWithSize:size
                                             options:\
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                          attributes:attribute
                                             context:nil].size;
    
    return retSize;
}

- (CGSize)boundingRectWithSize:(CGSize)size Spaing:(CGFloat)spacing
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:spacing];
    
    NSDictionary *attribute = @{NSFontAttributeName: self.font,
                                NSParagraphStyleAttributeName:paragraphStyle
                                
                                };
    
    CGSize retSize = [self.text boundingRectWithSize:size
                                             options:\
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                          attributes:attribute
                                             context:nil].size;
    
    return retSize;
}



@end
