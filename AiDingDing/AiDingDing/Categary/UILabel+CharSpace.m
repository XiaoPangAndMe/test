//
//  UILabel+CharSpace.m
//  AiDingDing
//
//  Created by libohao on 14/11/28.
//  Copyright (c) 2014年 bestapp. All rights reserved.
//

#import "UILabel+CharSpace.h"

@implementation UILabel (CharSpace)

-(void)setCharSpace:(int)space
{
    NSAttributedString *namelabelattributedString =[[NSAttributedString alloc] initWithString:self.text attributes:@{NSKernAttributeName : @(space)}];
    self.attributedText = namelabelattributedString;
}
@end
