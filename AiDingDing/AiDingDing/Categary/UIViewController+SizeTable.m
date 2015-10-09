//
//  UIViewController+SizeTable.m
//  AiDingDing
//
//  Created by libohao on 14/11/21.
//  Copyright (c) 2014年 bestapp. All rights reserved.
//

#import "UIViewController+SizeTable.h"
#import "AppConfig.h"

@implementation UIViewController (SizeTable)

-(UIView *)commonInitSizeTableView:(NSDictionary*)dics
{
  
  
    
    NSDictionary* measureMentDic = dics[@"measurement"];
    NSArray* sizes = measureMentDic[@"sizes"];
    NSDictionary* measure = measureMentDic[@"measure"];
    
    int sizeViewHeight = 126 +(int) sizes.count*32;
    
   // CGRect rect = [UIScreen mainScreen].bounds;
    
    CGFloat y = [UIScreen mainScreen].bounds.size.height *3/4.0 - sizeViewHeight;
    
//    UIView* view = [[UIView alloc]initWithFrame:CGRectMake(0, rect.size.height - sizeViewHeight, 320, sizeViewHeight)];
    UIView* view = [[UIView alloc]initWithFrame:CGRectMake(0, y, 320, sizeViewHeight)];

    view.backgroundColor = UIColorFromRGB(0x242025);
    
    
    UILabel* title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    title.text = (measureMentDic[@"title"] ==nil)?@"尺码表":(measureMentDic[@"title"]);
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = UIColorFromRGB(0xd8d8d8);
    [view addSubview:title];
    
    UIView* line1 = [[UIView alloc]initWithFrame:CGRectMake(24, 44, 272, 0.5)];
    line1.backgroundColor = UIColorFromRGB(0x3f3d40);
    [view addSubview:line1];
    
    UIView* line2 = [[UIView alloc]initWithFrame:CGRectMake(24, 76, 272, 0.5)];
    line2.backgroundColor = UIColorFromRGB(0x3f3d40);
    [view addSubview:line2];
    
    NSArray* titleArray = [NSArray arrayWithObjects:@"尺码",@"肩宽",@"胸围",@"衣长",@"袖长", nil];
    
    for (int i=0; i<5; ++i) {
        UILabel* label = [[UILabel alloc]initWithFrame:CGRectMake(24 + 55*i, 44, 55, 32)];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = UIColorFromRGB(0xd8d8d8);
        label.font = [UIFont systemFontOfSize:14];
        label.text = titleArray[i];
        [view addSubview:label];
    }
    
    for (int i=0; i<sizes.count; ++i) {
    
        UILabel* label = [[UILabel alloc]initWithFrame:CGRectMake(24, 76 + 32*i, 55, 32)];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = UIColorFromRGB(0xd8d8d8);
        label.font = [UIFont fontWithName:CHINESE_FONT_NAME size:14];
        label.text = sizes[i];
        [view addSubview:label];
        
        for (int j = 0; j<4; ++j) {
            
            NSDictionary* info = measure[sizes[i]];
            NSDictionary* key = [[info allKeys] objectAtIndex:j];
            NSString* value = info[key];
        
            
            UILabel* label = [[UILabel alloc]initWithFrame:CGRectMake(79 + 55*j, 76 + 32*i, 55, 32)];
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor = UIColorFromRGB(0xd8d8d8);
            label.font = [UIFont fontWithName:CHINESE_FONT_NAME size:14];
            label.text = value;
            [view addSubview:label];
        }
        

        
    }
    
    UIView* line3 = [[UIView alloc]initWithFrame:CGRectMake(24, sizeViewHeight - 50, 272, 0.5)];
    line3.backgroundColor = UIColorFromRGB(0x3f3d40);
    [view addSubview:line3];
    
    UIButton* closthBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, sizeViewHeight - 50, 320, 50)];
    [closthBtn setTitle:@"关闭" forState:UIControlStateNormal];
    [closthBtn setTitleColor:UIColorFromRGB(0xd9c7b2) forState:UIControlStateNormal];
    [view addSubview:closthBtn];
    [closthBtn addTarget:self action:@selector(hideSizeTableView) forControlEvents:UIControlEventTouchUpInside];
    view.tag = 50000;
    //UIWindow* window = [[UIApplication sharedApplication].delegate window];
    return view;
}

-(void)showSizeTableView
{
    UIView* view =  [self.view viewWithTag:50000];
    view.superview.hidden = NO;
    view.superview.superview.hidden = NO;
    
}

-(void)hideSizeTableView
{
    UIView* view =  [self.view viewWithTag:50000];
    [view.superview.superview removeFromSuperview];
    
}

@end
