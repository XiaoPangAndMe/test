//
//  forgetPassWordViewController.m
//  AiDingDing
//
//  Created by lzy on 14-9-4.
//  Copyright (c) 2014年 bestapp. All rights reserved.
//

#import "forgetPassWordViewController.h"
#import "ModifyViewController.h"
#import "MBProgressHUD.h"
#import "UserAPI.h"
#import "AppConfig.h"
#import "Utils.h"
#import "LoginViewController.h"
//#import "AddressListViewController.h"
#import "AppDelegate.h"

@interface forgetPassWordViewController ()
@property (weak, nonatomic) IBOutlet UIView *phoneNubView;
@property (weak, nonatomic) IBOutlet UIView *verificationView;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *verificationTextField;
@property (weak, nonatomic) IBOutlet UIButton *getCodeButton;
@property (weak, nonatomic) IBOutlet UILabel *getCodeTipLabel;
@property (weak, nonatomic) IBOutlet UILabel *nextLabel;
@property (weak, nonatomic) IBOutlet UILabel *chengeMobile;
@property (weak, nonatomic) IBOutlet UILabel *tipMobile;
@property (strong,nonatomic) NSMutableString * str;
/***********/
@property(nonatomic,copy)NSString *phone;
/***********/
@property int countDownSec;
@property BOOL canGetCode;
@property NSTimer *timer;
@end

@implementation forgetPassWordViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = NO;
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

//修改
-(void)AccessLogin {
    LoginViewController * rvc = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
    rvc.loginTag = 11;
    [self.navigationController pushViewController:rvc animated:YES];
}

-(void)leftAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setLeftBarImage:[UIImage imageNamed:@"back"] target:self action:@selector(leftAction)];
    _phoneTextField.delegate = self;
    _verificationTextField.delegate = self;
    self.canGetCode = YES;
    self.countDownSec = 60;
    
    if (_tag == 0) {
        [self setTitle:@"手机验证"];
        UITapGestureRecognizer * nextGesture =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(nextActionn:)];
        [_nextLabel addGestureRecognizer:nextGesture];
        _chengeMobile.hidden = NO;
    }else if(_tag == 1) {
        [self setTitle:@"手机验证"];
        UITapGestureRecognizer * nextGesture =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(nextActions)];
        [_nextLabel addGestureRecognizer:nextGesture];
        _tipMobile.hidden = NO;
        _nextLabel.text = @"确定";
        [self setRightBarTitle:@"账号登录" target:self action:@selector(AccessLogin)];
    }else if(_tag == 2) {
        [self setTitle:@"手机验证"];
        self.phone = ((AppDelegate *)[UIApplication sharedApplication].delegate).userPhone;
        if (![_phone isMemberOfClass:[NSNull class]]&&_phone!=nil) {
             self.phoneTextField.text = [NSString stringWithFormat:@"%@****%@",[_phone substringWithRange:NSMakeRange(0, 3)] ,[_phone substringWithRange:NSMakeRange(7, 4)]];
        }else{
            self.phoneTextField.placeholder = @"手机号码";
            self.phoneTextField.text = @"";
        }
        
        
            
        
        
        UITapGestureRecognizer * nextGesture =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(nextActions)];
        [_nextLabel addGestureRecognizer:nextGesture];
//        _tipMobile.hidden = NO;
//        _nextLabel.text = @"确定";
//        [self setRightBarTitle:@"账号登录" target:self action:@selector(AccessLogin)];
    }

}

- (void)login:(NSString *)number code:(NSString *)code {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [UserAPI modityWithPhone:_phoneTextField.text ValidCode:_verificationTextField.text onSuccess:^{
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        ModifyViewController * mvc = [[ModifyViewController alloc]initWithNibName:@"ModifyViewController" bundle:nil];
        [self.navigationController pushViewController:mvc animated:YES];
        
    } onFailure: ^(NSError *error){
        NSString *msg = error.userInfo[@"message"] == nil ? @"手机验证失败，请重试" : error.userInfo[@"message"];
        [Utils showMessage:msg inView:self.view];
    }];
}

- (void)nextActionn:(id)sender {
    if (_tag == 0) {
        [_phoneTextField resignFirstResponder];
        [_verificationTextField resignFirstResponder];
        if (_phoneTextField.text.length != 11) {
            [Utils showMessage:@"手机号码不正确" inView:self.view];
            return;
        }
        if (_phoneTextField.text.length == 11 && _verificationTextField.text.length > 0) {
            [self login:_phoneTextField.text code:_verificationTextField.text];
        }
    }else if(_tag == 1) {
//        AddressListViewController * alvc = [[AddressListViewController alloc]initWithNibName:@"AddressListViewController" bundle:nil];
//        [self.navigationController pushViewController:alvc animated:YES];
    }
}

- (void)nextActions {
    [_phoneTextField resignFirstResponder];
    [_verificationTextField resignFirstResponder];
    if ([_phoneTextField.text length]!= 11) {
        [Utils showMessage:@"手机号码不正确!" inView:self.view];
        return;
    }
    if (_verificationTextField.text.length > 0) {
       
    }else {
        [Utils showMessage:@"请输入验证码！" inView:self.view];
        return;
    }
    if (FROM_ADD_EDIT_ADDRESS_VC == _mode) {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [UserAPI forgetPasswordWithPhoneSync:_phoneTextField.text ValidCode:_verificationTextField.text onSuccess:^(NSDictionary *dics) {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
//            AddressListViewController * alvc = [[AddressListViewController alloc]initWithNibName:@"AddressListViewController" bundle:nil];
//            alvc.tag = 2;
//            alvc.dict = dics;
//            //[self.navigationController pushViewController:alvc animated:YES];
//            NSArray* vcs = self.navigationController.viewControllers;
//            [self.navigationController setViewControllers:@[vcs[0],alvc] animated:YES];
        } onFailure:^(NSError *error) {
            NSString *msg = error.userInfo[@"errors"] == nil ? @"账号在其他地方登录，已退出请返回！" : error.userInfo[@"errors"];
            
            [[UserInfo instance] removeToken];
            [[UserInfo instance] removeTempToken];
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            [UserAPI createTempUserSuccess:^(NSString *str)
             {
                 NSLog(@"创建临时账号成功！3");
                 [self viewDidLoad];
             } onFailure:^(NSError *error)
             {

                 NSLog(@"创建临时账号失败！");
             }];
//            [self viewDidLoad];
            [Utils showMessage2:msg inView:self.view];
            NSLog(@"登录失败，请重试  %@",error);
        }];
    }else {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [UserAPI forgetPasswordWithPhone:_phoneTextField.text ValidCode:_verificationTextField.text
                               onSuccess:^(){
                                   [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                                   if (FROM_REGISTER_VC == _mode || FROM_ACCOUNTSET_VC == _mode) {
                                       ModifyViewController * mvc = [[ModifyViewController alloc]initWithNibName:@"ModifyViewController" bundle:nil];
                                       [self.navigationController pushViewController:mvc animated:YES];
                                   }else if (FROM_ADD_EDIT_ADDRESS_VC == _mode) {
//                                       AddressListViewController * alvc = [[AddressListViewController alloc]initWithNibName:@"AddressListViewController" bundle:nil];
//                                       alvc.tag = _tag;
//                                       [self.navigationController pushViewController:alvc animated:YES];
                                   }
                                   /*
                                   else if (FROM_ACCOUNTSET_VC == _mode) {
                                       ModifyViewController * mvc = [[ModifyViewController alloc]initWithNibName:@"ModifyViewController" bundle:nil];
                                       [self.navigationController pushViewController:mvc animated:YES];
                                   }
                                    */
                                   
                               }onFailure:^(NSError *error){
                                   NSString *msg = error.userInfo[@"errors"] == nil ? @"账号在其他地方登录，已退出请返回！" : error.userInfo[@"errors"];
                                   
                                   [[UserInfo instance] removeToken];
                                   [[UserInfo instance] removeTempToken];
                                   [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                                   [UserAPI createTempUserSuccess:^(NSString *str)
                                    {
//                                        [Utils showMessage:@"退出成功!" inView:self.view];
//                                        [self.navigationController popViewControllerAnimated:YES];
                                        NSLog(@"创建临时账号成功！4");
                                        [self viewDidLoad];
                                    } onFailure:^(NSError *error)
                                    {
//                                        NSString *msg = error.userInfo[@"message"] == nil ? @"登录失败，请重试" : error.userInfo[@"message"];
//                                        [Utils showMessage:msg inView:self.view];
                                        NSLog(@"创建临时账号失败！");
                                    }];
//                                   [self viewDidLoad];
                                   [Utils showMessage2:msg inView:self.view];
                                   NSLog(@"登录失败，请重试  %@",error);
                               }];
    }
}

- (IBAction)sendVerificationAction:(id)sender {
    if (!self.canGetCode) {
        return;
    }
    
    
   
    [_phoneTextField resignFirstResponder];
    if (/*_phoneTextField.text*/[self phoneNumber].length != 11) {
        [Utils showMessage:@"手机号码不正确" inView:self.view];
        return;
    }
    self.canGetCode = NO;
    
    if ([self phoneNumber].length > 0) {
      
        [self getCode:[self phoneNumber]];
    }
}
/****/
-(NSString*)phoneNumber
{
   
    if (_phoneTextField.text.length ==11) {
        NSRange range = [_phoneTextField.text rangeOfString:@"****"];
        if (range.length) {
            return _phone;
        }else{
            return _phoneTextField.text;
        }
    }else{
          return _phone.length == 11?_phone:_phoneTextField.text;
    }
}
/****/

- (void)getCode:(NSString *)number {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [UserAPI getVaildCodePhone:number
                     onSuccess:^(NSString *success) {
                         [_phoneTextField becomeFirstResponder];
                         [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                         [self countDown];
                         self.timer = [NSTimer scheduledTimerWithTimeInterval:1
                                                                       target:self
                                                                     selector:@selector(countDown)
                                                                     userInfo:nil
                                                                      repeats:YES];
                     }
                     onFailure:^(NSError *error) {
                         [self resetCountTime];
                         [Utils showMessage:@"获取验证码失败，请重试" inView:self.view];
                     }];
}

- (void)countDown {
    if (self.countDownSec == 0) {
        [self resetCountTime];
        return;
    }
    NSString* title = [NSString stringWithFormat:@"重新获取(%d秒)", self.countDownSec];
    _getCodeTipLabel.text = title;
    _getCodeTipLabel.textColor = [UIColor whiteColor];
    self.countDownSec--;
}

- (void)resetCountTime {
    self.countDownSec = 60;
    self.canGetCode = YES;
    [self.timer invalidate];
    _getCodeTipLabel.text = @"获取验证码";
    _getCodeTipLabel.textColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
   
        if (textField.text.length < 11 || [string isEqualToString:@""]) {
            return YES;
        }
        return NO;
}

@end
