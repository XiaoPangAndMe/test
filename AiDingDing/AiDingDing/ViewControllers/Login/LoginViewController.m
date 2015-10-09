//
//  LoginViewController.m
//  AiDingDing
//
//  Created by CDB on 15/10/2.
//  Copyright (c) 2015年 iDingDing. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "HomePageViewController.h"
#import "MyCustomTabBar.h"
#import "Utils.h"
#import "MBProgressHUD.h"
#import "UserAPI.h"
#import <CommonCrypto/CommonDigest.h>
#import "forgetPassWordViewController.h"
@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passWordTextFiled;
@property (strong, nonatomic) IBOutlet UIButton *loginButton;
@property (strong, nonatomic) IBOutlet UIButton *registerButton;
@property (strong, nonatomic) IBOutlet UIButton *forgetPassWordButton;
@property (strong, nonatomic) IBOutlet UIButton *qqButton;
@property (strong, nonatomic) IBOutlet UIButton *weiChatButton;
@property (strong, nonatomic) IBOutlet UIButton *sinaButton;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //增加按钮的回调事件
    //登陆按钮
    [self.loginButton addTarget:self action:@selector(loginBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    //注册按钮
    [self.registerButton addTarget:self action:@selector(registerBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    //qq登陆
    [self.qqButton addTarget:self action:@selector(qqBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    //微信登陆
    [self.weiChatButton addTarget:self action:@selector(weiChatBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    //新浪登陆
    [self.sinaButton addTarget:self action:@selector(sinaBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    //忘记密码
    [self.loginButton addTarget:self action:@selector(forgetBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
}

- (IBAction)loginBtnClicked:(id)sender {
    NSLog(@"loginBtnClicked");
    /*HomePageViewController *homePageVC = [[HomePageViewController alloc] init];
    homePageVC.modalTransitionStyle = 1;
    [self presentViewController:homePageVC animated:YES completion:nil];*/

    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:NO forKey:@"isThirdLog"];
    [userDefaults synchronize];
    
    [self.userNameTextField resignFirstResponder];
    [self.passWordTextFiled resignFirstResponder];
    if ([self.userNameTextField.text length]!= 11) {
        [Utils showMessage:@"手机号码不正确!" inView:self.view];
        return;
    }
    if (self.passWordTextFiled.text.length > 0) {
        NSString* md5Str = [self md5:self.passWordTextFiled.text];
        [self login:self.userNameTextField.text password:md5Str];
    }else {
        [Utils showMessage:@"请输入密码" inView:self.view];
    }

    
}

-(void)login:(NSString *)name password:(NSString *)password {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSLog(@"手机号码...%@",name);
    [UserAPI signInWithUserName:name PassWord:password
                      onSuccess:^{
                          [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                          [self loginSuccess];
                      }onFailure:^(NSError *error){
                          [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                          NSString *msg = error.userInfo[@"message"] == nil ? @"账号在其他地方登录，已退出请返回！" : error.userInfo[@"message"];
                          
                          [[UserInfo instance] removeToken];
                          [[UserInfo instance] removeTempToken];
                          [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                          [UserAPI createTempUserSuccess:^(NSString *str)
                           {
                               //                               [Utils showMessage:@"退出成功!" inView:self.view];
                               //                               [self.navigationController popViewControllerAnimated:YES];
                               NSLog(@"创建临时账号成功！7");
                               [self viewDidLoad];
                           } onFailure:^(NSError *error)
                           {
                               //                               NSString *msg = error.userInfo[@"message"] == nil ? @"登录失败，请重试" : error.userInfo[@"message"];
                               //                               [Utils showMessage:msg inView:self.view];
                               NSLog(@"创建临时账号失败！");
                               [self viewDidLoad];
                           }];
                          //                          [self viewDidLoad];
                          [Utils showMessage2:msg inView:self.view];
                          NSLog(@"登录失败，请重试  %@",error);
                      }];
}

-(void)loginSuccess {
    //登陆成功跳转到首页
    MyCustomTabBar *customVC = [[MyCustomTabBar alloc] init];
    customVC.modalTransitionStyle = 1;
    [self presentViewController:customVC animated:YES completion:nil];
}

- (NSString *)md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr,(CC_LONG) strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}


- (IBAction)registerBtnClicked:(id)sender {
    NSLog(@"registerBtnClicked");
    RegisterViewController *registerVC = [[RegisterViewController alloc] init];
    registerVC.modalTransitionStyle = 1;
    [self presentViewController:registerVC animated:YES completion:nil];
}

- (IBAction)qqBtnClicked:(id)sender {
    NSLog(@"qqBtnClicked");
}

- (IBAction)weiChatBtnClicked:(id)sender {
    NSLog(@"weiChatBtnClicked");
}

- (IBAction)sinaBtnClicked:(id)sender {
    NSLog(@"sinaBtnClicked");
}

- (IBAction)forgetBtnClicked:(id)sender {
    
    /*forgetPassWordViewController * fpwvc = [[forgetPassWordViewController alloc]initWithNibName:@"forgetPassWordViewController" bundle:nil];
        fpwvc.tag = 0;
        fpwvc.mode = FROM_REGISTER_VC;
        [self.navigationController pushViewController:fpwvc animated:YES];*/
    /*forgetPassWordViewController *forgetVC = [[forgetPassWordViewController alloc] init];
    forgetVC.modalTransitionStyle = 1;
    [self presentViewController:forgetVC animated:YES completion:nil];*/
    NSLog(@"forgetBtnClicked");
  
    forgetPassWordViewController *myPersonalInformationDetailVC = [[forgetPassWordViewController alloc] init];
    myPersonalInformationDetailVC.modalTransitionStyle = 2;
    //myPersonalInformationDetailVC.title = @"手机验证";
    [self.navigationController pushViewController:myPersonalInformationDetailVC animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}





@end
