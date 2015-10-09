//
//  UserInfo.h
//  AiDingDing
//
//  Created by libohao on 14/12/18.
//  Copyright (c) 2014年 bestapp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPClient.h"
@class AFHTTPRequestOperation;

@interface UserInfo : NSObject

@property (nonatomic,strong)AFHTTPRequestOperation *op;

+ (UserInfo *)instance;

-(void)setCustomDesignClicked;
-(BOOL)isCustomDesignClicked;


-(void)saveToken:(NSString*)token;
-(void)saveTempToken:(NSString*)token;
-(void)saveFistStart:(NSString*)fistStart;
-(NSString *)getToken;

-(NSString *)getTempToken;
-(NSString *)getFistStart;
-(void)removeToken;
-(void)removeTempToken;
-(void)saveStartImage:(NSData*)StartImage;
-(NSData *)getStartImage;

@end
