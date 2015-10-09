//
//  AppConfig.h
//  allinns_business
//
//  Created by libohao on 14-7-25.
//  Copyright (c) 2014年 bestapp. All rights reserved.
//

#ifndef allinns_business_AppConfig_h
#define allinns_business_AppConfig_h

#define isRetina ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO) 

#define IS_RETINA ([[UIScreen mainScreen] respondsToSelector:@selector(displayLinkWithTarget:selector:)] && ([UIScreen mainScreen].scale == 2.0))


//是否i5+
#define iPhone5Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define font12 [UIFont systemFontOfSize:9.0f]

#define font15 [UIFont systemFontOfSize:15.0f]

#define IOS7_OR_LATER ([[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending)
#define iOSVersion [[[UIDevice currentDevice] systemVersion] floatValue]

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


#define ALLINNS_NOTIFICATION_UPDATE_ROOM_STATE @"UPDATE_ROOM_STATE"
#define ALLINNS_NOTIFICATION_UPDATE_ORDER_DETAIL @"UPDATE_ROOM_STATE"

#define BTLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#define BT_COLOR_ORIGIN UIColorFromRGB(0xFF7A33) // 橙色 字体 按钮

#define NUMBER_FONT_NAME         @"Helvetica-Light"
#define CHINESE_FONT_NAME        @"Helvetica-Light"

#define NAV_BAR_COLOR            UIColorFromRGB(0xf1f1f1)
#define ORDER_COUNT_LABEL_COLOR  UIColorFromRGB(0x29b067)
#define BADGE_VIEW_COLOR         UIColorFromRGB(0xff3626)
#define TABLE_VIEW_BACKGOURND_COLOR UIColorFromRGB(0Xf5f5f5)
#define TABLEVIEW_SEPERATOR_COLOR   UIColorFromRGB(0xe8e8e8)

#define GREEN_COLOR       UIColorFromRGB(0x29b067)
#define YELLOW_COLOR             UIColorFromRGB(0XFD6D1E)

#define NAV_BAR_HEIGHT           64

#define SCREEN_WIDTH       [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT      [UIScreen mainScreen].bounds.size.height

typedef enum : NSUInteger {
    NORMAL,
    REBUY,
} MODE ;


//#define appDelegate            (AppDelegate*)[UIApplication sharedApplication].delegate
//#define appWindow              [[UIApplication sharedApplication].delegate window]



#endif
