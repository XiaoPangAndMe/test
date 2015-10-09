//
//  ShareUtils.m
//  AiDingDing
//
//  Created by libohao on 14/12/18.
//  Copyright (c) 2014年 bestapp. All rights reserved.
//

#import "ShareUtils.h"
#import "Utils.h"
#import "AppConfig.h"
#import "UIView+Blur.h"
#import <ShareSDK/ShareSDK.h>
#import <TencentOpenAPI/QQApi.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>





#define TAG_SHARE_VIEW 100

#define TAG_BUTTON_WECHATTIMELINE   101
#define TAG_BUTTON_WECHATFRIEND     102
#define TAG_BUTTON_SINAWEIBO        103
#define TAG_BUTTON_QQ               104
#define TAG_BUTTON_COPY             105
#define TAG_BUTTON_WEB              106


@implementation ShareUtils

+ (ShareUtils *)instance
{
    static ShareUtils *instance = nil;
    static dispatch_once_t once_t;
    dispatch_once(&once_t, ^{
        instance = [[ShareUtils alloc]init];
    });
    return instance;
}

-(void)shareByType:(ShareType)type Content:(NSString*)content Image:(NSString*)imgUrl WebUrl:(NSString*)url;
{
    
    [ShareSDK connectSinaWeiboWithAppKey:@"2371634251"
                               appSecret:@"9249d060e6eb8e259a16bbb0451a726c"
                             redirectUri:@"http://aidd.bestapp.us/callback"];
    
    [ShareSDK connectQZoneWithAppKey:@"1102404759"
                           appSecret:@"aed9b0303e3ed1e27bae87c33761161d"
                   qqApiInterfaceCls:[QQApiInterface class]
                     tencentOAuthCls:[TencentOAuth class]];
    
    [ShareSDK importQQClass:[QQApiInterface class]
            tencentOAuthCls:[TencentOAuth class]];
    
    /**
     连接QQ应用以使用相关功能，此应用需要引用QQConnection.framework和QQApi.framework库
     http://mobile.qq.com/api/上注册应用，并将相关信息填写到以下字段
     **/
    //旧版中申请的AppId（如：QQxxxxxx类型），可以通过下面方法进行初始化
    [ShareSDK connectQQWithAppId:@"QQ41b55c97" qqApiCls:[QQApi class]];
    
    
    SSPublishContentMediaType mediaType = SSPublishContentMediaTypeNews;
//    if (type == ShareTypeWeixiTimeline) {
//        mediaType = SSPublishContentMediaTypeApp;
//    }
    
    id<ISSContent> publishContent = [ShareSDK content:content
                                       defaultContent:content
                                                image:[ShareSDK imageWithUrl:imgUrl]
                                                title:content
                                                  url:url
                                          description:@""
                                            mediaType:mediaType];
    
    
    if (ShareTypeSinaWeibo == type) {
        
        //[ShareSDK clientShareContent:publishContent type:type statusBarTips:NO result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
        [ShareSDK shareContent:publishContent type:type authOptions:nil shareOptions:nil statusBarTips:YES result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end){
            if (state == SSResponseStateSuccess)
            {
                NSLog(@"分享成功");
                [Utils showMessage:@"分享成功" inView: [[UIApplication sharedApplication].delegate window]];
                //[bgView removeFromSuperview];
            }
            else if (state == SSResponseStateFail)
            {
                NSLog(@"分享失败,错误码:%ld,错误描述:%@", (long)[error errorCode], [error errorDescription]);
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:[error errorDescription] delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [alert show];
                
            }
        }];
        
        
    }else{
        [ShareSDK shareContent:publishContent type:type authOptions:nil shareOptions:nil statusBarTips:YES result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
            
            if (state == SSResponseStateSuccess)
            {
                NSLog(@"分享成功");
                
            }
            else if (state == SSResponseStateFail)
            {
                NSLog(@"分享失败,错误码:%ld,错误描述:%@", (long)[error errorCode], [error errorDescription]);
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"尚未登陆" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [alert show];
            }
            
        }];
        
        
    }
}

-(void)createShareView
{
    UIWindow* window = [[UIApplication sharedApplication].delegate window];
    //    UIImage* screenImg =  [[window screenShot] applyDarkEffect];
    
    [window blurScreen:YES];
    
    CGRect rect = [UIScreen mainScreen].bounds;
    UIView* shareView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, rect.size.width, rect.size.height)];
    //shareView.backgroundColor = [UIColor colorWithPatternImage:screenImg];
    shareView.backgroundColor = [UIColor clearColor];
    
    UIView* line1 = [[UIView alloc]initWithFrame:CGRectMake(0, rect.size.height - 344, rect.size.width, 0.5)];
    line1.backgroundColor = UIColorFromRGB(0xe1e1e1);
    [shareView addSubview:line1];
    
    UIView* line2 = [[UIView alloc]initWithFrame:CGRectMake(0, rect.size.height - 315, rect.size.width, 0.5)];
    line2.backgroundColor = UIColorFromRGB(0xe1e1e1);
    [shareView addSubview:line2];
    
    UILabel* title = [[UILabel alloc]initWithFrame:CGRectMake(0, rect.size.height - 344, rect.size.width, 30)];
    title.text = @"选择分享方式";
    title.textColor = UIColorFromRGB(0xe1e1e1);
    title.backgroundColor = [UIColor clearColor];
    title.textAlignment = NSTextAlignmentCenter;
    [shareView addSubview:title];
    
    
    UIButton* wechatTimeLineBtn = [[UIButton alloc]initWithFrame:CGRectMake(30, rect.size.height - 282, 61, 61)];
    [wechatTimeLineBtn setBackgroundImage:[UIImage imageNamed:@"分享朋友圈"] forState:UIControlStateNormal];
    [shareView addSubview:wechatTimeLineBtn];
    [wechatTimeLineBtn setTitle:@"微信朋友圈" forState:UIControlStateNormal];
    [wechatTimeLineBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, -90, 0)];
    wechatTimeLineBtn.titleLabel.font = [UIFont fontWithName:CHINESE_FONT_NAME size:10];
    [wechatTimeLineBtn addTarget:self action:@selector(shareBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    wechatTimeLineBtn.tag = TAG_BUTTON_WECHATTIMELINE;
    
    UIButton* wechatBtn = [[UIButton alloc]initWithFrame:CGRectMake(130, rect.size.height - 282, 61, 61)];
    [wechatBtn setBackgroundImage:[UIImage imageNamed:@"分享到微信"] forState:UIControlStateNormal];
    [wechatBtn setTitle:@"微信好友" forState:UIControlStateNormal];
    [wechatBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, -90, 0)];
    wechatBtn.titleLabel.font = [UIFont fontWithName:CHINESE_FONT_NAME size:10];
    [shareView addSubview:wechatBtn];
    [wechatBtn addTarget:self action:@selector(shareBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    wechatBtn.tag = TAG_BUTTON_WECHATFRIEND;
    
    UIButton* sinaBtn = [[UIButton alloc]initWithFrame:CGRectMake(230, rect.size.height - 282, 61, 61)];
    [sinaBtn setBackgroundImage:[UIImage imageNamed:@"分享到微博"] forState:UIControlStateNormal];
    [sinaBtn setTitle:@"新浪微博" forState:UIControlStateNormal];
    [sinaBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, -90, 0)];
    sinaBtn.titleLabel.font = [UIFont fontWithName:CHINESE_FONT_NAME size:10];
    [shareView addSubview:sinaBtn];
    [sinaBtn addTarget:self action:@selector(shareBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    sinaBtn.tag = TAG_BUTTON_SINAWEIBO;
    
    UIButton* qqBtn = [[UIButton alloc]initWithFrame:CGRectMake(30, rect.size.height - 172, 61, 61)];
    [qqBtn setBackgroundImage:[UIImage imageNamed:@"分享到qq"] forState:UIControlStateNormal];
    [qqBtn setTitle:@"QQ好友" forState:UIControlStateNormal];
    [qqBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, -90, 0)];
    qqBtn.titleLabel.font = [UIFont fontWithName:CHINESE_FONT_NAME size:10];
    [shareView addSubview:qqBtn];
    [qqBtn addTarget:self action:@selector(shareBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    qqBtn.tag = TAG_BUTTON_QQ;
    
    UIButton* copyLinkBtn = [[UIButton alloc]initWithFrame:CGRectMake(130, rect.size.height - 172, 61, 61)];
    [copyLinkBtn setBackgroundImage:[UIImage imageNamed:@"复制链接"] forState:UIControlStateNormal];
    [copyLinkBtn setTitle:@"复制链接" forState:UIControlStateNormal];
    [copyLinkBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, -90, 0)];
    copyLinkBtn.titleLabel.font = [UIFont fontWithName:CHINESE_FONT_NAME size:10];
    [shareView addSubview:copyLinkBtn];
    [copyLinkBtn addTarget:self action:@selector(shareBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    copyLinkBtn.tag = TAG_BUTTON_COPY;
    
    
    UIButton* openUrlBtn = [[UIButton alloc]initWithFrame:CGRectMake(230, rect.size.height - 172, 61, 61)];
    [openUrlBtn setBackgroundImage:[UIImage imageNamed:@"用浏览器打开"] forState:UIControlStateNormal];
    [openUrlBtn setTitle:@"在浏览器打开" forState:UIControlStateNormal];
    [openUrlBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, -90, 0)];
    openUrlBtn.titleLabel.font = [UIFont fontWithName:CHINESE_FONT_NAME size:10];
    [shareView addSubview:openUrlBtn];
    [openUrlBtn addTarget:self action:@selector(shareBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    openUrlBtn.tag = TAG_BUTTON_WEB;
    
    
    UIButton* okBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, rect.size.height - 56, rect.size.width, 56)];
    okBtn.backgroundColor  = UIColorFromRGB(0xfc2020);
    [okBtn setTitle:@"取消" forState:UIControlStateNormal];
    [okBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [okBtn addTarget:self action:@selector(cancelShareClicked) forControlEvents:UIControlEventTouchUpInside];
    okBtn.titleLabel.font = [UIFont fontWithName:CHINESE_FONT_NAME size:17];
    [shareView addSubview:okBtn];
    
    [window addSubview:shareView];
    shareView.tag = TAG_SHARE_VIEW;
    
    CGPoint center =  shareView.center;
    shareView.center = CGPointMake(center.x, rect.size.height);
    [UIView animateWithDuration:0.4 animations:^{
        shareView.center = center;
    }];
}

-(void)cancelShareClicked
{
    UIWindow* window = [[UIApplication sharedApplication].delegate window];
    UIView* shareView =  [window viewWithTag:TAG_SHARE_VIEW];
    CGPoint center =  shareView.center;
    CGRect rect = [UIScreen mainScreen].bounds;
    [UIView animateWithDuration:0.4 animations:^{
        shareView.center = CGPointMake(center.x, rect.size.height + 100);
    } completion:^(BOOL finished) {
        [window blurScreen:NO];
        [shareView removeFromSuperview];
        
    }];
    
}

-(void)shareBtnClicked:(id)sender
{
    [self cancelShareClicked];
    
    //ShareType type;
    UIButton* button = (UIButton*)sender;
    switch (button.tag) {
        case TAG_BUTTON_WECHATTIMELINE:
            if ([_delegate respondsToSelector:@selector(shareWeixiTimeline)]) {
                [_delegate shareWeixiTimeline];
            }
            break;
        case TAG_BUTTON_WECHATFRIEND:
            if ([_delegate respondsToSelector:@selector(shareWeixiSession)]) {
                [_delegate shareWeixiSession];
            }
            break;
        case TAG_BUTTON_SINAWEIBO:
            if ([_delegate respondsToSelector:@selector(shareWeibo)]) {
                [_delegate shareWeibo];
            }
            break;
        case TAG_BUTTON_QQ:
            if ([_delegate respondsToSelector:@selector(shareQQ)]) {
                [_delegate shareQQ];
            }
            break;
        case TAG_BUTTON_COPY:
            if ([_delegate respondsToSelector:@selector(shareCopy)]) {
                [_delegate shareCopy];
            }
            break;
        case TAG_BUTTON_WEB:
            if ([_delegate respondsToSelector:@selector(shareOpenUrl)]) {
                [_delegate shareOpenUrl];
            }
            break;
        default:
            break;
    }
 
    
//    if (button.tag == TAG_BUTTON_COPY) {
//        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
//        pasteboard.string = _designerInfo.wap_url;
//        UIWindow* window = [[UIApplication sharedApplication].delegate window];
//        [Utils showMessage:@"复制" inView:window];
//    }else if(button.tag == TAG_BUTTON_WEB){
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_designerInfo.wap_url]];
//    }else{
//        [[ShareUtils instance] shareByType:type Content:content Url:_designerInfo.wap_url];
//    }
    
}



@end
