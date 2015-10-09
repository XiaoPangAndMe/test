//
//  AFClient.h
//  AiDingDing
//
//  Created by libohao on 14-7-25.
//  Copyright (c) 2014年 bestapp. All rights reserved.
//

#import "AFHTTPClient.h"
#import "UserInfo.h"

typedef void (^ERROR_BLOCK)(NSError *error);
typedef void (^ARRAY_BLOCK)(NSArray *arrs);
typedef void (^DICTIONARY_BLOCK)(NSDictionary *dics);

typedef void (^STRING_BLOCK)(NSString *str);

typedef void (^PROGRESS_BLOCK)(NSString *str,NSString* total);


@interface AFClient : AFHTTPClient

+ (AFClient *)shareClient;
+ (AFClient *)newShareClient;
+ (void)getMaterialTarget:(id)target Action:(SEL)action;
+ (void)getSingleMaterialWithId:(NSString *)mId page:(NSString *)page Target:(id)target Action:(SEL)action;

@end
