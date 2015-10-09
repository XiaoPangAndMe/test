//
//  UIView+AlertView.m
//  AiDingDing
//
//  Created by libohao on 14/11/21.
//  Copyright (c) 2014年 bestapp. All rights reserved.
//

#import "UIViewController+AlertView.h"
#import "AppConfig.h"

@implementation UIViewController (AlertView)

-(void)showAlertView:(NSString*)titleStr LeftTitle:(NSString*)leftTitle otherBtn:(NSString*)otherStr
             Message:(NSString*)text
           CancelSel:(SEL)canSel OKSel:(SEL)okSel
{

    UIView* _confirmView = [[UIView alloc]initWithFrame:self.view.bounds];
    _confirmView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.5];
    
    CGRect rect = [UIScreen mainScreen].bounds;
    UIView* alertView = [[UIView alloc]initWithFrame:CGRectMake(0, rect.size.height - 188, 320, 188)];
    alertView.backgroundColor = UIColorFromRGB(0x242026);
    
    UILabel* title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    title.textAlignment = NSTextAlignmentCenter;
    title.text = titleStr;
    title.textColor = UIColorFromRGB(0xd9d9d9);
    [alertView addSubview:title];
    
    UIView* topLine = [[UIView alloc]initWithFrame:CGRectMake(24, 44, 320 - 48, 1)];
    topLine.backgroundColor = UIColorFromRGB(0xd9d9d9);
    [alertView addSubview:topLine];
    
    UILabel* messageLabel = [[UILabel alloc]initWithFrame:CGRectMake(62, 74, 200, 40)];
    messageLabel.textColor = UIColorFromRGB(0xd9d9d9);;
    messageLabel.font = [UIFont fontWithName:CHINESE_FONT_NAME size:13];
    messageLabel.text = text;
    messageLabel.numberOfLines = 2;
    messageLabel.lineBreakMode = NSLineBreakByCharWrapping;
    messageLabel.textAlignment = NSTextAlignmentCenter;
    [alertView addSubview:messageLabel];
    
    UIButton* cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(0,138, 159, 50)];
    [cancelBtn setTitle:leftTitle forState:UIControlStateNormal];
    [cancelBtn setTitleColor:UIColorFromRGB(0xd9c7b2) forState:UIControlStateNormal];
    [alertView addSubview:cancelBtn];
    [cancelBtn addTarget:self action:canSel forControlEvents:UIControlEventTouchUpInside];
    
    UIButton* okBtn = [[UIButton alloc]initWithFrame:CGRectMake(159,138, 160, 50)];
    [okBtn setTitle:otherStr forState:UIControlStateNormal];
    [okBtn setTitleColor:UIColorFromRGB(0xd9c7b2) forState:UIControlStateNormal];
    [alertView addSubview:okBtn];
    [okBtn addTarget:self action:okSel forControlEvents:UIControlEventTouchUpInside];
    
    
    
    [self.view addSubview:_confirmView];
    _confirmView.tag = 20000;
    
    UIView* line3 = [[UIView alloc]initWithFrame:CGRectMake(159, alertView.frame.size.height - 34, 0.5, 19)];
    line3.backgroundColor = UIColorFromRGB(0xd9c7b2);
    [alertView addSubview:line3];
    
    [_confirmView addSubview:alertView];
    
    CGPoint oldPt = alertView.center;
    alertView.center = CGPointMake(oldPt.x, self.view.bounds.size.height + alertView.frame.size.height*0.5);
    
    [UIView animateWithDuration:0.25 animations:^{
        alertView.center = oldPt;
        
    }];
    
    
}

-(void)hideAlertView
{
    UIView* view =  [self.view viewWithTag:20000];
    [view removeFromSuperview];
}
@end
