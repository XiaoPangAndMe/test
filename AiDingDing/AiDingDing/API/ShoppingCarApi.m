//
//  ShoppingCarApi.m
//  AiDingDing
//
//  Created by libohao on 15/1/13.
//  Copyright (c) 2015年 bestapp. All rights reserved.
//

#import "ShoppingCarApi.h"
#import "ErrorHandler.h"

@implementation ShoppingCarApi

+(void)shoppingCarListSuccess:(DICTIONARY_BLOCK)success onFailure:(ERROR_BLOCK)failure {
    AFClient * client = [AFClient shareClient];
    if ([[UserInfo instance] getToken]) {
        [client setDefaultHeader:@"A-Auth-Token" value:[[UserInfo instance] getToken]];
        NSLog(@"getToken...%@",[[UserInfo instance] getToken]);
    }else {
        [client setDefaultHeader:@"A-Auth-Token" value:[[UserInfo instance] getTempToken]];
        NSLog(@"getTempToken...%@",[[UserInfo instance] getTempToken]);
    }
    [client getPath:SHOPPINGCAR parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError * error = nil;
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
        int code = [dict[@"code"] intValue];
        NSLog(@"正在进行中。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。");

        NSLog(@"dict...%@",dict);
        if (responseObject == nil || code == 0) {
            error = [[NSError alloc] initWithDomain:@"" code:0 userInfo:dict];
            failure(error);
        } else {
            success(dict);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (![[ErrorHandler instance]blockOperation:operation]) {
            failure(error);
        }else{
            [[ErrorHandler instance]handleError:operation];
        }
    }];
}

+(void)addShopping:(NSDictionary *)para onSuccess:(STRING_BLOCK)success onFailure:(ERROR_BLOCK)failure {
    AFClient * client = [AFClient shareClient];
    if ([[UserInfo instance] getToken]) {
        [client setDefaultHeader:@"A-Auth-Token" value:[[UserInfo instance] getToken]];
    }else {
        [client setDefaultHeader:@"A-Auth-Token" value:[[UserInfo instance] getTempToken]];
    }
    NSLog(@"para...%@",para);
    [client postPath:ADDSHOPPINGCAR parameters:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError * error = nil;
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
        int code = [dict[@"code"] intValue];
        NSLog(@"dict...%@",dict);
        if (responseObject == nil || code == 0) {
            error = [[NSError alloc] initWithDomain:@"" code:0 userInfo:dict];
            failure(error);
        } else {
            //            NSLog(@"dict...%@",dict);
            success([NSString stringWithFormat:@"%@",dict[@"code"]]);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (![[ErrorHandler instance]blockOperation:operation]) {
            failure(error);
        }else{
            [[ErrorHandler instance]handleError:operation];
        }
    }];
    
}

//组合添加购物车
+ (void)addCombaineShopping:(NSDictionary*)para onSuccess:(STRING_BLOCK)success onFailure:(ERROR_BLOCK)failure
{
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:BASE_API_URL]];
    
    if ([[UserInfo instance] getToken]) {
        [client setDefaultHeader:@"A-Auth-Token" value:[[UserInfo instance] getToken]];
    }else {
        [client setDefaultHeader:@"A-Auth-Token" value:[[UserInfo instance] getTempToken]];
    }
    [client postPath:COMBINE_SHOPING_CAR parameters:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError * error = nil;
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
        int code = [dict[@"code"] intValue];
        NSLog(@"dict...%@",dict);
        if (responseObject == nil || code == 0) {
            error = [[NSError alloc] initWithDomain:@"" code:0 userInfo:dict];
            failure(error);
        } else {
            //            NSLog(@"dict...%@",dict);
            success([NSString stringWithFormat:@"%@",dict[@"code"]]);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (![[ErrorHandler instance]blockOperation:operation]) {
            failure(error);
        }else{
            [[ErrorHandler instance]handleError:operation];
        }
    }];

    
}


//update shoppingcar
+(void)updateShoppingCarID:(NSString*)carId Para:(NSDictionary*)para onSuccess:(STRING_BLOCK)success onFailure:(ERROR_BLOCK)failure
{
    AFClient * client = [AFClient shareClient];
    if ([[UserInfo instance] getToken]) {
        [client setDefaultHeader:@"A-Auth-Token" value:[[UserInfo instance] getToken]];
    }else {
        [client setDefaultHeader:@"A-Auth-Token" value:[[UserInfo instance] getTempToken]];
    }
    NSLog(@"para...%@",para);
//    NSLog(@"正在进行中。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。");

    NSString* path = [NSString stringWithFormat:@"shopping_cars/%@/update",carId];
    [client postPath:path parameters:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError * error = nil;
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
        int code = [dict[@"code"] intValue];
        NSLog(@"dict...%@",dict);
        if (responseObject == nil || code == 0) {
            error = [[NSError alloc] initWithDomain:@"" code:0 userInfo:dict];
            failure(error);
        } else {
            //            NSLog(@"dict...%@",dict);
            success([NSString stringWithFormat:@"%@",dict[@"code"]]);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (![[ErrorHandler instance]blockOperation:operation]) {
            failure(error);
        }else{
            [[ErrorHandler instance]handleError:operation];
        }
    }];
    
}

+(void)updateCombineShoppingWithPara:(NSDictionary*)para onSuccess:(STRING_BLOCK)success onFailure:(ERROR_BLOCK)failure
{
    AFClient * client = [AFClient shareClient];
    if ([[UserInfo instance] getToken]) {
        [client setDefaultHeader:@"A-Auth-Token" value:[[UserInfo instance] getToken]];
    }else {
        [client setDefaultHeader:@"A-Auth-Token" value:[[UserInfo instance] getTempToken]];
    }
    NSLog(@"para...%@",para);
    //    NSLog(@"正在进行中。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。");
    
    NSString* path = [NSString stringWithFormat:@"/shopping_cars/combine/create"];
    [client postPath:path parameters:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError * error = nil;
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
        int code = [dict[@"code"] intValue];
        NSLog(@"dict...%@",dict);
        if (responseObject == nil || code == 0) {
            error = [[NSError alloc] initWithDomain:@"" code:0 userInfo:dict];
            failure(error);
        } else {
            //            NSLog(@"dict...%@",dict);
            success([NSString stringWithFormat:@"%@",dict[@"code"]]);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (![[ErrorHandler instance]blockOperation:operation]) {
            failure(error);
        }else{
            [[ErrorHandler instance]handleError:operation];
        }
    }];

}


+(void)deleteShoppingCar:(NSString*)carId onSuccess:(STRING_BLOCK)success onFailure:(ERROR_BLOCK)failure
{
    AFClient * client = [AFClient shareClient];
    if ([[UserInfo instance] getToken]) {
        [client setDefaultHeader:@"A-Auth-Token" value:[[UserInfo instance] getToken]];
    }else {
        [client setDefaultHeader:@"A-Auth-Token" value:[[UserInfo instance] getTempToken]];
    }
//    NSLog(@"正在进行中。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。");
    
    NSString* path = [NSString stringWithFormat:@"shopping_cars/%@",carId];
    [client deletePath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError * error = nil;
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
        int code = [dict[@"code"] intValue];
        NSLog(@"dict...%@",dict);
        if (responseObject == nil || code == 0) {
            error = [[NSError alloc] initWithDomain:@"" code:0 userInfo:dict];
            failure(error);
        } else {
            //            NSLog(@"dict...%@",dict);
            success([NSString stringWithFormat:@"%@",dict[@"code"]]);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (![[ErrorHandler instance]blockOperation:operation]) {
            failure(error);
        }else{
            [[ErrorHandler instance]handleError:operation];
        }
    }];
}

+(void)createShoppingCars:(DICTIONARY_BLOCK)params onSuccess:(DICTIONARY_BLOCK)success onFailure:(ERROR_BLOCK)failure {
    AFClient * client = [AFClient shareClient];
    if ([[UserInfo instance] getToken]) {
        [client setDefaultHeader:@"A-Auth-Token" value:[[UserInfo instance] getToken]];
    }else {
        [client setDefaultHeader:@"A-Auth-Token" value:[[UserInfo instance] getTempToken]];
    }
    
     [client getPath:SHOPPINGCARSCREATE parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
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
        if (![[ErrorHandler instance]blockOperation:operation]) {
            failure(error);
        }else{
            [[ErrorHandler instance]handleError:operation];
        }
    }];
}

+(void)createShoppingCarsMuiti:(NSDictionary*)params onSuccess:(DICTIONARY_BLOCK)success onFailure:(ERROR_BLOCK)failure;
{
    AFClient * client = [AFClient shareClient];
    if ([[UserInfo instance] getToken]) {
        [client setDefaultHeader:@"A-Auth-Token" value:[[UserInfo instance] getToken]];
    }else {
        [client setDefaultHeader:@"A-Auth-Token" value:[[UserInfo instance] getTempToken]];
    }
    [client postPath:SHOPPINGCARSCREATE_MULTI parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
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
        if (![[ErrorHandler instance]blockOperation:operation]) {
            failure(error);
        }else{
            [[ErrorHandler instance]handleError:operation];
        }
    }];
    
}


+(void)commitCreateCarId:(NSArray *)carId addressId:(NSString *)addressId expressID:(NSString*)expressId onSuccess:(DICTIONARY_BLOCK)success onFailure:(ERROR_BLOCK)failure {
//    AFClient * client = [AFClient shareClient];
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:NEW_BASE_URL]];
    /***创建订单接口可能变车过V2（版本2）***/
    if ([[UserInfo instance] getToken]) {
        [client setDefaultHeader:@"A-Auth-Token" value:[[UserInfo instance] getToken]];
    }else {
        [client setDefaultHeader:@"A-Auth-Token" value:[[UserInfo instance] getTempToken]];
    }
    [client postPath:ORDERSCREATE parameters:@{@"car_ids":carId==nil?@"":carId,
                                               @"address_id":addressId==nil?@"":addressId,
                                               @"express_company":expressId==nil?@"":expressId
                                               }
             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                 NSError * error = nil;
                 NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
                 
                 NSLog(@"dict = %@",dict);
                 
                 int code = [dict[@"code"] intValue];
                 if (responseObject == nil || code == 0) {
                     error = [[NSError alloc] initWithDomain:@"" code:0 userInfo:dict];
                     failure(error);
                 } else {
                     success(dict);
                 }
             } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                 if (![[ErrorHandler instance]blockOperation:operation]) {
                     failure(error);
                 }else{
                     [[ErrorHandler instance]handleError:operation];
                 }
             }];
}




+(void)newGetFreightCarId:(NSArray *)carId  postcode:(NSString *)postcode spcids:(NSString *)spcids    onSuccess:(DICTIONARY_BLOCK)success onFailure:(ERROR_BLOCK)failure
{
    AFClient * client = [AFClient newShareClient];
    if ([[UserInfo instance] getToken]) {
        [client setDefaultHeader:@"A-Auth-Token" value:[[UserInfo instance] getToken]];
    }else {
        [client setDefaultHeader:@"A-Auth-Token" value:[[UserInfo instance] getTempToken]];
    }
    if (postcode==nil)
    {
        postcode = @"";
    }
    [client getPath:FREIGHTCAL2 parameters:@{@"spcids":spcids,
                                             @"postcode":postcode
                                             }
            success:^(AFHTTPRequestOperation *operation, id responseObject) {
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
        if (![[ErrorHandler instance]blockOperation:operation]) {
            failure(error);
        }else{
            [[ErrorHandler instance]handleError:operation];
        }
    }];
    
}



+(void)getFreightCarId:(NSArray *)carId postcode:(NSString *)postcode onSuccess:(DICTIONARY_BLOCK)success onFailure:(ERROR_BLOCK)failure {
    AFClient * client = [AFClient shareClient];
    if ([[UserInfo instance] getToken]) {
        [client setDefaultHeader:@"A-Auth-Token" value:[[UserInfo instance] getToken]];
    }else {
        [client setDefaultHeader:@"A-Auth-Token" value:[[UserInfo instance] getTempToken]];
    }
    if (postcode==nil)
    {
        postcode = @"";
    }
    
    [client getPath:FREIGHTCAL parameters:@{@"postcode":postcode} success:^(AFHTTPRequestOperation *operation, id responseObject) {
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
        if (![[ErrorHandler instance]blockOperation:operation]) {
            failure(error);
        }else{
            [[ErrorHandler instance]handleError:operation];
        }
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
        if (![[ErrorHandler instance]blockOperation:operation]) {
            failure(error);
        }else{
            [[ErrorHandler instance]handleError:operation];
        }
    }];
}

+(void)reOrder:(NSString*)orderID onSuccess:(DICTIONARY_BLOCK)success onFailure:(ERROR_BLOCK)failure
{
    AFClient * client = [AFClient shareClient];
    if ([[UserInfo instance] getToken]) {
        [client setDefaultHeader:@"A-Auth-Token" value:[[UserInfo instance] getToken]];
    }else {
        [client setDefaultHeader:@"A-Auth-Token" value:[[UserInfo instance] getTempToken]];
    }
    
    NSString * url = [NSString stringWithFormat:@"orders/%@/reorder",orderID];
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
        if (![[ErrorHandler instance]blockOperation:operation]) {
            failure(error);
        }else{
            [[ErrorHandler instance]handleError:operation];
        }
    }];
}
@end


//#import "ShoppingCarApi.h"
//
//@implementation ShoppingCarApi
//
//+(void)shoppingCarListSuccess:(DICTIONARY_BLOCK)success onFailure:(ERROR_BLOCK)failure {
//    AFClient * client = [AFClient shareClient];
//    if ([[UserInfo instance] getToken]) {
//        [client setDefaultHeader:@"A-Auth-Token" value:[[UserInfo instance] getToken]];
//        NSLog(@"getToken...%@",[[UserInfo instance] getToken]);
//    }else {
//        [client setDefaultHeader:@"A-Auth-Token" value:[[UserInfo instance] getTempToken]];
//        NSLog(@"getTempToken...%@",[[UserInfo instance] getTempToken]);
//    }
//    [client getPath:SHOPPINGCAR parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSError * error = nil;
//        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
//        int code = [dict[@"code"] intValue];
//        NSLog(@"dict...%@",dict);
//        if (responseObject == nil || code == 0) {
//            error = [[NSError alloc] initWithDomain:@"" code:0 userInfo:dict];
//            failure(error);
//        } else {
//            success(dict);
//        }
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        failure(error);
//    }];
//}
//
//+(void)addShopping:(NSDictionary *)para onSuccess:(STRING_BLOCK)success onFailure:(ERROR_BLOCK)failure {
//    AFClient * client = [AFClient shareClient];
//    if ([[UserInfo instance] getToken]) {
//        [client setDefaultHeader:@"A-Auth-Token" value:[[UserInfo instance] getToken]];
//    }else {
//        [client setDefaultHeader:@"A-Auth-Token" value:[[UserInfo instance] getTempToken]];
//    }
//    NSLog(@"para...%@",para);
//    [client postPath:ADDSHOPPINGCAR parameters:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSError * error = nil;
//        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
//        int code = [dict[@"code"] intValue];
//        NSLog(@"dict...%@",dict);
//        if (responseObject == nil || code == 0) {
//            error = [[NSError alloc] initWithDomain:@"" code:0 userInfo:dict];
//            failure(error);
//        } else {
//            //            NSLog(@"dict...%@",dict);
//            success([NSString stringWithFormat:@"%@",dict[@"code"]]);
//        }
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        failure(error);
//    }];
//    
//}
//
////update shoppingcar
//+(void)updateShoppingCarID:(NSString*)carId Para:(NSDictionary*)para onSuccess:(STRING_BLOCK)success onFailure:(ERROR_BLOCK)failure
//{
//    AFClient * client = [AFClient shareClient];
//    if ([[UserInfo instance] getToken]) {
//        [client setDefaultHeader:@"A-Auth-Token" value:[[UserInfo instance] getToken]];
//    }else {
//        [client setDefaultHeader:@"A-Auth-Token" value:[[UserInfo instance] getTempToken]];
//    }
//    NSLog(@"para...%@",para);
//    NSString* path = [NSString stringWithFormat:@"shopping_cars/%@/update",carId];
//    [client postPath:path parameters:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSError * error = nil;
//        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
//        int code = [dict[@"code"] intValue];
//        NSLog(@"dict...%@",dict);
//        if (responseObject == nil || code == 0) {
//            error = [[NSError alloc] initWithDomain:@"" code:0 userInfo:dict];
//            failure(error);
//        } else {
//            //            NSLog(@"dict...%@",dict);
//            success([NSString stringWithFormat:@"%@",dict[@"code"]]);
//        }
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        failure(error);
//    }];
//    
//}
//
//+(void)deleteShoppingCar:(NSString*)carId onSuccess:(STRING_BLOCK)success onFailure:(ERROR_BLOCK)failure
//{
//    AFClient * client = [AFClient shareClient];
//    if ([[UserInfo instance] getToken]) {
//        [client setDefaultHeader:@"A-Auth-Token" value:[[UserInfo instance] getToken]];
//    }else {
//        [client setDefaultHeader:@"A-Auth-Token" value:[[UserInfo instance] getTempToken]];
//    }
//    NSString* path = [NSString stringWithFormat:@"shopping_cars/%@",carId];
//    [client deletePath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSError * error = nil;
//        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
//        int code = [dict[@"code"] intValue];
//        NSLog(@"dict...%@",dict);
//        if (responseObject == nil || code == 0) {
//            error = [[NSError alloc] initWithDomain:@"" code:0 userInfo:dict];
//            failure(error);
//        } else {
//            //            NSLog(@"dict...%@",dict);
//            success([NSString stringWithFormat:@"%@",dict[@"code"]]);
//        }
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        failure(error);
//    }];
//}
//
//+(void)createShoppingCars:(DICTIONARY_BLOCK)params onSuccess:(DICTIONARY_BLOCK)success onFailure:(ERROR_BLOCK)failure {
//    AFClient * client = [AFClient shareClient];
//    if ([[UserInfo instance] getToken]) {
//        [client setDefaultHeader:@"A-Auth-Token" value:[[UserInfo instance] getToken]];
//    }else {
//        [client setDefaultHeader:@"A-Auth-Token" value:[[UserInfo instance] getTempToken]];
//    }
//    [client getPath:SHOPPINGCARSCREATE parameters:success success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSError * error = nil;
//        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
//        int code = [dict[@"code"] intValue];
//        if (responseObject == nil || code == 0) {
//            error = [[NSError alloc] initWithDomain:@"" code:0 userInfo:dict];
//            failure(error);
//        } else {
//            success(dict);
//        }
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        failure(error);
//    }];
//}
//
//+(void)createShoppingCarsMuiti:(NSDictionary*)params onSuccess:(DICTIONARY_BLOCK)success onFailure:(ERROR_BLOCK)failure;
//{
//    AFClient * client = [AFClient shareClient];
//    if ([[UserInfo instance] getToken]) {
//        [client setDefaultHeader:@"A-Auth-Token" value:[[UserInfo instance] getToken]];
//    }else {
//        [client setDefaultHeader:@"A-Auth-Token" value:[[UserInfo instance] getTempToken]];
//    }
//    [client postPath:SHOPPINGCARSCREATE_MULTI parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSError * error = nil;
//        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
//        int code = [dict[@"code"] intValue];
//        if (responseObject == nil || code == 0) {
//            error = [[NSError alloc] initWithDomain:@"" code:0 userInfo:dict];
//            failure(error);
//        } else {
//            success(dict);
//        }
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        failure(error);
//    }];
//    
//}
//
//+(void)commitCreateCarId:(NSArray *)carId addressId:(NSString *)addressId expressID:(NSString*)expressId onSuccess:(DICTIONARY_BLOCK)success onFailure:(ERROR_BLOCK)failure {
//    AFClient * client = [AFClient shareClient];
//    if ([[UserInfo instance] getToken]) {
//        [client setDefaultHeader:@"A-Auth-Token" value:[[UserInfo instance] getToken]];
//    }else {
//        [client setDefaultHeader:@"A-Auth-Token" value:[[UserInfo instance] getTempToken]];
//    }
//    [client postPath:ORDERSCREATE parameters:@{@"car_ids":carId,
//                                               @"address_id":addressId,
//                                               @"express_company":expressId
//                                               }
//             success:^(AFHTTPRequestOperation *operation, id responseObject) {
//                 NSError * error = nil;
//                 NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
//                 int code = [dict[@"code"] intValue];
//                 if (responseObject == nil || code == 0) {
//                     error = [[NSError alloc] initWithDomain:@"" code:0 userInfo:dict];
//                     failure(error);
//                 } else {
//                     success(dict);
//                 }
//             } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//                 failure(error);
//             }];
//}
//
//+(void)getFreightCarId:(NSArray *)carId postcode:(NSString *)postcode onSuccess:(DICTIONARY_BLOCK)success onFailure:(ERROR_BLOCK)failure {
//    AFClient * client = [AFClient shareClient];
//    if ([[UserInfo instance] getToken]) {
//        [client setDefaultHeader:@"A-Auth-Token" value:[[UserInfo instance] getToken]];
//    }else {
//        [client setDefaultHeader:@"A-Auth-Token" value:[[UserInfo instance] getTempToken]];
//    }
//    [client getPath:FREIGHTCAL parameters:@{@"postcode":postcode} success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSError * error = nil;
//        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
//        int code = [dict[@"code"] intValue];
//        if (responseObject == nil || code == 0) {
//            error = [[NSError alloc] initWithDomain:@"" code:0 userInfo:dict];
//            failure(error);
//        } else {
//            success(dict);
//        }
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        failure(error);
//    }];
//    
//}
//
//
//@end
