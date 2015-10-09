//
//  DynamicScrollView.h
//  AiDingDing
//
//  Created by CDB on 15/10/2.
//  Copyright (c) 2015年 iDingDing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DynamicScrollView : UIView

@property(nonatomic,strong)NSMutableArray *imageArray;//存放图片
@property(nonatomic,strong)NSTimer *myTimer;//定时器

@property(nonatomic,strong)UIScrollView *dynamicScrollView;
//视图中小圆点，对应视图的页码
@property (retain, nonatomic) UIPageControl *pageControl;

-(void)pageTurn:(UIPageControl *)sender;

@end
