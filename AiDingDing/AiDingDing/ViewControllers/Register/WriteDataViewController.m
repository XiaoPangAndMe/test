//
//  WriteDateViewController.m
//  AiDingDing
//
//  Created by lzy on 14-9-5.
//  Copyright (c) 2014年 bestapp. All rights reserved.
//

#import "WriteDataViewController.h"
#import "MBProgressHUD.h"
#import "UserAPI.h"
#import "Utils.h"
#import "CommonCrypto/CommonDigest.h"

@interface WriteDataViewController ()
@property (weak, nonatomic) IBOutlet UIButton *commitButton;
@property (weak, nonatomic) IBOutlet UIView *passWordView;
@property (weak, nonatomic) IBOutlet UITextField *verificationTextField;
@property (weak, nonatomic) IBOutlet UIView *verificationView;
@property (weak, nonatomic) IBOutlet UITextField *passWordTextField;
@property (weak, nonatomic) IBOutlet UIView *nickNameView;
@property (weak, nonatomic) IBOutlet UITextField *nackNameTextField;
@end

@implementation WriteDataViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (IBAction)commitAcation:(id)sender {
    [_passWordTextField resignFirstResponder];
    [_verificationTextField resignFirstResponder];
    [_nackNameTextField resignFirstResponder];
    if (![_passWordTextField.text isEqualToString:_verificationTextField.text]) {
        [Utils showMessage:@"密码不一致!" inView:self.view];
        return;
    }else if (_passWordTextField.text.length < 6 || _verificationTextField.text.length < 6){
        [Utils showMessage:@"密码最少6位" inView:self.view];
        return;
    }else {
        [self nextAction];
    }
}

- (NSString *)md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

-(void)nextAction {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [UserAPI setUserNewPassword:[self md5:_passWordTextField.text] NewPasswordConfirmation:[self md5:_verificationTextField.text] nickname:_nackNameTextField.text
                      onSuccess:^(NSString * str)
    {
                            [Utils showMessage:str inView:self.view];
                          [self.navigationController popToRootViewControllerAnimated:YES];
                      } onFailure:^(NSError * error) {
                            NSString *msg = error.userInfo[@"errors"] == nil ? @"账号在其他地方登录，已退出请返回！" : error.userInfo[@"errors"];
                          
                          [[UserInfo instance] removeToken];
                          [[UserInfo instance] removeTempToken];
                          [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                          [UserAPI createTempUserSuccess:^(NSString *str)
                           {
//                               [Utils showMessage:@"退出成功!" inView:self.view];
//                               [self.navigationController popViewControllerAnimated:YES];
                               NSLog(@"临时账号创建成功！14");
                               [self viewDidLoad];
                           } onFailure:^(NSError *error)
                           {
                               NSLog(@"创建临时账号失败！");
        
                           }];
                          [Utils showMessage2:msg inView:self.view];
                          NSLog(@"登录失败，请重试  %@",error);
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;
    _passWordTextField.delegate = self;
    _verificationTextField.delegate = self;
    _nackNameTextField.delegate = self;
    
    [self setTitle:@"完善资料"];
    [self setLeftBarImage:[UIImage imageNamed:@"返回_icon"] target:self action:@selector(presentLeftMenuViewController)];
}
- (void)presentLeftMenuViewController {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField.text.length < 15 || [string isEqualToString:@""]) {
        return YES;
    }
    return NO;
}
-(void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField.tag == 101) {
        if (_verificationTextField.text.length > 0) {
            if (![_passWordTextField.text isEqualToString:_verificationTextField.text]) {
                [Utils showMessage:@"密码输入不一至，请重新输入！" inView:self.view];
                return;
            }
        }
        if (_passWordTextField.text.length < 6) {
            [Utils showMessage:@"密码最少6位!" inView:self.view];
            return;
        }
    }else if (textField.tag == 102) {
        if (![_passWordTextField.text isEqualToString:_verificationTextField.text]) {
            [Utils showMessage:@"密码输入不一至，请重新输入！" inView:self.view];
            return;
        }
        if ( _verificationTextField.text.length < 6) {
            [Utils showMessage:@"密码最少6位!" inView:self.view];
            return;
        }
    }
}

@end
