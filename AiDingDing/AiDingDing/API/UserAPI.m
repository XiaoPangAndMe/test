//
//  userAPI.m
//  AiDingDing
//
//  Created by lzy on 14-9-3.
//  Copyright (c) 2014年 bestapp. All rights reserved.
//

#import "UserAPI.h"
#import "AFHTTPClient.h"
#import "AppConfig.h"
#import "Enginedefine.h"
#import "AFHTTPRequestOperation.h"
#import "UserInfo.h"

@implementation UserAPI





//发送手机验证码
+ (void)verificationPhone:(NSString *)number
                onSuccess:(void (^)(NSString *))success
                onFailure:(void (^)(NSError *))failure {
     AFClient* client = [AFClient shareClient];
    [client postPath:@"users/verification"
          parameters:@{@"mobile":number}
             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                 NSError *error = nil;
                 NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                     options:NSJSONReadingAllowFragments
                                                                       error:&error];
                 
                 BTLog(@"ver = %@", dic);
                 if (responseObject == nil || dic == nil || dic[@"errors"]) {
                     failure(nil);
                 } else {
                     success([NSString stringWithFormat:@"%@", dic[@"verification"]]);
                 }
                 
             }
             failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                 failure(error);
                 BTLog(@"error=%@", error);
             }];
    
    
}

/////////////////////
+(void)sign_upWithPhone:(NSString*)phone ValidCode:(NSString*)validCode
              onSuccess:(void (^)(void))success
              onFailure:(ERROR_BLOCK)failure
{
    AFClient* client = [AFClient shareClient];
    if ([[UserInfo instance] getToken]) {
        [client setDefaultHeader:@"A-Auth-Token" value:[[UserInfo instance] getToken]];
    }else {
        [client setDefaultHeader:@"A-Auth-Token" value:[[UserInfo instance] getTempToken]];
    }
    
    NSLog(@"Url = %@",SIGN_UP);//@"http://192.168.0.223:8080/aidd/sign_up.do"
    [client postPath:SIGN_UP parameters:@{@"phone": phone,@"valid_code":validCode} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError *error = nil;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject
                                                            options:NSJSONReadingAllowFragments
                                                              error:&error];
        NSLog(@"dic....%@",[dic objectForKey:@"result"]);
        int code = [dic[@"code"] intValue];
        if (responseObject == nil || code == 0) {
            NSError *error = [[NSError alloc] initWithDomain:@"" code:0 userInfo:dic];
            failure(error);
        } else {
            [[UserInfo instance] saveToken:dic[@"auth_token"]];
            [[UserInfo instance] removeTempToken];

            success();
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
        NSLog(@"error=%@", error);
    }];
}

+(void)modityWithPhone:(NSString*)phone ValidCode:(NSString*)validCode
              onSuccess:(void (^)(void))success
              onFailure:(ERROR_BLOCK)failure
{
    AFClient* client = [AFClient shareClient];
    if ([[UserInfo instance] getToken]) {
        [client setDefaultHeader:@"A-Auth-Token" value:[[UserInfo instance] getToken]];
    }else {
        [client setDefaultHeader:@"A-Auth-Token" value:[[UserInfo instance] getTempToken]];
    }
    NSString * str = [NSString stringWithFormat:@"users/%@/validate",phone];
    [client postPath:str parameters:@{@"phone": phone,@"valid_code":validCode} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError *error = nil;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject
                                                            options:NSJSONReadingAllowFragments
                                                              error:&error];
        NSLog(@"dic....%@",[dic objectForKey:@"result"]);
        int code = [dic[@"code"] intValue];
        if (responseObject == nil || code == 0) {
            NSError *error = [[NSError alloc] initWithDomain:@"" code:0 userInfo:dic];
            failure(error);
        } else {
            [[UserInfo instance] saveToken:dic[@"auth_token"]];
            success();
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
        NSLog(@"error=%@", error);
    }];
}



//第三方登录注册
+(void)thirdPartySignUPWithUserName:(NSString*)userName UID:(NSString*)uid Provider:(NSString*)provider
                          onSuccess:(STRING_BLOCK)success
                          onFailure:(ERROR_BLOCK)failure
{
    AFClient* client = [AFClient shareClient];
    [client postPath:THIRD_PARTY_SIGN_UP parameters:@{@"username": userName,@"uid":uid} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError *error = nil;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject
                                                            options:NSJSONReadingAllowFragments
                                                              error:&error];
        int code = [dic[@"code"] intValue];
        if (responseObject == nil ) {
            NSError *error = [[NSError alloc] initWithDomain:@"" code:0 userInfo:dic];
            failure(error);
        }else if (code == 0){
            NSString* message = dic[@"message"];
            success(message);
        }else {
            NSString* message = dic[@"message"];
            NSLog(@"%@",message);
            [[UserInfo instance] saveToken:dic[@"auth_token"]];
            
            success(message);
        }
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
        NSLog(@"error=%@", error);
    }];
}

+(void)signInWithUserName:(NSString*)username PassWord:(NSString*)password
                onSuccess:(void (^)(void))success
                onFailure:(ERROR_BLOCK)failure
{
    AFClient* client = [AFClient shareClient];
    if ([[UserInfo instance] getToken]) {
        [client setDefaultHeader:@"A-Auth-Token" value:[[UserInfo instance] getToken]];
    }else {
        [client setDefaultHeader:@"A-Auth-Token" value:[[UserInfo instance] getTempToken]];
    }
    [client postPath:USER_SIGN_IN parameters:@{@"phone": username,@"password":password} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError *error = nil;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject
                                                            options:NSJSONReadingAllowFragments
                                                              error:&error];
        NSLog(@"dict.....%@",dic);
        int code = [dic[@"code"] intValue];
        if (responseObject == nil || code == 0) {
            NSError *error = [[NSError alloc] initWithDomain:@"" code:0 userInfo:dic];
            failure(error);
        }else {
            NSString* message = dic[@"message"];
            NSLog(@"%@",message);
            [[UserInfo instance] saveToken:dic[@"auth_token"]];
            
            success();
        }
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
        NSLog(@"error=%@", error);
    }];

    
}

+(void)signInWithUserName:(NSString*)username UID:(NSString*)uid Provider:(NSString*)provider
                onSuccess:(STRING_BLOCK)success
                onFailure:(ERROR_BLOCK)failure
{
    AFClient* client = [AFClient shareClient];
    if ([[UserInfo instance] getToken]) {
        [client setDefaultHeader:@"A-Auth-Token" value:[[UserInfo instance] getToken]];
    }else {
        [client setDefaultHeader:@"A-Auth-Token" value:[[UserInfo instance] getTempToken]];
    }
    [client postPath:USER_SIGN_IN parameters:@{@"username": username,@"uid":uid} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError *error = nil;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject
                                                            options:NSJSONReadingAllowFragments
                                                              error:&error];
        int code = [dic[@"code"] intValue];
        if (responseObject == nil ) {
            NSError *error = [[NSError alloc] initWithDomain:@"" code:0 userInfo:dic];
            failure(error);
        }else if (code == 0){
            NSString* message = dic[@"message"];
            success(message);
        }else {
            NSString* message = dic[@"message"];
            NSLog(@"%@",message);
            [[UserInfo instance] saveToken:dic[@"auth_token"]];
            
            success(message);
        }
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
        NSLog(@"error=%@", error);
    }];
    
}


//手机验证码登录
+(void)validSignInWithPhone:(NSString*)phone ValidCode:(NSString*)valid_code
                  onSuccess:(STRING_BLOCK)success
                  onFailure:(ERROR_BLOCK)failure
{
    
    AFClient* client = [AFClient shareClient];
    [client postPath:USER_SIGN_IN parameters:@{@"phone": phone,@"valid_code":valid_code} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError *error = nil;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject
                                                            options:NSJSONReadingAllowFragments
                                                              error:&error];
        int code = [dic[@"code"] intValue];
        if (responseObject == nil ) {
            NSError *error = [[NSError alloc] initWithDomain:@"" code:0 userInfo:dic];
            failure(error);
        }else if (code == 0){
            NSString* message = dic[@"message"];
            success(message);
        }else {
            NSString* message = dic[@"message"];
            NSLog(@"%@",message);
            [[UserInfo instance] saveToken:dic[@"auth_token"]];
            
            success(message);
        }
    
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
        NSLog(@"error=%@", error);
    }];
    
}


+(void)passwordResetNewPassword:(NSString*)newPass NewPasswordConfirmation:(NSString*)newConf
                      onSuccess:(STRING_BLOCK)success
                      onFailure:(ERROR_BLOCK)failure
{
    
    AFClient* client = [AFClient shareClient];
    [client setDefaultHeader:@"A-Auth-Token" value:[[UserInfo instance] getToken]];
    [client postPath:PASSWORD_RESET parameters:@{@"password":newPass,@"password_confirmation":newConf}
             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                 NSError *error = nil;
                 NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                     options:NSJSONReadingAllowFragments
                                                                       error:&error];
                 int code = [dic[@"code"] intValue];
                 if (responseObject == nil || code == 0) {
                     NSError *error = [[NSError alloc] initWithDomain:@"" code:0 userInfo:dic];
                     failure(error);
                 } else {
                     NSString* message = dic[@"message"];
                     success(message);
                 }

             }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                 failure(error);
    }];
    
}
//用户设置
+(void)setUserNewPassword:(NSString *)newPass NewPasswordConfirmation:(NSString *)newConf nickname:(NSString *)name
                onSuccess:(STRING_BLOCK)success
                onFailure:(ERROR_BLOCK)failure {
    AFClient * client = [AFClient shareClient];
    [client setDefaultHeader:@"A-Auth-Token" value:[[UserInfo instance] getToken]];
    [client postPath:PROFILE parameters:@{@"password":newPass,@"password_confirmation":newConf,@"name":name}
             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                 NSError *error = nil;
                 NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                     options:NSJSONReadingAllowFragments
                                                                       error:&error];
                 int code = [dic[@"code"] intValue];
                 if (responseObject == nil || code == 0) {
                     NSError *error = [[NSError alloc] initWithDomain:@"" code:0 userInfo:dic];
                     failure(error);
                 } else {
                     NSString* message = dic[@"message"];
                     success(message);
                 }
                 
             }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                 failure(error);
             }];

    
}

//用手机号获取验证码
+(void)forgetPasswordWithPhone:(NSString *)phone ValidCode:(NSString *)valid_code
                     onSuccess:(void (^)(void))success
                     onFailure:(ERROR_BLOCK)failure
{
    AFClient* client = [AFClient shareClient];
//    [client setDefaultHeader:@"A-Auth-Token" value:[self getToken]];
    NSString * url = [NSString stringWithFormat:@"users/%@/validate",phone];
    [client postPath:url parameters:@{@"valid_code": valid_code} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError *error = nil;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject
                                                            options:NSJSONReadingAllowFragments
                                                              error:&error];
        int code = [dic[@"code"] intValue];
        if (responseObject == nil || code == 0) {
            NSError *error = [[NSError alloc] initWithDomain:@"" code:0 userInfo:dic];
            failure(error);
        } else {
            [[UserInfo instance] saveToken:dic[@"auth_token"]];
            success();
        }
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
        NSLog(@"error=%@", error);
    }];
    
}

//用手机号获取验证码
+(void)forgetPasswordWithPhoneSync:(NSString *)phone ValidCode:(NSString *)valid_code
                     onSuccess:(DICTIONARY_BLOCK)success
                     onFailure:(ERROR_BLOCK)failure
{
    AFClient * client = [AFClient shareClient];
    if ([[UserInfo instance] getToken]) {
        [client setDefaultHeader:@"A-Auth-Token" value:[[UserInfo instance] getToken]];
        NSLog(@"getToken...%@",[[UserInfo instance] getToken]);
    }else {
        [client setDefaultHeader:@"A-Auth-Token" value:[[UserInfo instance] getTempToken]];
    }
    [client postPath:ADDRESSSYNC parameters:@{@"valid_code": valid_code,@"phone":phone} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError *error = nil;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject
                                                            options:NSJSONReadingAllowFragments
                                                              error:&error];
        int code = [dic[@"code"] intValue];
        if (responseObject == nil || code == 0) {
            NSError *error = [[NSError alloc] initWithDomain:@"" code:0 userInfo:dic];
            failure(error);
        } else {
            success(dic);
        }
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
        NSLog(@"error=%@", error);
    }];
    
}

//获取收货地址
+(void)getDeliverAddressonSuccess:(DICTIONARY_BLOCK)success onFailure:(ERROR_BLOCK)failure {
    AFClient * client = [AFClient shareClient];
    if ([[UserInfo instance] getToken]) {
        [client setDefaultHeader:@"A-Auth-Token" value:[[UserInfo instance] getToken]];
        NSLog(@"getToken...%@",[[UserInfo instance] getToken]);
    }else {
        [client setDefaultHeader:@"A-Auth-Token" value:[[UserInfo instance] getTempToken]];
        NSLog(@"getTempToken...%@",[[UserInfo instance] getTempToken]);
    }
    [client getPath:RECEIVADDRESS parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError * error = nil;
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
        NSLog(@"dict.....%@",dict);
        int code = [dict[@"code"] intValue];
        if (responseObject == nil || code == 0) {
            NSError *error = [[NSError alloc] initWithDomain:@"" code:0 userInfo:dict];
            failure(error);
        } else {
            success(dict);
        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
}

//新增收货地址
+(void)newDeliverAddress:(NSDictionary *)newAddress onSuccess:(DICTIONARY_BLOCK)success onFailure:(ERROR_BLOCK)failure {
    AFClient * client = [AFClient shareClient];
    if ([[UserInfo instance] getToken]) {
        [client setDefaultHeader:@"A-Auth-Token" value:[[UserInfo instance] getToken]];
    }else {
        [client setDefaultHeader:@"A-Auth-Token" value:[[UserInfo instance] getTempToken]];
    }
    [client postPath:NEWRECEIVADDRESS parameters:newAddress success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError * error = nil;
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
        int code = [dict[@"code"]intValue];
        if (code == 0 || responseObject == nil) {
            error = [[NSError alloc] initWithDomain:@"" code:0 userInfo:dict];
            failure(error);
        }else {
            success(dict);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"dict....error");
         failure(error);
    }];
}
+(void)delDeliverAddressId:(NSString *)addressId onSuccess:(STRING_BLOCK)success onFailure:(ERROR_BLOCK)failure {
    AFClient * client = [AFClient shareClient];
    if ([[UserInfo instance] getToken]) {
        [client setDefaultHeader:@"A-Auth-Token" value:[[UserInfo instance] getToken]];
        NSLog(@"getToken...%@",[[UserInfo instance] getToken]);
    }else {
        [client setDefaultHeader:@"A-Auth-Token" value:[[UserInfo instance] getTempToken]];
        NSLog(@"getTempToken...%@",[[UserInfo instance] getTempToken]);
    }
    NSString * url = [NSString stringWithFormat:@"%@/%@",RECEIVADDRESS,addressId];
    [client deletePath:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError * error = nil;
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
        NSLog(@"dict.....%@",dict);
        int code = [dict[@"code"] intValue];
        if (responseObject == nil || code == 0) {
            NSError *error = [[NSError alloc] initWithDomain:@"" code:0 userInfo:dict];
            failure(error);
        } else {
            success([dict objectForKey:@"message"]);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"dict.....error");
        failure(error);
    }];
}
+(void)modifiDeliverId:(NSString *)addressId Address:(NSDictionary *)newAddress onSuccess:(STRING_BLOCK)success onFailure:(ERROR_BLOCK)failure {
    AFClient * client = [AFClient shareClient];
    if ([[UserInfo instance] getToken]) {
        [client setDefaultHeader:@"A-Auth-Token" value:[[UserInfo instance] getToken]];
    }else {
        [client setDefaultHeader:@"A-Auth-Token" value:[[UserInfo instance] getTempToken]];
    }
    NSString * url = [NSString stringWithFormat:@"%@/%@",RECEIVADDRESS,addressId];
    [client postPath:url parameters:newAddress success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError * error = nil;
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
        NSLog(@"dict.....%@",dict);
        int code = [dict[@"code"] intValue];
        if (responseObject == nil || code == 0) {
            NSError *error = [[NSError alloc] initWithDomain:@"" code:0 userInfo:dict];
            failure(error);
        } else {
            success([dict objectForKey:@"message"]);
            NSLog(@"dict.....%@",[dict objectForKey:@"message"]);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];

}
//待测试
+(void)getFavoritesonPage:(NSString *)page Success:(DICTIONARY_BLOCK)success onFailure:(ERROR_BLOCK)failure {
    AFClient * client = [AFClient shareClient];
    if ([[UserInfo instance] getToken]) {
        [client setDefaultHeader:@"A-Auth-Token" value:[[UserInfo instance] getToken]];
    }else {
        [client setDefaultHeader:@"A-Auth-Token" value:[[UserInfo instance] getTempToken]];
    }
    [client getPath:FAVORITES parameters:@{@"page":page} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError * error = nil;
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
        NSLog(@"dict.....%@",dict);
        int code = [dict[@"code"] intValue];
        if (responseObject == nil || code == 0) {
            NSError *error = [[NSError alloc] initWithDomain:@"" code:0 userInfo:dict];
            failure(error);
        } else {
            success(dict);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];

}

//接口有问题，需要修改
+(void)newFavorites:(NSDictionary *)favorites onSuccess:(DICTIONARY_BLOCK)success onFailure:(ERROR_BLOCK)failure {
    AFClient * client = [AFClient shareClient];
    if ([[UserInfo instance] getToken]) {
        [client setDefaultHeader:@"A-Auth-Token" value:[[UserInfo instance] getToken]];
    }else {
        [client setDefaultHeader:@"A-Auth-Token" value:[[UserInfo instance] getTempToken]];
    }
    [client postPath:NEWFAVORITES parameters:favorites success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError * error = nil;
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
        int code = [dict[@"code"]intValue];
        NSLog(@"dict....%@",dict);
        if (code == 0 || responseObject == nil) {
            error = [[NSError alloc] initWithDomain:@"" code:0 userInfo:dict];
            failure(error);
        }else {
            //NSString * str = [dict objectForKey:@"message"];
            success(dict);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];

}

//删除单个收藏
+(void)delSingleFavoriteId:(NSString *)favoritesId onSuccess:(STRING_BLOCK)success
                 onFailure:(ERROR_BLOCK)failure
{
    AFClient * client = [AFClient shareClient];
    if ([[UserInfo instance] getToken]) {
        [client setDefaultHeader:@"A-Auth-Token" value:[[UserInfo instance] getToken]];
    }else {
        [client setDefaultHeader:@"A-Auth-Token" value:[[UserInfo instance] getTempToken]];
    }
    NSString* path = [NSString stringWithFormat:@"favorites/%@",favoritesId];
    [client deletePath:path parameters:favoritesId success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError * error = nil;
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
        NSLog(@"dict.....%@",dict);
        int code = [dict[@"code"] intValue];
        if (responseObject == nil || code == 0) {
            NSError *error = [[NSError alloc] initWithDomain:@"" code:0 userInfo:dict];
            failure(error);
        } else {
            success([dict objectForKey:@"message"]);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
}

//删除收藏
+(void)delFavoritesId:(NSDictionary *)favoritesId onSuccess:(STRING_BLOCK)success onFailure:(ERROR_BLOCK)failure {
    AFClient * client = [AFClient shareClient];
    if ([[UserInfo instance] getToken]) {
        [client setDefaultHeader:@"A-Auth-Token" value:[[UserInfo instance] getToken]];
    }else {
        [client setDefaultHeader:@"A-Auth-Token" value:[[UserInfo instance] getTempToken]];
    }
        [client deletePath:DELFAVORITES parameters:favoritesId success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError * error = nil;
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
        NSLog(@"dict.....%@",dict);
        int code = [dict[@"code"] intValue];
        if (responseObject == nil || code == 0) {
            NSError *error = [[NSError alloc] initWithDomain:@"" code:0 userInfo:dict];
            failure(error);
        } else {
            success([dict objectForKey:@"message"]);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
}

+(void)getMyCenterSuccess:(DICTIONARY_BLOCK)success onFailure:(ERROR_BLOCK)failure {
    AFClient * client = [AFClient shareClient];
    if ([[UserInfo instance] getToken]) {
        [client setDefaultHeader:@"A-Auth-Token" value:[[UserInfo instance] getToken]];
        NSLog(@"token....%@",[[UserInfo instance] getToken]);
    }else {
        [client setDefaultHeader:@"A-Auth-Token" value:[[UserInfo instance] getTempToken]];
    }
    [client getPath:USERPROFILE parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError * error = nil;
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
        NSLog(@"dict.....%@",dict);
        int code = [dict[@"code"] intValue];
        if (responseObject == nil || code == 0) {
            error = [[NSError alloc] initWithDomain:@"" code:0 userInfo:dict];
            failure(error);
        } else {
            success(dict);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];

}

+(void)createTempUserSuccess:(STRING_BLOCK)success onFailure:(ERROR_BLOCK)failure {
    AFClient * client = [AFClient shareClient];
    [client postPath:TEMPUSER parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError * error = nil;
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
        int code = [dict[@"code"] intValue];
        if (responseObject == nil || code == 0) {
            error = [[NSError alloc] initWithDomain:@"" code:0 userInfo:dict];
            failure(error);
        } else {
            [[UserInfo instance] saveTempToken:dict[@"auth_token"]];
            success(dict[@"message"]);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
}








+(void)getOrdersPage:(NSString *)page Success:(DICTIONARY_BLOCK)success onFailure:(ERROR_BLOCK)failure {
    AFClient * client = [AFClient shareClient];
    if ([[UserInfo instance] getToken]) {
        [client setDefaultHeader:@"A-Auth-Token" value:[[UserInfo instance] getToken]];
    }else {
        [client setDefaultHeader:@"A-Auth-Token" value:[[UserInfo instance] getTempToken]];
    }
    [client getPath:ORDERS parameters:@{@"page":page} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError * error = nil;
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
        int code = [dict[@"code"] intValue];
        if (responseObject == nil || code == 0) {
            error = [[NSError alloc] initWithDomain:@"" code:0 userInfo:dict];
            failure(error);
        } else {
            success(dict);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
}


+(void)getVaildCodePhone:(NSString *)phone onSuccess:(STRING_BLOCK)success onFailure:(ERROR_BLOCK)failure {
    AFClient * client = [AFClient shareClient];
    if ([[UserInfo instance] getToken]) {
        [client setDefaultHeader:@"A-Auth-Token" value:[[UserInfo instance] getToken]];
    }else {
        [client setDefaultHeader:@"A-Auth-Token" value:[[UserInfo instance] getTempToken]];
    }
    
    [client getPath:VALIDCODE parameters:@{@"phone":phone} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError * error = nil;
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
        int code = [dict[@"code"] intValue];
        if (responseObject == nil || code == 0) {
            error = [[NSError alloc] initWithDomain:@"" code:0 userInfo:dict];
            failure(error);
        } else {
            success([dict objectForKey:@"code"]);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
}

+(void)getCustomsListPage:(NSString *)page Success:(DICTIONARY_BLOCK)success onFailure:(ERROR_BLOCK)failure {
    AFClient * client = [AFClient shareClient];
    if ([[UserInfo instance] getToken]) {
        [client setDefaultHeader:@"A-Auth-Token" value:[[UserInfo instance] getToken]];
    }else {
        [client setDefaultHeader:@"A-Auth-Token" value:[[UserInfo instance] getTempToken]];
    }
    [client getPath:GETCUSTOMSLIST parameters:@{@"page":page} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError * error = nil;
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
        int code = [dict[@"code"] intValue];
        if (responseObject == nil || code == 0) {
            error = [[NSError alloc] initWithDomain:@"" code:0 userInfo:dict];
            failure(error);
        } else {
            success(dict);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];

}










+(void)threeLoginProvider:(NSString *)provider uid:(NSString *)uid name:(NSString *)name avatar:(NSString *)avatar onSuccess:(STRING_BLOCK)success onFailure:(ERROR_BLOCK)failure{
    AFClient * client = [AFClient shareClient];
    if ([[UserInfo instance] getToken]) {
        [client setDefaultHeader:@"A-Auth-Token" value:[[UserInfo instance] getToken]];
    }else {
        [client setDefaultHeader:@"A-Auth-Token" value:[[UserInfo instance] getTempToken]];
    }
    NSString * str = [NSString stringWithFormat:@"users/%@/sign_in",provider];
    
    [client postPath:str parameters:@{@"uid":uid,@"name":name,@"avatar":avatar,} success:^(AFHTTPRequestOperation *operation, id responseObject) {

        NSError * error = nil;
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
        int code = [dict[@"code"] intValue];
        if (responseObject == nil || code == 0) {
            error = [[NSError alloc] initWithDomain:@"" code:0 userInfo:dict];
            failure(error);
        } else {

            [[UserInfo instance] saveToken:[dict objectForKey:@"auth_token"]];
            success([dict objectForKey:@"extend_message"]);

        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
}

+(void)outonSuccess:(STRING_BLOCK)success onFailure:(ERROR_BLOCK)failure {
    AFClient * client = [AFClient shareClient];
    if ([[UserInfo instance] getToken]) {
        [client setDefaultHeader:@"A-Auth-Token" value:[[UserInfo instance] getToken]];
        [client postPath:OUT parameters:@{@"A-Auth-Token":[[UserInfo instance] getToken]} success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSError * error = nil;
            NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
            int code = [dict[@"code"] intValue];
            if (responseObject == nil || code == 0) {
                error = [[NSError alloc] initWithDomain:@"" code:0 userInfo:dict];
                failure(error);
            } else {
                
                [[UserInfo instance] removeToken];
                success([dict objectForKey:@"message"]);
                
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            failure(error);
        }];

    }

}

+(void)chengeNikeName:(NSString *)name onSuccess:(STRING_BLOCK)success onFailure:(ERROR_BLOCK)failure {
    AFClient * client = [AFClient shareClient];
    if ([[UserInfo instance] getToken]) {
        [client setDefaultHeader:@"A-Auth-Token" value:[[UserInfo instance] getToken]];
    }else {
        [client setDefaultHeader:@"A-Auth-Token" value:[[UserInfo instance] getTempToken]];
    }

    [client postPath:CHENGENIKE parameters:@{@"user":@{@"name":name}} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSError * error = nil;
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
        int code = [dict[@"code"] intValue];
        if (responseObject == nil || code == 0) {
            error = [[NSError alloc] initWithDomain:@"" code:0 userInfo:dict];
            failure(error);
        } else {
            success([dict objectForKey:@"message"]);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];

}



+(void)cancelOrderId:(NSString *)orderId onSuccess:(STRING_BLOCK)success onFailure:(ERROR_BLOCK)failure {
    AFClient * client = [AFClient shareClient];
    if ([[UserInfo instance] getToken]) {
        [client setDefaultHeader:@"A-Auth-Token" value:[[UserInfo instance] getToken]];
    }else {
        [client setDefaultHeader:@"A-Auth-Token" value:[[UserInfo instance] getTempToken]];
    }
    
    NSString * url = [NSString stringWithFormat:@"orders/%@/cancel",orderId];
    [client postPath:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError * error = nil;
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
        int code = [dict[@"code"] intValue];
        if (responseObject == nil || code == 0) {
            error = [[NSError alloc] initWithDomain:@"" code:0 userInfo:dict];
            failure(error);
        } else {
            success([dict objectForKey:@"message"]);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
}

+(void)getMeasureMentSytleID:(NSString*)style_id  Success:(DICTIONARY_BLOCK)success onFailure:(ERROR_BLOCK)failure {
    AFClient * client = [AFClient shareClient];
    if ([[UserInfo instance] getToken]) {
        [client setDefaultHeader:@"A-Auth-Token" value:[[UserInfo instance] getToken]];
    }else {
        [client setDefaultHeader:@"A-Auth-Token" value:[[UserInfo instance] getTempToken]];
    }
    [client getPath:@"public/measurement" parameters:@{@"style_id": style_id} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSError * error = nil;
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
        int code = [dict[@"code"] intValue];
        if (responseObject == nil || code == 0) {
            error = [[NSError alloc] initWithDomain:@"" code:0 userInfo:dict];
            failure(error);
        } else {
            success(dict);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
}


+(void)getMeasureMentSytleID:(NSString*)style_id Gender:(NSString *)gender Success:(DICTIONARY_BLOCK)success onFailure:(ERROR_BLOCK)failure {
            AFClient * client = [AFClient shareClient];
            if ([[UserInfo instance] getToken]) {
                [client setDefaultHeader:@"A-Auth-Token" value:[[UserInfo instance] getToken]];
            }else {
                [client setDefaultHeader:@"A-Auth-Token" value:[[UserInfo instance] getTempToken]];
            }
    [client getPath:@"public/measurement" parameters:@{@"style_id": style_id,@"gender":gender} success:^(AFHTTPRequestOperation *operation, id responseObject) {

        NSError * error = nil;
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
        int code = [dict[@"code"] intValue];
        if (responseObject == nil || code == 0) {
            error = [[NSError alloc] initWithDomain:@"" code:0 userInfo:dict];
            failure(error);
        } else {
            success(dict);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
}

+(void)getDocumentKind:(int)kind Success:(DICTIONARY_BLOCK)success onFailure:(ERROR_BLOCK)failure
{
    AFClient * client = [AFClient shareClient];
    if ([[UserInfo instance] getToken]) {
        [client setDefaultHeader:@"A-Auth-Token" value:[[UserInfo instance] getToken]];
    }else {
        [client setDefaultHeader:@"A-Auth-Token" value:[[UserInfo instance] getTempToken]];
    }
    [client getPath:@"public/document" parameters:@{@"kind":[NSString stringWithFormat:@"%d",kind]} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSError * error = nil;
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
        int code = [dict[@"code"] intValue];
        if (responseObject == nil || code == 0) {
            error = [[NSError alloc] initWithDomain:@"" code:0 userInfo:dict];
            failure(error);
        } else {
            success(dict);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
}


+(void)getCustomsClothId:(NSString *)clothId onSuccess:(DICTIONARY_BLOCK)success onFailure:(ERROR_BLOCK)failure {
    AFClient * client = [AFClient shareClient];
    if ([[UserInfo instance] getToken]) {
        [client setDefaultHeader:@"A-Auth-Token" value:[[UserInfo instance] getToken]];
    }else {
        [client setDefaultHeader:@"A-Auth-Token" value:[[UserInfo instance] getTempToken]];
    }
    NSString * url = [NSString stringWithFormat:@"customs/design/%@",clothId];
    [client getPath:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSError * error = nil;
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
        int code = [dict[@"code"] intValue];
        if (responseObject == nil || code == 0) {
            error = [[NSError alloc] initWithDomain:@"" code:0 userInfo:dict];
            failure(error);
        } else {
            success(dict);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];

}

+(void)getVersions:(NSString *)ver system:(NSString *)system onSuccess:(DICTIONARY_BLOCK)success onFailure:(ERROR_BLOCK)failure {
    AFClient * client = [AFClient shareClient];
    if ([[UserInfo instance] getToken]) {
        [client setDefaultHeader:@"A-Auth-Token" value:[[UserInfo instance] getToken]];
    }else {
        [client setDefaultHeader:@"A-Auth-Token" value:[[UserInfo instance] getTempToken]];
    }
    [client getPath:UPDATASYSTEM parameters:@{@"tag": ver,@"sys": system} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSError * error = nil;
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
        int code = [dict[@"code"] intValue];
        if (responseObject == nil || code == 0) {
            error = [[NSError alloc] initWithDomain:@"" code:0 userInfo:dict];
            failure(error);
        } else {
            success(dict);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];

}

+(void)getContentPhoneSuccess:(DICTIONARY_BLOCK)success onFailure:(ERROR_BLOCK)failure {
    AFClient * client = [AFClient shareClient];
    if ([[UserInfo instance] getToken]) {
        [client setDefaultHeader:@"A-Auth-Token" value:[[UserInfo instance] getToken]];
    }else {
        [client setDefaultHeader:@"A-Auth-Token" value:[[UserInfo instance] getTempToken]];
    }
    [client getPath:ABOUTUS parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSError * error = nil;
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
        int code = [dict[@"code"] intValue];
        if (responseObject == nil || code == 0) {
            error = [[NSError alloc] initWithDomain:@"" code:0 userInfo:dict];
            failure(error);
        } else {
            success(dict);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
    
}

+(void)getHomePage:(NSString *)width heiht:(NSString *)heiht Success:(DICTIONARY_BLOCK)success onFailure:(ERROR_BLOCK)failure {
    AFClient * client = [AFClient shareClient];
    [client getPath:HOMEPAGE parameters:@{@"width":width,@"height":heiht} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSError * error = nil;
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
        int code = [dict[@"code"] intValue];
        if (responseObject == nil || code == 0) {
            error = [[NSError alloc] initWithDomain:@"" code:0 userInfo:dict];
            failure(error);
        } else {
            success(dict);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
        if (operation.response.statusCode == 401) {
            [[UserInfo instance] removeToken];
        }
        
    }];
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    
}


@end
