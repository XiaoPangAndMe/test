//
//  ShoppingCarApi.h
//  AiDingDing
//
//  Created by libohao on 15/1/13.
//  Copyright (c) 2015年 bestapp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Enginedefine.h"
#import "AFClient.h"

@interface ShoppingCarApi : NSObject

//购物车列表
+(void)shoppingCarListSuccess:(DICTIONARY_BLOCK)success onFailure:(ERROR_BLOCK)failure;

//添加购物车
+(void)addShopping:(NSDictionary*)para onSuccess:(STRING_BLOCK)success onFailure:(ERROR_BLOCK)failure;

//添加组合购物车
+ (void)addCombaineShopping:(NSDictionary*)para onSuccess:(STRING_BLOCK)success onFailure:(ERROR_BLOCK)failure;




//更新购物车
+(void)updateShoppingCarID:(NSString*)carId Para:(NSDictionary*)para onSuccess:(STRING_BLOCK)success onFailure:(ERROR_BLOCK)failure;

/****更新亲子情侣装混合，添加到购物车****/

+(void)updateCombineShoppingWithPara:(NSDictionary*)para onSuccess:(STRING_BLOCK)success onFailure:(ERROR_BLOCK)failure;
/********/

//删除购物车
+(void)deleteShoppingCar:(NSString*)carId onSuccess:(STRING_BLOCK)success onFailure:(ERROR_BLOCK)failure;

//添加购物车
+(void)createShoppingCars:(DICTIONARY_BLOCK)params onSuccess:(DICTIONARY_BLOCK)success onFailure:(ERROR_BLOCK)failure;

//批量添加购物车
+(void)createShoppingCarsMuiti:(NSDictionary*)params onSuccess:(DICTIONARY_BLOCK)success onFailure:(ERROR_BLOCK)failure;

//购物车提交订单
+(void)commitCreateCarId:(NSArray *)carId addressId:(NSString*)addressId expressID:(NSString*)expressId onSuccess:(DICTIONARY_BLOCK)success onFailure:(ERROR_BLOCK)failure;


//运费
+(void)getFreightCarId:(NSArray *)carId postcode:(NSString *)postcode onSuccess:(DICTIONARY_BLOCK)success onFailure:(ERROR_BLOCK)failure;
//更改后的运费
+(void)newGetFreightCarId:(NSArray *)carId  postcode:(NSString *)postcode spcids:(NSString *)spcids    onSuccess:(DICTIONARY_BLOCK)success onFailure:(ERROR_BLOCK)failure;

//取消订单
+(void)cancelOrderId:(NSString *)orderId onSuccess:(STRING_BLOCK)success onFailure:(ERROR_BLOCK)failure;

//重新下单
+(void)reOrder:(NSString*)orderID onSuccess:(DICTIONARY_BLOCK)success onFailure:(ERROR_BLOCK)failure;

@end
