//
//  StoreApi.h
//  AiDingDing
//
//  Created by libohao on 15/1/13.
//  Copyright (c) 2015年 bestapp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFClient.h"

@interface StoreApi : NSObject

//商品列表
+(void)getDesignsList:(NSString *)sex  Page:(int)page Success:(DICTIONARY_BLOCK)success onFailure:(ERROR_BLOCK)failure;

//款式类型商品列表
+(void)getDesignsListOfStyleKindID:(NSString*)kind_id Sex:(NSString*)sex Page:(NSInteger)page Success:(DICTIONARY_BLOCK)success onFailure:(ERROR_BLOCK)failure;

//查询商城单个商品信息
+(void)getDesignsId:(NSString*)myId onSuccess:(DICTIONARY_BLOCK)success ofFailure:(ERROR_BLOCK)failure;

//查询定制单个商品信息
+(void)getCustomsId:(NSString*)myId onSuccess:(DICTIONARY_BLOCK)success ofFailure:(ERROR_BLOCK)failure;

@end
