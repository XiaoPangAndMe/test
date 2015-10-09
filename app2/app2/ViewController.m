//
//  ViewController.m
//  app2
//
//  Created by Jack on 15/6/24.
//  Copyright (c) 2015年 Jack. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)openClick:(id)sender {
    NSURL *appOne = [NSURL URLWithString:@"z1://test=Jack"];
    [[UIApplication sharedApplication] openURL:appOne];
}
@end
