//
//  UILabel+StringFrame.h
//  zhouzhe
//
//  Created by libohao on 14-10-5.
//  Copyright (c) 2014年 zhouzhe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (StringFrame)
- (CGSize)boundingRectWithSize:(CGSize)size;
- (CGSize)boundingRectWithSize:(CGSize)size Spaing:(CGFloat)spacing;
@end
