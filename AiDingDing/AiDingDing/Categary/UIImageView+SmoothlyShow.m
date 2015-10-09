//
//  UIImageView+SmoothlyShow.m
//  AiDingDing
//
//  Created by libohao on 14/11/29.
//  Copyright (c) 2014年 bestapp. All rights reserved.
//

#import "UIImageView+SmoothlyShow.h"
#import "SDWebImageManager.h"

@implementation UIImageView (SmoothlyShow)

-(void)SmoothlyDownload:(NSString*)url
{
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    
    [manager downloadImageWithURL:[NSURL URLWithString:url] options:SDWebImageLowPriority progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        [NSString stringWithFormat:@"%ld",receivedSize/expectedSize];
        
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        self.image = image;
        self.alpha = 0;
        
        [UIView animateWithDuration:0.5 animations:^{
            self.alpha = 1;
        }];
        
    }];
    
}
@end
