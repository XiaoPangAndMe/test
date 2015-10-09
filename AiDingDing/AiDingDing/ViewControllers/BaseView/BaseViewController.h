//
//  BaseViewController.h
//  allinns_business
//
//  Created by libohao on 14-7-25.
//  Copyright (c) 2014年 bestapp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

-(void)setTitle:(NSString*)title;

-(void)setLeftBarTitle:(NSString*)title target:(id)target action:(SEL)action;

-(void)setRightBarTitle:(NSString*)title target:(id)target action:(SEL)action;

-(void)setLeftBarImage:(UIImage*)image target:(id)target action:(SEL)action;

-(void)setRightBarImage:(UIImage*)image target:(id)target action:(SEL)action;




@end
