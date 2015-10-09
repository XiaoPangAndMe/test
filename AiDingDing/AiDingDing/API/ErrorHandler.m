//
//  ErrorHandler.m
//  AiDingDing
//
//  Created by libohao on 15/1/13.
//  Copyright (c) 2015年 bestapp. All rights reserved.
//

#import "ErrorHandler.h"

#define NOTI_RESPONSE_CODE @"responsecode"
#define ERROR_401 @"401"

@implementation ErrorHandler

+ (ErrorHandler *)instance {
    static ErrorHandler *instance = nil;
    static dispatch_once_t once_t;
    dispatch_once(&once_t, ^{
        instance = [[ErrorHandler alloc]init];
        [instance addObserError];
    });
    return instance;
}

-(void)addObserError
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleResponse:)
                                                 name:NOTI_RESPONSE_CODE object:nil];
    
}

-(void)handleError:(AFHTTPRequestOperation *)operation;
{
    if (operation.response.statusCode == 401) {
        
    }
}

-(BOOL)blockOperation:(AFHTTPRequestOperation *)operation
{
    if (operation.response.statusCode == 401) {
        return YES;
    }
    
    return NO;
}



-(void)handleResponse:(NSNotification*) notification
{
    //NSString* code = [[noti userInfo]objectForKey:@"code"];
    NSString* code = notification.object;
    NSLog(@"%@",code);
    
    if ([code isEqualToString:@"401"]) {
        [self error_401];
    }
    
}

-(void)error_401
{
    NSLog(@"401 error");
    [[NSNotificationCenter defaultCenter] postNotificationName:ERROR_401 object:nil];
}
@end
