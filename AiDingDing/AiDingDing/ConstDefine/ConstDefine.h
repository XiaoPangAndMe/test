//
//  ConstDefine.h
//  AiDingDing
//
//  Created by CDB on 15/10/2.
//  Copyright (c) 2015年 iDingDing. All rights reserved.
//

#ifndef AiDingDing_ConstDefine_h
#define AiDingDing_ConstDefine_h

#define iOSVersion [[[UIDevice currentDevice] systemVersion] floatValue]

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define NAV_BAR_COLOR            UIColorFromRGB(0xf1f1f1)

#define CHINESE_FONT_NAME        @"Helvetica-Light"

#define WIN_SIZE [[UIScreen mainScreen] bounds].size

//我的 跳转标记
#define MINE_DING_DAN 0
#define MINE_DING_ZHI 1
#define MINE_SHOU_CHANG 2
#define MINE_SHOPPING_CAR 3
#define MINE_ADRRESS 4
#define MINE_INFOMATION 5
#define MINE_MESSAGE 6
#define MINE_WHO_SEE_ME 7
#define MINE_CARE_FANS 8

//个人信息  编辑修改跳转
#define SELF_HEADER_EDIT 0
#define SELF_USER_NAME 0
#define SELF_SEX 1
#define SELF_BIRTHDAY 2
#define SELF_ADRESS 0
#define SELF_MAILBOX 0
#define SELF_TELEPHONE 1
#define SELF_QQ 2
#define SELF_WE_CHAT 3
#define SELF_SIGN 0
#define SELF_LEVEL 0

#define CUSTOM_GRAY_COLOR [ UIColor colorWithWhite: 0.7 alpha: 0.10 ]

#define objc_msg(A,B,C) void (*objc_msgSendTyped)(id self, SEL _cmd, id _ddservice) = (void*)objc_msgSend;objc_msgSendTyped((A), (B), (C));

#define BT_COLOR_ORIGIN UIColorFromRGB(0xFF7A33) // 橙色 字体 按钮
#endif
