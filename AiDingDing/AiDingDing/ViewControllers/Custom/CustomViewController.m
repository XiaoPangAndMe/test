//
//  CustomViewController.m
//  AiDingDing
//
//  Created by CDB on 15/9/28.
//  Copyright (c) 2015年 iDingDing. All rights reserved.
//

#import "CustomViewController.h"

@interface CustomViewController ()

@end

@implementation CustomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor redColor]];
//    //右边的  导航按钮
//    UIBarButtonItem *right_button=[[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleBordered target:self action:@selector(rightto:)];
//    self.navigationItem.rightBarButtonItem=right_button;
//    //左边的 导航按钮
//    UIBarButtonItem *leftbtn=[[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStyleBordered target:self action:@selector(Leftto:)];
//    self.navigationItem.leftBarButtonItem=leftbtn;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
