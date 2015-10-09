//
//  NetWorkUtils.m
//  AiDingDing
//
//  Created by libohao on 15/1/5.
//  Copyright (c) 2015年 bestapp. All rights reserved.
//

#import "NetWorkUtils.h"
#import "Reachability.h"

@implementation NetWorkUtils

+ (NetWorkUtils *)instance{
    static NetWorkUtils *instance = nil;
    static dispatch_once_t once_t;
    dispatch_once(&once_t, ^{
        instance = [[NetWorkUtils alloc]init];
    });
    return instance;
}

-(NSString*)currentRadioAccessTechnology
{
    if (!_networkInfo) {
        self.networkInfo = [[CTTelephonyNetworkInfo alloc] init];
    }
    //NSLog(@"Initial cell connection: %@", self.networkInfo.currentRadioAccessTechnology);
    return self.networkInfo.currentRadioAccessTechnology;
}

-(BOOL)is2GNetWork
{
    NSString* netWorkStr = [self currentRadioAccessTechnology];
    if ([netWorkStr isEqualToString:@"CTRadioAccessTechnologyGPRS"] || [netWorkStr isEqualToString:@"CTRadioAccessTechnologyEdge"]) {
        return YES;
    }
    return NO;
}

-(BOOL)netWorkEnable
{
    
    Reachability *r = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    
    if (r.currentReachabilityStatus != NotReachable)
    {
        return YES;
    }
    return NO;
    
}
//-(void)NetWorkChangedNotification
//{
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(radioAccessChanged) name:
//     CTRadioAccessTechnologyDidChangeNotification object:nil];
//    
//}

- (BOOL) IsEnableWIFI
{
    return ([[Reachability reachabilityForLocalWiFi] currentReachabilityStatus] != NotReachable);
}

// 是否3G
- (BOOL) IsEnable3G
{
    return ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] != NotReachable);
}


@end
