//
//  UIView+Blur.m
//  zhouzhe
//
//  Created by libohao on 14-10-16.
//  Copyright (c) 2014年 zhouzhe. All rights reserved.
//

#import "UIView+Blur.h"
#import "UIImage+ImageEffects.h"

@implementation UIView (Blur)

-(void)blurScreen:(BOOL)enable
{
    if (enable) {
        UIToolbar *blurView = [[UIToolbar alloc] initWithFrame:CGRectZero];
        blurView.frame = self.bounds;
        //blurView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        blurView.barStyle = UIBarStyleBlack;
        blurView.translucent = YES;
        blurView.alpha = 0;
        [self addSubview:blurView];
        blurView.tag =10000;
        
        [UIView animateWithDuration:0.4 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0 options:0 animations:^{
            blurView.alpha = 1.0;
        } completion:^(BOOL finished) {
        }];
        
    }else{
        UIView* view = [self viewWithTag:10000];
        
        [UIView animateWithDuration:0.4 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0 options:0 animations:^{
            view.alpha = 0.0;
        } completion:^(BOOL finished) {
            view.hidden = YES;
            [view removeFromSuperview];
        }];
        
        
    }
}

-(void)blurScreen:(BOOL)enable Delay:(CGFloat)delay
{
    if (enable) {
        UIToolbar *blurView = [[UIToolbar alloc] initWithFrame:CGRectZero];
        blurView.frame = self.bounds;
        blurView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        blurView.barStyle = UIBarStyleBlack;
        blurView.translucent = YES;
        blurView.alpha = 0;
        [self addSubview:blurView];
        blurView.tag =10000;
        
        [UIView animateWithDuration:0.4 delay:delay usingSpringWithDamping:1 initialSpringVelocity:0 options:0 animations:^{
            blurView.alpha = 1.0;
        } completion:^(BOOL finished) {
        }];
        
    }else{
        UIView* view = [self viewWithTag:10000];
        
        [UIView animateWithDuration:0.4 delay:delay usingSpringWithDamping:1 initialSpringVelocity:0 options:0 animations:^{
            view.alpha = 0.0;
        } completion:^(BOOL finished) {
            view.hidden = YES;
            [view removeFromSuperview];
        }];
        
        
    }
}


@end
