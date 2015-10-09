//
//  userAPI.h
//  AiDingDing
//
//  Created by lzy on 14-9-3.
//  Copyright (c) 2014年 bestapp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFClient.h"



@interface UserAPI : NSObject<NSURLConnectionDelegate,NSURLConnectionDataDelegate>

//注册用户（非第三方）
+(void)sign_upWithPhone:(NSString*)phone ValidCode:(NSString*)validCode
              onSuccess:(void (^)(void))success
              onFailure:(ERROR_BLOCK)failure;

//第三方登录注册
+(void)thirdPartySignUPWithUserName:(NSString*)userName UID:(NSString*)uid Provider:(NSString*)provider
                          onSuccess:(STRING_BLOCK)success
                          onFailure:(ERROR_BLOCK)failure;

//用户登录（包含第三方）
+(void)signInWithUserName:(NSString*)username UID:(NSString*)uid Provider:(NSString*)provider
                onSuccess:(STRING_BLOCK)success
                onFailure:(ERROR_BLOCK)failure;

//用户登录lzy
+(void)signInWithUserName:(NSString*)username PassWord:(NSString*)password
                onSuccess:(void (^)(void))success
                onFailure:(ERROR_BLOCK)failure;
//手机验证码登录
+(void)validSignInWithPhone:(NSString*)phone ValidCode:(NSString*)valid_code
                  onSuccess:(STRING_BLOCK)success
                  onFailure:(ERROR_BLOCK)failure;

//发送验证码lzy
+ (void)verificationPhone:(NSString *)number
                onSuccess:(void (^)(NSString *success))success
                onFailure:(void (^)(NSError *error))failure;

//修改密码接口
+(void)passwordResetNewPassword:(NSString*)newPass NewPasswordConfirmation:(NSString*)newConf
                  onSuccess:(STRING_BLOCK)success
                  onFailure:(ERROR_BLOCK)failure;


//用户设置
+(void)setUserNewPassword:(NSString*)newPass NewPasswordConfirmation:(NSString*)newConf nickname:(NSString*)name
                      onSuccess:(STRING_BLOCK)success
                      onFailure:(ERROR_BLOCK)failure;

////修改密码接口lzy
//+(void)passwordResetPhoneNub:(NSString*)phoneNub NewPassword:(NSString*)newPass NewPasswordConfirmation:(NSString*)newConf
//                      onSuccess:(STRING_BLOCK)success
//                      onFailure:(ERROR_BLOCK)failure;

//创建匿名账号接口
+(void)createTempUserSuccess:(STRING_BLOCK)success onFailure:(ERROR_BLOCK)failure;

//忘记密码—验证手机
+(void)forgetPasswordWithPhone:(NSString*)phone ValidCode:(NSString*)valid_code
                     onSuccess:(void (^)(void))success
                     onFailure:(ERROR_BLOCK)failure;
+(void)forgetPasswordWithPhoneSync:(NSString*)phone ValidCode:(NSString*)valid_code
                     onSuccess:(DICTIONARY_BLOCK)success
                     onFailure:(ERROR_BLOCK)failure;
//个人中心基本信息
+(void)getMyCenterSuccess:(DICTIONARY_BLOCK)success
                        onFailure:(ERROR_BLOCK)failure;
//获取收货地址
+(void)getDeliverAddressonSuccess:(DICTIONARY_BLOCK)success
                        onFailure:(ERROR_BLOCK)failure;
//新增收货地址
+(void)newDeliverAddress:(NSDictionary *)newAddress onSuccess:(DICTIONARY_BLOCK)success
                        onFailure:(ERROR_BLOCK)failure;
//删除收货地址
+(void)delDeliverAddressId:(NSString *)addressId onSuccess:(STRING_BLOCK)success
                        onFailure:(ERROR_BLOCK)failure;
//修改收货地址
+(void)modifiDeliverId:(NSString *)addressId Address:(NSDictionary *)newAddress onSuccess:(STRING_BLOCK)success
               onFailure:(ERROR_BLOCK)failure;

//收藏列表
+(void)getFavoritesonPage:(NSString *)page Success:(DICTIONARY_BLOCK)success
                        onFailure:(ERROR_BLOCK)failure;
//新增收藏
+(void)newFavorites:(NSDictionary *)favorites onSuccess:(DICTIONARY_BLOCK)success
               onFailure:(ERROR_BLOCK)failure;

//删除单个收藏
+(void)delSingleFavoriteId:(NSString *)favoritesId onSuccess:(STRING_BLOCK)success
            onFailure:(ERROR_BLOCK)failure;

//批量删除收藏
+(void)delFavoritesId:(NSDictionary *)favoritesId onSuccess:(STRING_BLOCK)success
                 onFailure:(ERROR_BLOCK)failure;



//获取订单列表
+(void)getOrdersPage:(NSString *)page Success:(DICTIONARY_BLOCK)success onFailure:(ERROR_BLOCK)failure;

//获取手机验证码
+(void)getVaildCodePhone:(NSString *)phone onSuccess:(STRING_BLOCK)success onFailure:(ERROR_BLOCK)failure;

//我的定制列表
+(void)getCustomsListPage:(NSString *)page Success:(DICTIONARY_BLOCK)success onFailure:(ERROR_BLOCK)failure;


+(void)threeLoginProvider:(NSString *)provider uid:(NSString *)uid name:(NSString *)name avatar:(NSString *)avatar onSuccess:(STRING_BLOCK)success onFailure:(ERROR_BLOCK)failure;

//忘记密码
+(void)modityWithPhone:(NSString*)phone ValidCode:(NSString*)validCode
               onSuccess:(void (^)(void))success
             onFailure:(ERROR_BLOCK)failure;

//退出登录
+(void)outonSuccess:(STRING_BLOCK)success onFailure:(ERROR_BLOCK)failure;

//修改昵称
+(void)chengeNikeName:(NSString*)name onSuccess:(STRING_BLOCK)success onFailure:(ERROR_BLOCK)failure;


//取消订单
+(void)cancelOrderId:(NSString *)orderId onSuccess:(STRING_BLOCK)success onFailure:(ERROR_BLOCK)failure;

//尺码表
+(void)getMeasureMentSytleID:(NSString*)style_id Success:(DICTIONARY_BLOCK)success onFailure:(ERROR_BLOCK)failure;

/****新增尺码表***/
+(void)getMeasureMentSytleID:(NSString*)style_id Gender:(NSString *)gender Success:(DICTIONARY_BLOCK)success onFailure:(ERROR_BLOCK)failure;


//文档协议查询
+(void)getDocumentKind:(int)kind Success:(DICTIONARY_BLOCK)success onFailure:(ERROR_BLOCK)failure;

//获取定制衣服信息
+(void)getCustomsClothId:(NSString *)clothId onSuccess:(DICTIONARY_BLOCK)success onFailure:(ERROR_BLOCK)failure;

//系统检测
+(void)getVersions:(NSString *)ver system:(NSString *)system onSuccess:(DICTIONARY_BLOCK)success onFailure:(ERROR_BLOCK)failure;

//客服热线电话号码查询
+(void)getContentPhoneSuccess:(DICTIONARY_BLOCK)success onFailure:(ERROR_BLOCK)failure;

//动态启动图
+(void)getHomePage:(NSString *)width heiht:(NSString *)heiht Success:(DICTIONARY_BLOCK)success onFailure:(ERROR_BLOCK)failure;
@end
