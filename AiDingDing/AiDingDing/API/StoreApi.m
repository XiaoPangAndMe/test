//
//  StoreApi.m
//  AiDingDing
//
//  Created by libohao on 15/1/13.
//  Copyright (c) 2015年 bestapp. All rights reserved.
//

#import "StoreApi.h"
#import "Enginedefine.h"
#import "ErrorHandler.h"

@implementation StoreApi
+(void)getDesignsList:(NSString *)sex Page:(int)page Success:(DICTIONARY_BLOCK)success onFailure:(ERROR_BLOCK)failure {
    AFClient * client = [AFClient shareClient];
    [client getPath:DESIGNS parameters:@{@"gender":sex} success:^(AFHTTPRequestOperation *operation, id                                                                                  responseObject) {
        NSError *error = nil;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject
                                                            options:NSJSONReadingAllowFragments
                                                              error:&error];
        if (responseObject == nil || dic == nil || dic[@"errors"]) {
            failure(error);
        } else {
            success(dic);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
}


+(void)getDesignsListOfStyleKindID:(NSString*)kind_id Sex:(NSString*)sex Page:(NSInteger)page Success:(DICTIONARY_BLOCK)success onFailure:(ERROR_BLOCK)failure
{
    AFClient * client = [AFClient shareClient];
    NSString* path = [NSString stringWithFormat:@"nodes/%@/designs",kind_id];
    NSString* pageStr = [NSString stringWithFormat:@"%ld",(long)page];
    [client getPath:path parameters:@{@"gender":sex,@"page":pageStr} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError *error = nil;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject
                                                            options:NSJSONReadingAllowFragments
                                                              error:&error];
        if (responseObject == nil || dic == nil || dic[@"errors"]) {
            failure(error);
        } else {
            success(dic);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
}

+(void)getDesignsId:(NSString *)myId onSuccess:(DICTIONARY_BLOCK)success ofFailure:(ERROR_BLOCK)failure {
    AFClient * client = [AFClient shareClient];
    if ([[UserInfo instance] getToken]) {
        [client setDefaultHeader:@"A-Auth-Token" value:[[UserInfo instance] getToken]];
    }else {
        [client setDefaultHeader:@"A-Auth-Token" value:[[UserInfo instance] getTempToken]];
    }
    NSString * url = [NSString stringWithFormat:@"designs/%@/info",myId];
    [client getPath:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError *error = nil;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject
                                                            options:NSJSONReadingAllowFragments
                                                              error:&error];
        if (responseObject == nil || dic == nil || dic[@"errors"]) {
            failure(error);
        } else {
            success(dic);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
}

+(void)getCustomsId:(NSString*)myId onSuccess:(DICTIONARY_BLOCK)success ofFailure:(ERROR_BLOCK)failure
{
    AFClient * client = [AFClient shareClient];
    if ([[UserInfo instance] getToken]) {
        [client setDefaultHeader:@"A-Auth-Token" value:[[UserInfo instance] getToken]];
    }else {
        [client setDefaultHeader:@"A-Auth-Token" value:[[UserInfo instance] getTempToken]];
    }
    NSString * url = [NSString stringWithFormat:@"customs/design/%@",myId];
    NSLog(@"url    .................   is  %@",url);
    [client getPath:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError *error = nil;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject
                                                            options:NSJSONReadingAllowFragments
                                                              error:&error];
        if (responseObject == nil || dic == nil || dic[@"errors"]) {
            failure(error);
        } else {
            success(dic);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
}
@end
