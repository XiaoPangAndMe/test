//
//  BaseViewController.m
//  allinns_business
//
//  Created by libohao on 14-7-25.
//  Copyright (c) 2014年 bestapp. All rights reserved.
//

#import "BaseViewController.h"
#import "ConstDefine.h"
#import "UIImage+UIImage_imageWithColor.h"

@interface BaseViewController ()<UITextFieldDelegate>

@end

@implementation BaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if(iOSVersion >= 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.automaticallyAdjustsScrollViewInsets = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
        self.navigationController.navigationBar.translucent = NO;
        self.navigationController.navigationBar.barTintColor = NAV_BAR_COLOR;
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    } else {
        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageWithColor:NAV_BAR_COLOR size:CGSizeMake(1, 44)]
                                           forBarMetrics:UIBarMetricsDefault];
    }
    
    
    UIBarButtonItem* backItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonAction)];

    self.navigationItem.backBarButtonItem = backItem;
    

    
    [[UIBarButtonItem appearance] setBackgroundImage:[UIImage new]
                                                forState:UIControlStateNormal
                                              barMetrics:UIBarMetricsDefault];
    

    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, 0)
                                                             forBarMetrics:UIBarMetricsDefault];
        
    [[UIBarButtonItem appearance] setTitleTextAttributes:
         @{ UITextAttributeFont: [UIFont fontWithName:CHINESE_FONT_NAME size:17],
            UITextAttributeTextColor:[UIColor blackColor],
            UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetZero]} forState:UIControlStateNormal];
  
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)leftBarButtonAction {
    self.navigationController.delegate = nil;
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)setTitle:(NSString*)title
{
    CGSize size = [title sizeWithFont:[UIFont boldSystemFontOfSize:18]];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, size.width,iOSVersion >= 7 ?20 : 30)];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    UIView *itemView = [[UIView alloc] initWithFrame:CGRectMake(0,0, size.width, 20)];
    [itemView addSubview:button];
    
    self.navigationItem.titleView = itemView;
}

-(void)setLeftBarTitle:(NSString*)title target:(id)target action:(SEL)action
{
    UIBarButtonItem *leftButton =  [[UIBarButtonItem alloc]initWithTitle:title style:UIBarButtonItemStylePlain target:target action:action];

    self.navigationItem.leftBarButtonItem = leftButton;
}

-(void)setLeftBarImage:(UIImage*)image target:(id)target action:(SEL)action
{
    UIBarButtonItem* leftButton = [[UIBarButtonItem alloc]initWithImage:image style:UIBarButtonItemStylePlain target:target action:action];
    if (iOSVersion > 7) {
        leftButton.tintColor = [UIColor blackColor];
    }
    
    self.navigationItem.leftBarButtonItem = leftButton;
}

-(void)setRightBarTitle:(NSString*)title target:(id)target action:(SEL)action
{
    CGSize size = [title sizeWithFont:[UIFont boldSystemFontOfSize:15]];

    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, size.width,iOSVersion >= 7 ?20 : 30)];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [button setTitleEdgeInsets:UIEdgeInsetsMake(-2, 0, 0, 0)];
    
    UIView *itemView = [[UIView alloc] initWithFrame:CGRectMake(0,0, size.width, 20)];
    [itemView addSubview:button];
    
    
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:itemView];
    self.navigationItem.rightBarButtonItem = barButton;

}

-(void)setRightBarImage:(UIImage*)image target:(id)target action:(SEL)action
{
    UIBarButtonItem* rightButton = [[UIBarButtonItem alloc]initWithImage:image style:UIBarButtonItemStylePlain target:target action:action];

    self.navigationItem.rightBarButtonItem = rightButton;
    
}
@end
