//
//  UIButton+CharSpace.m
//  AiDingDing
//
//  Created by libohao on 14/11/28.
//  Copyright (c) 2014年 bestapp. All rights reserved.
//

#import "UIButton+CharSpace.h"

@implementation UIButton (CharSpace)

-(void)setButtonTitleCharSpace:(int)space
{
    NSAttributedString *attributedString =[[NSAttributedString alloc] initWithString:self.titleLabel.text attributes:@{NSKernAttributeName : @(space)}];
    self.titleLabel.attributedText = attributedString;
}
@end
