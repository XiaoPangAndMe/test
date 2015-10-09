//
//  CustomApi.h
//  AiDingDing
//
//  Created by libohao on 15/1/13.
//  Copyright (c) 2015年 bestapp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFClient.h"
#import "Enginedefine.h"

@interface CustomApi : NSObject

//获取定制选项
+(void)getCustomDesignOptionsOnSuccess:(DICTIONARY_BLOCK)success onFailure:(ERROR_BLOCK)failure;

//上传定制
+(void)createCustomDesignStyleID:(NSString*)styleId TextureID:(NSString*)texId front_layer:(NSData*)front_layer
                     front_image:(NSData*)front_image back_image:(NSData*)back_img back_layer:(NSData *)back_layer Success:(DICTIONARY_BLOCK)success
                        Progress:(PROGRESS_BLOCK)progress onFailure:(ERROR_BLOCK)failure;

//上传定制更新
+(void)createCustomDesignStyleID:(NSString*)styleId material_ID:(NSString*)material_ids clothes_count:(NSString *)clothes_count front_layer:(NSData*)front_layer front_image:(NSData*)front_image back_image:(NSData*)back_img back_layer:(NSData *)back_layer Success:(DICTIONARY_BLOCK)success
                        Progress:(PROGRESS_BLOCK)progress onFailure:(ERROR_BLOCK)failure;



+(void)cancelCustomDesignUpload;

//删除定制
+(void)delCustomId:(NSDictionary *)favoritesId onSuccess:(STRING_BLOCK)success
         onFailure:(ERROR_BLOCK)failure;

+(void)getTextures:(DICTIONARY_BLOCK)success onFailure:(ERROR_BLOCK)failure;

@end
