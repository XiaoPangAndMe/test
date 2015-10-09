//
//  ErrorHandler.h
//  AiDingDing
//
//  Created by libohao on 15/1/13.
//  Copyright (c) 2015年 bestapp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperation.h"

@interface ErrorHandler : NSObject

+ (ErrorHandler *)instance;

-(BOOL)blockOperation:(AFHTTPRequestOperation *)operation;

-(void)handleError:(AFHTTPRequestOperation *)operation;

@end
