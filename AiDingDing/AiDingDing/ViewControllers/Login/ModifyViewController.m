//
//  ModifyViewController.m
//  AiDingDing
//
//  Created by lzy on 14-9-5.
//  Copyright (c) 2014年 bestapp. All rights reserved.
//

#import "ModifyViewController.h"
#import "MBProgressHUD.h"
#import "UserAPI.h"
#import "Utils.h"
#import "CommonCrypto/CommonDigest.h"



@interface ModifyViewController ()
@property (weak, nonatomic) IBOutlet UILabel *modifyLabel;
@property (weak, nonatomic) IBOutlet UIView *passWordView;
@property (weak, nonatomic) IBOutlet UITextField *verificationTextField;
@property (weak, nonatomic) IBOutlet UIView *verificationView;
@property (weak, nonatomic) IBOutlet UITextField *passWordTextField;

@end

@implementation ModifyViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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

- (void)modifyAcation:(id)sender {
    [_passWordTextField resignFirstResponder];
    [_verificationTextField resignFirstResponder];
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
-(void)nextAction {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [UserAPI passwordResetNewPassword:[self md5:_passWordTextField.text] NewPasswordConfirmation:[self md5:_verificationTextField.text]
                            onSuccess:^(NSString * str) {
                                [Utils showMessage:@"修改成功" inView:self.view];
                                [self.navigationController popToRootViewControllerAnimated:YES];
                            } onFailure:^(NSError * error) {
                                NSString *msg = error.userInfo[@"errors"] == nil ? @"账号在其他地方登录，已退出请返回！" : error.userInfo[@"errors"];
                                
                                [[UserInfo instance] removeToken];
                                [[UserInfo instance] removeTempToken];
                                [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                                [UserAPI createTempUserSuccess:^(NSString *str)
                                 {
//                                     [Utils showMessage:@"退出成功!" inView:self.view];
//                                     [self.navigationController popViewControllerAnimated:YES];
                                     NSLog(@"创建临时账号成功！5");
                                     [self viewDidLoad];
                                 } onFailure:^(NSError *error)
                                 {
//                                     NSString *msg = error.userInfo[@"message"] == nil ? @"登录失败，请重试" : error.userInfo[@"message"];
//                                     [Utils showMessage:msg inView:self.view];
                                     NSLog(@"创建临时账号失败！");
                                 }];
//                                [self viewDidLoad];
                                [Utils showMessage2:msg inView:self.view];
                                NSLog(@"登录失败，请重试  %@",error);
                            }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UITapGestureRecognizer * modifyGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(modifyAcation:)];
    [_modifyLabel addGestureRecognizer:modifyGesture];
    _passWordTextField.delegate = self;
    _verificationTextField.delegate = self;
    
    [self setTitle:@"修改密码"];
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
