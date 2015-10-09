//
//  CustomApi.m
//  AiDingDing
//
//  Created by libohao on 15/1/13.
//  Copyright (c) 2015年 bestapp. All rights reserved.
//

#import "CustomApi.h"
#import "AFHTTPRequestOperation.h"
#import <UIKit/UIKit.h>
@implementation CustomApi


+(void)getCustomDesignOptionsOnSuccess:(DICTIONARY_BLOCK)success onFailure:(ERROR_BLOCK)failure
{
    AFClient * client = [AFClient shareClient];
    if ([[UserInfo instance] getToken]) {
        [client setDefaultHeader:@"A-Auth-Token" value:[[UserInfo instance] getToken]];
    }else {
        [client setDefaultHeader:@"A-Auth-Token" value:[[UserInfo instance] getTempToken]];
    }
    
    [client getPath:CUSTOM_DESIGN parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError * error = nil;
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
        int code = [dict[@"code"] intValue];
        NSLog(@"dict...%@",dict);
        if (responseObject == nil || code == 0) {
            error = [[NSError alloc] initWithDomain:@"" code:0 userInfo:dict];
            failure(error);
        } else {
            //            NSLog(@"dict...%@",dict);
            success(dict);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
}


+(void)createCustomDesignStyleID:(NSString*)styleId material_ID:(NSString*)material_ids clothes_count:(NSString *)clothes_count front_layer:(NSData*)front_layer front_image:(NSData*)front_image back_image:(NSData*)back_img back_layer:(NSData *)back_layer Success:(DICTIONARY_BLOCK)success
                        Progress:(PROGRESS_BLOCK)progress onFailure:(ERROR_BLOCK)failure

{
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:NEW_BASE_URL]];
       NSDictionary* designDic = nil;
    if ([[UserInfo instance] getToken]) {
        [client setDefaultHeader:@"A-Auth-Token" value:[[UserInfo instance] getToken]];
        designDic   = @{
                        @"A-Auth-Token":[[UserInfo instance] getToken],
                        @"style_id":styleId,
                        @"material_ids":material_ids,
                        @"clothes_count":clothes_count,
                        };
    }else {
        [client setDefaultHeader:@"A-Auth-Token" value:[[UserInfo instance] getTempToken]];

        designDic   = @{
                        @"A-Auth-Token":[[UserInfo instance] getTempToken],
                        @"style_id":styleId,
                        @"material_ids":material_ids,
                        @"clothes_count":clothes_count,
                        };
    }
    
    
    NSLog(@"上传 ＝ %@",designDic);
    
    
    NSMutableURLRequest *request = [client multipartFormRequestWithMethod:@"POST" path: @"customs/design/create_more" parameters:designDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        //NSData *data = UIImagePNGRepresentation(image);
        
        NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
        NSTimeInterval a=[dat timeIntervalSince1970];
        NSString *timeString = [NSString stringWithFormat:@"%d", (int)a];
        
        if (front_image!=nil) {
            [formData appendPartWithFileData:front_image name:@"front_image"
                                    fileName:[NSString stringWithFormat:@"front_image_%@.png",timeString] mimeType:@"image/jpeg/png"];
        }
        
        if (front_layer != nil) {
            
            
            [formData appendPartWithFileData:front_layer name:@"front_layer" fileName:[NSString stringWithFormat:@"front_layer_%@.png",timeString] mimeType:@"image/jpeg/png"];
        }
        
        if (back_img!=nil) {
            [formData appendPartWithFileData:back_img name:@"back_image" fileName:[NSString stringWithFormat:@"back_image%@.png",timeString] mimeType:@"image/jpeg/png"];
        }
        
        if (back_layer !=nil) {
            [formData appendPartWithFileData:back_layer name:@"back_layer" fileName:[NSString stringWithFormat:@"back_layer%@.png",timeString] mimeType:@"image/jpeg/png"];
        }
        
    }];
    
//    [request setValue:@"image/jpeg/png" forHTTPHeaderField:@"Content-Type"];
    
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
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
        NSLog(@"上传失败->%@", error);
        failure(error);
    }];
    
    [op setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
        NSLog(@"Sent %lld of %lld bytes", totalBytesWritten, totalBytesExpectedToWrite);
        
        CGFloat percentDone = ((float)(totalBytesWritten) / (float)(totalBytesExpectedToWrite));
        
        
        NSString* progressStr = [NSString stringWithFormat:@"%.2f",(percentDone)];
        NSString* totalStr = [NSString stringWithFormat:@"%f",(float)totalBytesExpectedToWrite];
        progress(progressStr,totalStr);
    }];
    
    //    [request setTimeoutInterval:10];
    
    request.timeoutInterval = 120;
    
    [UserInfo instance].op =op  ;
    

    
    //执行
    [client.operationQueue addOperation:op];

    

}


+(void)createCustomDesignStyleID:(NSString*)styleId TextureID:(NSString*)texId front_layer:(NSData*)front_layer
                     front_image:(NSData*)front_image back_image:(NSData*)back_img back_layer:(NSData *)back_layer Success:(DICTIONARY_BLOCK)success
                        Progress:(PROGRESS_BLOCK)progress onFailure:(ERROR_BLOCK)failure
{
   AFClient * client = [AFClient shareClient];
//    AFHTTPClient * client  = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:NEW_BASE_URL]];
    
    NSDictionary* designDic = nil;
    if ([[UserInfo instance] getToken]) {
        [client setDefaultHeader:@"A-Auth-Token" value:[[UserInfo instance] getToken]];
     designDic   = @{
            @"A-Auth-Token":[[UserInfo instance] getToken],
            @"style_id":styleId,
            @"texture_id":texId,
            };
    }else {
        [client setDefaultHeader:@"A-Auth-Token" value:[[UserInfo instance] getTempToken]];
        designDic   = @{
                        @"A-Auth-Token":[[UserInfo instance] getTempToken],
                        @"style_id":styleId,
                        @"texture_id":texId,
                    };
    }
    
    
    
    
//    NSDictionary* designDic = @{@"custom_design": @{
//                                        @"style_id":styleId,
//                                        @"texture_id":texId,
//                                        }
//                                };
    
    
    NSMutableURLRequest *request = [client multipartFormRequestWithMethod:@"POST" path: @"customs/design/create_more" parameters:designDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        //NSData *data = UIImagePNGRepresentation(image);
        
        NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
        NSTimeInterval a=[dat timeIntervalSince1970];
        NSString *timeString = [NSString stringWithFormat:@"%d", (int)a];
        
        if (front_image!=nil) {
            [formData appendPartWithFileData:front_image name:@"front_image"
                                    fileName:[NSString stringWithFormat:@"front_image_%@",timeString] mimeType:@"image/png"];
        }
        
        if (front_layer != nil) {
          
            
            [formData appendPartWithFileData:front_layer name:@"front_layer" fileName:[NSString stringWithFormat:@"front_layer_%@",timeString] mimeType:@"image/png"];
        }
        
        if (back_img!=nil) {
             [formData appendPartWithFileData:back_img name:@"back_image" fileName:[NSString stringWithFormat:@"back_image%@",timeString] mimeType:@"image/png"];
        }
        
        if (back_layer !=nil) {
            [formData appendPartWithFileData:back_layer name:@"back_layer" fileName:[NSString stringWithFormat:@"back_layer%@",timeString] mimeType:@"image/png"];
        }
        
    }];
    
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"哈哈哈上传完成");
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
        NSLog(@"上传失败->%@", error);
        failure(error);
    }];
    
    [op setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
        NSLog(@"Sent %lld of %lld bytes", totalBytesWritten, totalBytesExpectedToWrite);
    
        CGFloat percentDone = ((float)(totalBytesWritten) / (float)(totalBytesExpectedToWrite));
        
        
        NSString* progressStr = [NSString stringWithFormat:@"%.2f",(percentDone)];
        NSString* totalStr = [NSString stringWithFormat:@"%f",(float)totalBytesExpectedToWrite];
        progress(progressStr,totalStr);
    }];
    
    //    [request setTimeoutInterval:10];
    
    request.timeoutInterval = 60;
    
    //执行
    [client.operationQueue addOperation:op];
    
    // [client enqueueHTTPRequestOperation:op];
    //[op start];
    
}


+(void)cancelCustomDesignUpload
{
    [[UserInfo instance].op cancel];
    
    AFClient * client = [AFClient shareClient];
    if ([[UserInfo instance] getToken]) {
        [client setDefaultHeader:@"A-Auth-Token" value:[[UserInfo instance] getToken]];
    }else {
        [client setDefaultHeader:@"A-Auth-Token" value:[[UserInfo instance] getTempToken]];
    }
    
    [client cancelAllHTTPOperationsWithMethod:@"POST" path:CTEATE_CUSTOM ];
    
}

+(void)delCustomId:(NSDictionary *)favoritesId onSuccess:(STRING_BLOCK)success onFailure:(ERROR_BLOCK)failure {
    AFClient * client = [AFClient shareClient];
    if ([[UserInfo instance] getToken]) {
        [client setDefaultHeader:@"A-Auth-Token" value:[[UserInfo instance] getToken]];
    }else {
        [client setDefaultHeader:@"A-Auth-Token" value:[[UserInfo instance] getTempToken]];
    }
    [client deletePath:DELCUSTOMS parameters:favoritesId success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError * error = nil;
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
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

+(void)getTextures:(DICTIONARY_BLOCK)success onFailure:(ERROR_BLOCK)failure
{
    AFClient * client = [AFClient shareClient];
    if ([[UserInfo instance] getToken]) {
        [client setDefaultHeader:@"A-Auth-Token" value:[[UserInfo instance] getToken]];
    }else {
        [client setDefaultHeader:@"A-Auth-Token" value:[[UserInfo instance] getTempToken]];
    }
    
    [client getPath:TEXTURES parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
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


@end
