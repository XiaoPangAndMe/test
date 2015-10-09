//
//  UIImageView+UIImageView_ContentScale.m
//  AiDingDing
//
//  Created by libohao on 14/12/20.
//  Copyright (c) 2014年 bestapp. All rights reserved.
//

#import "UIImageView+UIImageView_ContentScale.h"

@implementation UIImageView (UIImageView_ContentScale)

-(CGFloat)imageScaleFactor
{
    CGRect frame = self.bounds;
    
    CGFloat widthScale = self.bounds.size.width / self.image.size.width;
    CGFloat heightScale = self.bounds.size.height / self.image.size.height;
    
    if (self.contentMode == UIViewContentModeScaleToFill) {
        return (widthScale==heightScale) ? widthScale : NAN;
    }
    if (self.contentMode == UIViewContentModeScaleAspectFit) {
        return MIN(widthScale, heightScale);
    }
    if (self.contentMode == UIViewContentModeScaleAspectFill) {
        return MAX(widthScale, heightScale);
    }
    return 1.0;
    
}

@end
