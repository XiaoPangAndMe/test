//
//  UIColor+Random.m
//  AiDingDing
//
//  Created by libohao on 14-10-8.
//  Copyright (c) 2014年 bestapp. All rights reserved.
//

#import "UIColor+Random.h"

@implementation UIColor (Random)


+ (UIColor *)randomColor {
	static BOOL seeded = NO;
	if (!seeded) {
		seeded = YES;
        (time(NULL));
	}
	CGFloat red = (CGFloat)random() / (CGFloat)RAND_MAX;
	CGFloat green = (CGFloat)random() / (CGFloat)RAND_MAX;
	CGFloat blue = (CGFloat)random() / (CGFloat)RAND_MAX;
	return [UIColor colorWithRed:red green:green blue:blue alpha:1.0f];
}


+ (UIColor *) getColor: (NSString *) hexColor

{
	
	unsigned int red, green, blue;
	
	NSRange range;
	
	range.length = 2;
	
	range.location = 0;
	
	[[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&red];
	
	range.location = 2;
	
	[[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&green];
	
	range.location = 4;
	
	[[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&blue];
	
	return [UIColor colorWithRed:(float)(red/255.0f) green:(float)(green/255.0f) blue:(float)(blue/255.0f) alpha:0.35f];
	
}



@end
