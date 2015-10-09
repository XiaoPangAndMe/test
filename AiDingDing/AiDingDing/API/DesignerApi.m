//
//  DesignerApi.m
//  AiDingDing
//
//  Created by libohao on 15/1/13.
//  Copyright (c) 2015年 bestapp. All rights reserved.
//

#import "DesignerApi.h"
#import "AFHTTPRequestOperation.h"

@implementation DesignerApi

+(void)getDesignerProducts:(NSString*)designerID Success:(DICTIONARY_BLOCK)success onFailure:(ERROR_BLOCK)failure
{
    AFClient * client = [AFClient shareClient];
    if ([[UserInfo instance] getToken]) {
        [client setDefaultHeader:@"A-Auth-Token" value:[[UserInfo instance] getToken]];
    }else {
        [client setDefaultHeader:@"A-Auth-Token" value:[[UserInfo instance] getTempToken]];
    }
    
    NSString* path = [NSString stringWithFormat:@"designer/%@",designerID];
    
    
    //修改了参数
    [client getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError * error = nil;
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
        int code = [dict[@"code"] intValue];
        if (responseObject == nil || code == 0) {
            error = [[NSError alloc] initWithDomain:@"" code:0 userInfo:dict];
            failure(error);
        } else {
            success(dict);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
}

//查询设计师热门设计
+(void)getDesignerHotDesigns:(NSString*)designerID Success:(DICTIONARY_BLOCK)success onFailure:(ERROR_BLOCK)failure
{
    AFClient * client = [AFClient shareClient];
    if ([[UserInfo instance] getToken]) {
        [client setDefaultHeader:@"A-Auth-Token" value:[[UserInfo instance] getToken]];
    }else {
        [client setDefaultHeader:@"A-Auth-Token" value:[[UserInfo instance] getTempToken]];
    }
    
    NSString* path = [NSString stringWithFormat:@"designer/%@/hot_designs",designerID];
    
    [client getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError * error = nil;
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
        int code = [dict[@"code"] intValue];
        if (responseObject == nil || code == 0) {
            error = [[NSError alloc] initWithDomain:@"" code:0 userInfo:dict];
            failure(error);
        } else {
            success(dict);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
    
}

//查询设计师原单设计
+(void)getDesignerOriginalDesigns:(NSString*)designerID PageIndex:(int)page Success:(DICTIONARY_BLOCK)success onFailure:(ERROR_BLOCK)failure
{
    AFClient * client = [AFClient shareClient];
    if ([[UserInfo instance] getToken]) {
        [client setDefaultHeader:@"A-Auth-Token" value:[[UserInfo instance] getToken]];
    }else {
        [client setDefaultHeader:@"A-Auth-Token" value:[[UserInfo instance] getTempToken]];
    }
    
    NSString* path = [NSString stringWithFormat:@"designer/%@/origin_designs",designerID];
    NSString* pageStr = [NSString stringWithFormat:@"%d",page];
    [client getPath:path parameters:@{@"page":pageStr} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError * error = nil;
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
        int code = [dict[@"code"] intValue];
        if (responseObject == nil || code == 0) {
            error = [[NSError alloc] initWithDomain:@"" code:0 userInfo:dict];
            failure(error);
        } else {
            success(dict);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
}

+(void)samplesDesinger:(NSDictionary *)paraes image:(NSData *)data onSuccess:(STRING_BLOCK)success onFailure:(ERROR_BLOCK)failure {
    
    AFClient * client = [AFClient shareClient];
    if ([[UserInfo instance] getToken]) {
        [client setDefaultHeader:@"A-Auth-Token" value:[[UserInfo instance] getToken]];
    }else {
        [client setDefaultHeader:@"A-Auth-Token" value:[[UserInfo instance] getTempToken]];
    }
    
    
    NSURLRequest *request = [client multipartFormRequestWithMethod:@"POST" path:SAMPLES parameters:paraes constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        //NSData *data = UIImagePNGRepresentation(image);
        
        NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
        NSTimeInterval a=[dat timeIntervalSince1970];
        NSString *timeString = [NSString stringWithFormat:@"%lf", (long)a];
        
        [formData appendPartWithFileData:data name:@"sample[sample_image]"
                                fileName:[NSString stringWithFormat:@"layer_image_%@",timeString] mimeType:@"image/png"];
        //        [formData appendPartWithFileData:previewImg name:@"custom_design[preview_image]"
        //                                fileName:[NSString stringWithFormat:@"preview_image_%@",timeString] mimeType:@"image/png"];
        
    }];
    
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"上传完成");
        NSError * error = nil;
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
        int code = [dict[@"code"] intValue];
        if (responseObject == nil || code == 0) {
            error = [[NSError alloc] initWithDomain:@"" code:0 userInfo:dict];
            failure(error);
        } else {
            success(dict);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"上传失败->%@", error);
        failure(error);
    }];
    
    //执行
    [client.operationQueue addOperation:op];
    
    
}
@end
