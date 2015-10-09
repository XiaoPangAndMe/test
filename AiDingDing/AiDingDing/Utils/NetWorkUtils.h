//
//  NetWorkUtils.h
//  AiDingDing
//
//  Created by libohao on 15/1/5.
//  Copyright (c) 2015年 bestapp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>

@interface NetWorkUtils : NSObject
+ (NetWorkUtils *)instance;

-(BOOL)netWorkEnable;

-(BOOL)is2GNetWork;

- (BOOL) IsEnableWIFI;
- (BOOL) IsEnable3G ;


@property CTTelephonyNetworkInfo *networkInfo;

@end
