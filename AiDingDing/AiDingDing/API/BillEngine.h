//
//  BillEngine.h
//  AiDingDing
//
//  Created by libohao on 14/10/29.
//  Copyright (c) 2014年 bestapp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFClient.h"

typedef void (^DictOrArrayBlock)(id JSONResult);
typedef void (^ErrorBlock)(NSError *error);

@interface BillEngine : NSObject



+ (void)checkRSASignV2:(NSString *)order_code
            onComplete:(DictOrArrayBlock)completeBlock
               onError:(ErrorBlock)errorBlock;

@end
