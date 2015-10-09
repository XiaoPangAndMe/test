//
//  UserInfo.m
//  AiDingDing
//
//  Created by libohao on 14/12/18.
//  Copyright (c) 2014年 bestapp. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo

+ (UserInfo *)instance{
    static UserInfo *instance = nil;
    static dispatch_once_t once_t;
    dispatch_once(&once_t, ^{
        instance = [[UserInfo alloc]init];
    });
    return instance;
}

-(void)setCustomDesignClicked
{
    NSUserDefaults *defs = [NSUserDefaults standardUserDefaults];
    [defs setObject:@"1" forKey:@"CustomClicked"];
    [defs synchronize];
}

-(BOOL)isCustomDesignClicked
{
    NSUserDefaults *defs = [NSUserDefaults standardUserDefaults];
    NSString* tag = [defs objectForKey:@"CustomClicked"];
    if ([tag isEqualToString:@"1"]) {
        return YES;
    }
    return NO;
}

-(void)saveToken:(NSString*)token
{
    NSUserDefaults *defs = [NSUserDefaults standardUserDefaults];
    [defs setObject:token forKey:@"auth_token"];
    [defs synchronize];
}

-(void)saveTempToken:(NSString*)token
{
    NSUserDefaults *defs = [NSUserDefaults standardUserDefaults];
    [defs setObject:token forKey:@"temp_token"];
    [defs synchronize];
}

-(void)saveFistStart:(NSString*)fistStart
{
    NSUserDefaults *defs = [NSUserDefaults standardUserDefaults];
    [defs setObject:fistStart forKey:@"fistStart"];
    [defs synchronize];
}

-(NSString *)getToken {
    NSUserDefaults *defs = [NSUserDefaults standardUserDefaults];
    return [defs objectForKey:@"auth_token"];
}

-(NSString *)getTempToken {
    NSUserDefaults *defs = [NSUserDefaults standardUserDefaults];
    return [defs objectForKey:@"temp_token"];
}

-(NSString *)getFistStart {
    NSUserDefaults *fistStart = [NSUserDefaults standardUserDefaults];
    return [fistStart objectForKey:@"fistStart"];
}

-(void)removeToken{
    NSUserDefaults *defs = [NSUserDefaults standardUserDefaults];
    [defs setObject:nil forKey:@"auth_token"];
    [defs synchronize];
}

-(void)removeTempToken{
    NSUserDefaults *defs = [NSUserDefaults standardUserDefaults];
    [defs setObject:nil forKey:@"temp_token"];
    [defs synchronize];
}

-(void)saveStartImage:(NSData*)StartImage
{
    NSUserDefaults *defs = [NSUserDefaults standardUserDefaults];
    [defs setObject:StartImage forKey:@"startImage"];
    [defs synchronize];
}

-(NSData *)getStartImage {
    NSUserDefaults *defs = [NSUserDefaults standardUserDefaults];
    return [defs objectForKey:@"startImage"];
}


@end
