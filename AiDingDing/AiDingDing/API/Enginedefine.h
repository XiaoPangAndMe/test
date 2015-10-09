//
//  Enginedefine.h
//  AiDingDing
//
//  Created by libohao on 14-7-25.
//  Copyright (c) 2014年 bestapp. All rights reserved.
//

#ifndef allinns_business_Enginedefine_h
#define allinns_business_Enginedefine_h
//测试环境
//#define BASE_API_URL @"http://aidd.bestapp.us/api/v1/"

//正式环境
#define BASE_API_URL @"http://app.idingding.com/api/v1/"
#define YUNFEI_API_URL @"http://www.idingding.com/"
#define NEW_BASE_URL @"http://app.idingding.com/api/v2/"//组合添加购物车用
///User API///

#define FAILURETIP                    @"请求失败，请稍后再试"

#define SIGN_UP                       @"users/sign_up"
//#define MODITYUSER                       @"users/sign_up"
//#define PHONE_VALIDATE                @"phone/validate"
#define THIRD_PARTY_SIGN_UP           @"users/third_party/sign_up"
#define USER_SIGN_IN                  @"users/sign_in"
#define USER_VALID_SIGN_IN            @"users/valid_sign_in"
#define PASSWORD_RESET                @"users/password/reset"
#define FORGET_PASSWORD               @"forget_password"    
#define PROFILE                       @"user/profile"
#define RECEIVADDRESS                 @"deliver_addresses"  //获取收货地址
#define NEWRECEIVADDRESS              @"deliver_addresses/create" //新增收货地址
#define FAVORITES                     @"favorites" //用户收藏列表
#define NEWFAVORITES                  @"favorites/create" //新增用户收藏
#define USERPROFILE                   @"user/profile"//个人中心基本信息
#define TEMPUSER                      @"users/temp"//匿名账户接口
#define SHOPPINGCAR                   @"shopping_cars"//购物车列表
#define ADDSHOPPINGCAR                @"shopping_cars/create"//添加购物车
#define COMBINE_SHOPING_CAR           @"shopping_cars/combine/create"//组合添加购物车
#define DESIGNS                       @"nodes/designs" //商品列表
#define SAMPLES                       @"designer/samples" //设计师申请
#define ORDERS                        @"orders"//获取订单列表
#define SHOPPINGCARSCREATE                        @"shopping_cars/create"//添加购物车
#define SHOPPINGCARSCREATE_MULTI                        @"shopping_cars/create/multi"//批量添加购物车

#define SHOPPINGCARSUPDATE            @"shopping_cars/"
#define PASSRESET                         @"users/password/reset"//修改密码
#define ORDERSCREATE                        @"orders/create"//获取订单列表
#define FREIGHTCAL                        @"public/freight/cal"//运费计算
#define FREIGHTCAL2                       @"settle/takeExpressPrice.do"//运费计算

#define VALIDCODE                        @"public/valid_code"//获取订单列表
#define CUSTOM_DESIGN                 @"customs/options" //用户定制
#define DELFAVORITES                  @"favorites/multi"//删除收藏
#define GETCUSTOMSLIST                  @"customs"//我的定制列表
#define CTEATE_CUSTOM                 @"customs/design/create"
#define TEXTURES                      @"customs/options/textures"
#define OUT                    @"users/sign_out"//退出登录
#define DELCUSTOMS                    @"customs/multi"//删除收藏
#define CHENGENIKE                    @"user/info"//修改昵称
#define UPDATEAVATAR                    @"user/avatar"//修改头像
#define UPDATASYSTEM                    @"public/versions/check"//修改昵称
#define ABOUTUS                    @"public/about/us"//获取联系电话
#define HOMEPAGE                    @"public/home_page"//获取动态启动图
#define ADDRESSSYNC                    @"deliver_addresses/sync"//获取动态启动图
#define ADDMETERIAL                @"/public/materials"//合作商提供素材
#endif
