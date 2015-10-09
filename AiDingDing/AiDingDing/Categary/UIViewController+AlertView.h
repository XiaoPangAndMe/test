//
//  UIView+AlertView.h
//  AiDingDing
//
//  Created by libohao on 14/11/21.
//  Copyright (c) 2014年 bestapp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (AlertView)

-(void)showAlertView:(NSString*)titleStr LeftTitle:(NSString*)leftTitle otherBtn:(NSString*)otherStr
             Message:(NSString*)text
             CancelSel:(SEL)canSel OKSel:(SEL)okSel;
-(void)hideAlertView;

@end
