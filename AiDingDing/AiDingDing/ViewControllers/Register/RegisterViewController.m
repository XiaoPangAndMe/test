//
//  RegisterViewController.m
//  AiDingDing
//
//  Created by CDB on 15/10/2.
//  Copyright (c) 2015年 iDingDing. All rights reserved.
//

#import "RegisterViewController.h"
#import "Utils.h"
#import "MBProgressHUD.h"
#import "UserAPI.h"
#import "WriteDataViewController.h"
#include "ConstDefine.h"
@interface RegisterViewController ()

@property (weak, nonatomic) IBOutlet UITextField *userNameTextFieldR;
@property (weak, nonatomic) IBOutlet UITextField *passWordTextFiledR;
@property (weak, nonatomic) IBOutlet UITextField *checkTextFiledR;
@property (strong, nonatomic) IBOutlet UIButton *loginButtonR;
@property (strong, nonatomic) IBOutlet UIButton *registerButtonR;
@property (strong, nonatomic) IBOutlet UIButton *getCheckMessageButtonR;
@property (strong, nonatomic) IBOutlet UIButton *qqButtonR;
@property (strong, nonatomic) IBOutlet UIButton *weiChatButtonR;
@property (strong, nonatomic) IBOutlet UIButton *sinaButtonR;

@property BOOL canGetCode;//是否获得验证码
@property int countDownSec;//验证码计时器
@property NSTimer *timer; //计时器
@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //增加按钮的回调事件
    //登陆按钮
    [self.loginButtonR addTarget:self action:@selector(loginBtnClickedR:) forControlEvents:UIControlEventTouchUpInside];
    //注册按钮
    [self.registerButtonR addTarget:self action:@selector(registerBtnClickedR:) forControlEvents:UIControlEventTouchUpInside];
    //qq登陆
    [self.qqButtonR addTarget:self action:@selector(qqBtnClickedR:) forControlEvents:UIControlEventTouchUpInside];
    //微信登陆
    [self.weiChatButtonR addTarget:self action:@selector(weiChatBtnClickedR:) forControlEvents:UIControlEventTouchUpInside];
    //新浪登陆
    [self.sinaButtonR addTarget:self action:@selector(sinaBtnClickedR:) forControlEvents:UIControlEventTouchUpInside];
    //发送验证码
    [self.getCheckMessageButtonR addTarget:self action:@selector(getCheckMessageBtnClickedR:) forControlEvents:UIControlEventTouchUpInside];
    
    
    _canGetCode = YES; //是否获得验证码
    _countDownSec = 60; //验证码计时器

}

- (IBAction)loginBtnClickedR:(id)sender {
    NSLog(@"loginBtnClickedR");
}

- (IBAction)registerBtnClickedR:(id)sender {
    NSLog(@"registerBtnClickedR");
    //退出响应
    [self.userNameTextFieldR resignFirstResponder];;
    [self.passWordTextFiledR resignFirstResponder];;
    //验证输入的格式
    if (self.userNameTextFieldR.text.length != 11) {
        [Utils showMessage:@"手机号码不正确!" inView:self.view];
        return;
    }
    
    if (self.userNameTextFieldR.text.length == 11 && self.passWordTextFiledR.text.length > 0) {
        //提交用户注册信息
        [self login:self.userNameTextFieldR.text code:self.passWordTextFiledR.text];
    }
//    RegisterViewController *registerVC = [[RegisterViewController alloc] init];
//    registerVC.modalTransitionStyle = 1;
//    [self presentViewController:registerVC animated:YES completion:nil];
}

//注册响应
- (void)login:(NSString *)number code:(NSString *)code {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [UserAPI sign_upWithPhone:number ValidCode:code
                    onSuccess: ^{
                        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                        [self getTempToken];
                        
                        WriteDataViewController * wdvc = [[WriteDataViewController alloc]initWithNibName:@"WriteDataViewController" bundle:nil];
                        [self.navigationController pushViewController:wdvc animated:YES];
                        
                    } onFailure: ^(NSError *error){
                        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                        NSString *msg;
                        if ([[error.userInfo allKeys]containsObject:@"result"]) {
                            msg = error.userInfo[@"result"];
                        }else{
                            msg = error.userInfo[@"message"] == nil ? @"注册失败，请重试" : error.userInfo[@"message"];
                        }
                        
                        [Utils showMessage:msg inView:self.view];
                    }];
}

-(void)getTempToken {
    [UserAPI createTempUserSuccess:^(NSString *str) {
        
    } onFailure:^(NSError *error) {
        NSString *msg = error.userInfo[@"message"] == nil ? @"账号在其他地方登录，已退出请返回！" : error.userInfo[@"message"];
        
        [[UserInfo instance] removeToken];
        [[UserInfo instance] removeTempToken];
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [UserAPI createTempUserSuccess:^(NSString *str)
         {
             NSLog(@"创建临时账号成功！8");
             [self viewDidLoad];
         } onFailure:^(NSError *error)
         {
             NSLog(@"创建临时账号失败！");
         }];
        [Utils showMessage2:msg inView:self.view];
        NSLog(@"登录失败，请重试  %@",error);
    }];
}

- (IBAction)qqBtnClickedR:(id)sender {
    NSLog(@"qqBtnClickedR");
}

- (IBAction)weiChatBtnClickedR:(id)sender {
    NSLog(@"weiChatBtnClickedR");
}

- (IBAction)sinaBtnClickedR:(id)sender {
    NSLog(@"sinaBtnClickedR");
}

//获取并验证填写的手机号码
- (IBAction)getCheckMessageBtnClickedR:(id)sender {
    NSLog(@"发送验证码");
    if (!_canGetCode) {
        return;
    }
    [self.checkTextFiledR resignFirstResponder];
    if (self.userNameTextFieldR.text.length != 11) {
        [Utils showMessage:@"手机号码不正确" inView:self.view];
        return;
    }
    _canGetCode = NO;
    if (self.userNameTextFieldR.text.length > 0) {
        [self getCode:self.userNameTextFieldR.text];
    }
    
}

//获取验证码aa
- (void)getCode:(NSString *)number {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [UserAPI getVaildCodePhone:number onSuccess:^(NSString *str) {
        [self.userNameTextFieldR becomeFirstResponder];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [self countDown];
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1
                                                      target:self
                                                    selector:@selector(countDown)
                                                    userInfo:nil
                                                     repeats:YES];
    } onFailure:^(NSError *error) {
        [self resetCountTime];
        [Utils showMessage:@"获取验证码失败，请重试" inView:self.view];
    }];
}

//计数器方法
- (void)countDown {
    if (self.countDownSec == 0) {
        [self resetCountTime];//重置计数器
        return;
    }
    NSString* title = [NSString stringWithFormat:@"重新获取(%d秒)", self.countDownSec];
    [self.getCheckMessageButtonR setTitle:title forState:UIControlStateNormal];
    self.getCheckMessageButtonR.tintColor = [UIColor grayColor];//变成灰色
    
    self.countDownSec --;
}

//重置计数器
- (void)resetCountTime {
    self.countDownSec = 60;
    self.canGetCode = YES;
    [self.timer invalidate];
    [self.getCheckMessageButtonR setTitle: @"获取验证码" forState:UIControlStateNormal];
    self.getCheckMessageButtonR.tintColor = BT_COLOR_ORIGIN;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}



@end
