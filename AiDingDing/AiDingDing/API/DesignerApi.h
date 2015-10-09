//
//  DesignerApi.h
//  AiDingDing
//
//  Created by libohao on 15/1/13.
//  Copyright (c) 2015年 bestapp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFClient.h"
#import "Enginedefine.h"

@interface DesignerApi : NSObject

//查询设计师作品展示
+(void)getDesignerProducts:(NSString*)designerID Success:(DICTIONARY_BLOCK)success onFailure:(ERROR_BLOCK)failure;

//查询设计师热门设计
+(void)getDesignerHotDesigns:(NSString*)designerID Success:(DICTIONARY_BLOCK)success onFailure:(ERROR_BLOCK)failure;

//查询设计师原单设计
+(void)getDesignerOriginalDesigns:(NSString*)designerID PageIndex:(int)page Success:(DICTIONARY_BLOCK)success onFailure:(ERROR_BLOCK)failure;

//设计师申请接口
+(void)samplesDesinger:(NSDictionary *)paraes image:(NSData *)data onSuccess:(STRING_BLOCK)success onFailure:(ERROR_BLOCK)failure;


@end
