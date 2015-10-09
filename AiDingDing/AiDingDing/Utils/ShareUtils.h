//
//  ShareUtils.h
//  AiDingDing
//
//  Created by libohao on 14/12/18.
//  Copyright (c) 2014年 bestapp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ShareSDK/ShareSDK.h>

@protocol ShareUtilDelegate <NSObject>

-(void)shareWeixiTimeline;
-(void)shareWeixiSession;
-(void)shareWeibo;
-(void)shareQQ;
-(void)shareCopy;
-(void)shareOpenUrl;
@end


@interface ShareUtils : NSObject

+ (ShareUtils *)instance;

-(void)shareByType:(ShareType)type Content:(NSString*)content Image:(NSString*)imgUrl WebUrl:(NSString*)url;

-(void)createShareView;


@property (assign,nonatomic) id<ShareUtilDelegate> delegate;

@end
