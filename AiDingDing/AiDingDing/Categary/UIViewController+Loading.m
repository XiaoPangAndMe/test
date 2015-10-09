//
//  UIViewController+Loading.m
//  AiDingDing
//
//  Created by libohao on 14/11/6.
//  Copyright (c) 2014年 bestapp. All rights reserved.
//

#import "UIViewController+Loading.h"
#import "MBProgressHUD.h"
@implementation UIViewController (Loading)


-(void)startLoading
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

-(void)stopLoading
{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}


@end
