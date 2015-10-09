//
//  BillEngine.m
//  AiDingDing
//
//  Created by libohao on 14/10/29.
//  Copyright (c) 2014年 bestapp. All rights reserved.
//

#import "BillEngine.h"
#import "AppConfig.h"

@implementation BillEngine


+ (NSString *)getToken {
    NSUserDefaults *defs = [NSUserDefaults standardUserDefaults];
    return [defs objectForKey:@"auth_token"];
}
+ (NSString *)getTempToken {
    NSUserDefaults *defs = [NSUserDefaults standardUserDefaults];
    return [defs objectForKey:@"temp_token"];
}


+ (void)checkRSASignV2:(NSString *)order_code
            onComplete:(DictOrArrayBlock)completeBlock
               onError:(ErrorBlock)errorBlock{
    

    AFClient * client = [AFClient shareClient];
    if ([self getToken]) {
        [client setDefaultHeader:@"A-Auth-Token" value:[self getToken]];
    }else {
        [client setDefaultHeader:@"A-Auth-Token" value:[self getTempToken]];
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    //#warning 这里换成你的字段和参数
    params[@"order_id"] = order_code;

    
    NSString* url = [NSString stringWithFormat:@"payments/alipay/sign?order_id=%@",order_code];
    [client postPath:@"payments/alipay/sign"
          parameters:@{@"order_id": order_code}
             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                 NSError *error = nil;
                 NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                     options:NSJSONReadingAllowFragments
                                                                       error:&error];
                 
                 BTLog(@"ver = %@", dic);
                 if (responseObject == nil || dic == nil || dic[@"errors"]) {
                     errorBlock(nil);
                 } else {
                     completeBlock(dic);
                 }
                 
             }
             failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                 errorBlock(error);
                 BTLog(@"error=%@", error);
             }];

}

@end
