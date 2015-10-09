//
//  MyCustomTabBar.m
//  AiDingDing
//
//  Created by CDB on 15/9/28.
//  Copyright (c) 2015年 iDingDing. All rights reserved.
//
#define TabBarBasic_tag  9909
#import "MyCustomTabBar.h"
#import "CustomViewController.h"
#import "MyInfoViewController.h"
#import "WorksViewController.h"
#import "HomePageViewController.h"
#import "ConstDefine.h"
@interface MyCustomTabBar ()
@property(nonatomic,strong)UIView *tabBarView;
@end

@implementation MyCustomTabBar

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    //加载首页模块
    HomePageViewController *souYeVC = [[HomePageViewController alloc] init];
    UINavigationController *navSouYe = [[UINavigationController alloc] initWithRootViewController:souYeVC];
    navSouYe.tabBarItem.title = @"首页";
    navSouYe.navigationBarHidden = NO;
    //加载作品模块
    WorksViewController *worksVC = [[WorksViewController alloc] init];
    UINavigationController *navWorks = [[UINavigationController alloc] initWithRootViewController:worksVC];
    navWorks.tabBarItem.title = @"作品";
    
    navWorks.navigationBarHidden = NO;
    //加载定制模块
    CustomViewController *customVC = [[CustomViewController alloc] init];
    UINavigationController *navCustom = [[UINavigationController alloc] initWithRootViewController:customVC];
    navCustom.tabBarItem.title = @"定制";
    navCustom.navigationBarHidden = NO;
    //加载个人资料模块
    MyInfoViewController *mySelfInfVC = [[MyInfoViewController alloc] init];
    UINavigationController *navMySelfInf = [[UINavigationController alloc] initWithRootViewController:mySelfInfVC];
    navMySelfInf.tabBarItem.title = @"我的";
    
    navMySelfInf.navigationBarHidden = NO;
    
    //加入视图
    self.viewControllers = @[navSouYe,navWorks,navCustom,navMySelfInf];
    
    self.tabBar.frame = CGRectMake(0, self.view.frame.size.height-50,[[UIScreen mainScreen] bounds].size.width, 80);
    self.tabBar.backgroundColor = [UIColor whiteColor];
    //制作自己的tabBarView
    [self customTabbarView];
}

-(void)customTabbarView
{
    // 这里是添加toolBar的图片和点击图片
    NSArray *btnImgArray = @[[UIImage imageNamed:@"homeIcon1.png"],
                             [UIImage imageNamed:@"homeIcon2.png"],
                             
                             [UIImage imageNamed:@"worksIcon1.png"],
                             [UIImage imageNamed:@"worksIcon2.png"],
                             
                             [UIImage imageNamed:@"customIcon1.png"],
                             [UIImage imageNamed:@"customIcon2.png"],
                             
                             [UIImage imageNamed:@"personalIcon1.png"],
                             [UIImage imageNamed:@"personalIcon2.png"]
                             ];

    
    self.tabBarView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-47,[[UIScreen mainScreen] bounds].size.width, 80)];
    
    //加入视图
    [self.view addSubview:self.tabBarView];
    
    //添加Buttons 注意++i 和 i++ 否则后果自负哈哈
    for (int i = 0; i != 4; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(28 + 80 * i, 2, 23, 25);
        btn.showsTouchWhenHighlighted = YES;
        btn.tag = TabBarBasic_tag + i;
        [btn setBackgroundImage:[btnImgArray objectAtIndex:i * 2] forState:UIControlStateNormal];
        [btn setBackgroundImage:[btnImgArray objectAtIndex:i*2+1] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(tabBarControllerSwitch:) forControlEvents:UIControlEventTouchUpInside];
        [self.tabBarView addSubview:btn];
        i == 0?btn.selected = YES : 0;
    }
}

//通过下面的tabBar转换视图
- (void)tabBarControllerSwitch:(UIButton*)sender
{
    
    long index=sender.tag-TabBarBasic_tag;
    if(self.selectedIndex==index)
    {
        return;
    }
    
    NSLog(@"selectedIndex=%ld index=%ld",self.selectedIndex,index);
    UIButton *btn=(UIButton*)[self.view viewWithTag:self.selectedIndex+TabBarBasic_tag];
    btn.selected=NO;
    sender.selected=YES;
    self.selectedIndex=index;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
