//
//  AFClient.m
//  AiDingDing
//
//  Created by libohao on 14-7-25.
//  Copyright (c) 2014年 bestapp. All rights reserved.
//

#import "AFClient.h"
#import "Enginedefine.h"
#import "AFHTTPRequestOperation.h"
#import "ErrorHandler.h"
#import <objc/message.h>
#import "ConstDefine.h"
@interface AFClient()

@property ErrorHandler* errorHandler;

@end

@implementation AFClient:AFHTTPClient

+ (AFClient *)shareClient {
    static AFClient *client = nil;
    static dispatch_once_t once_t;
    dispatch_once(&once_t, ^{
        NSURL *url = [NSURL URLWithString:BASE_API_URL];
        client = [[AFClient alloc] initWithBaseURL:url];
        
        [ErrorHandler instance];
    });
    return client;
}

+ (AFClient *)newShareClient {
    static AFClient *client = nil;
    static dispatch_once_t once_t;
    dispatch_once(&once_t, ^{
        NSURL *url = [NSURL URLWithString:YUNFEI_API_URL];
        client = [[AFClient alloc] initWithBaseURL:url];
        
        [ErrorHandler instance];
    });
    return client;
}

+ (void)getMaterialTarget:(id)target Action:(SEL)action
{
    NSMutableString *strUrl = [NSMutableString stringWithFormat:@"%@%@",BASE_API_URL,@"/public/materials"];
    NSString *stUrlString = [strUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@"%@",stUrlString);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:stUrlString]];
    
    //参数数据

    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation,id responseObject){
        NSString *html = operation.responseString;
        NSData *data = [html dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
               NSLog(@"请求下的数据:%@",dict);
        
        objc_msg(target,action,dict);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        
    }];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:operation];


}


+ (void)getSingleMaterialWithId:(NSString *)mId page:(NSString *)page Target:(id)target Action:(SEL)action
{
    NSMutableString *strUrl = [NSMutableString stringWithFormat:@"%@public/cooperative/%@/materials?id=%@&page=%@",BASE_API_URL,mId,mId,page];
    
    NSLog(@"http = %@",strUrl);
    
    NSString *stUrlString = [strUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@"%@",stUrlString);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:stUrlString]];
    
    //参数数据
    
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation,id responseObject){
        NSString *html = operation.responseString;
        NSData *data = [html dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSLog(@"请求下的数据:%@",dict);
        
        objc_msg(target,action,dict);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        
    }];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:operation];
    
    
}



- (NSMutableURLRequest *)requestWithMethod:(NSString *)method path:(NSString *)path parameters:(NSDictionary *)parameters {
    NSMutableURLRequest *request = [super requestWithMethod:method path:path parameters:parameters];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [request setTimeoutInterval:10];

    return request;
}

- (void)getPath:(NSString *)path parameters:(NSDictionary *)parameters success:(void (^)(AFHTTPRequestOperation *, id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure {
    NSMutableDictionary *md = [NSMutableDictionary dictionaryWithDictionary:parameters];
    //md[@"key"] = API_TOKEN;
    NSLog(@"path....%@",path);
    parameters = md;
    
    [super getPath:path parameters:parameters success:success failure:failure];
}

- (void)postPath:(NSString *)path parameters:(NSDictionary *)parameters success:(void (^)(AFHTTPRequestOperation *, id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure {
    //NSMutableDictionary *md = [NSMutableDictionary dictionaryWithDictionary:parameters];
    //md[@"key"] = API_TOKEN;
    //parameters = md;
    
    
    [super postPath:path parameters:parameters success:success failure:failure];
}

- (void)putPath:(NSString *)path parameters:(NSDictionary *)parameters success:(void (^)(AFHTTPRequestOperation *, id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure {
    
    [super putPath:path parameters:parameters success:success failure:failure];
}

-(void)deletePath:(NSString *)path parameters:(NSDictionary *)parameters success:(void (^)(AFHTTPRequestOperation *, id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure
{
    [super deletePath:path parameters:parameters success:success failure:failure];
}

//- (void)connection:(NSURLConnection *)theConnection didFailWithError:(NSError *)error{
//    // 当请求失败时的相关操作；
//    int code = error.code;
//    NSLog(@"error code %d",code);
//    
//}





@end
