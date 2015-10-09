//
//  MyInfoViewController.m
//  AiDingDing
//
//  Created by CDB on 15/9/28.
//  Copyright (c) 2015年 iDingDing. All rights reserved.
//

#import "MyInfoViewController.h"
#import "MyInfoTableViewCell.h"
#import "ConstDefine.h"
#import "MyPersonalInformationDetail.h"
@interface MyInfoViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)NSMutableArray *arrIcon;
@property(nonatomic,strong)NSMutableArray *arrDescription;
@property(nonatomic,strong)UITableView *myInfoTableVIew;
@property(nonatomic,strong)UIView *topView;
@property(nonatomic,strong)UIView *middleView;
@end

@implementation MyInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //[self.view setBackgroundColor:[UIColor whiteColor]];
    
    self.arrDescription = [[NSMutableArray alloc] initWithObjects:@"我的订单",@"我的订制",@"我的收藏",@"我的购物车",@"收货地址",@"个人信息",@"我的消息",@"谁看过我",@"我的关注/粉丝", nil];
    
    self.arrIcon = [[NSMutableArray alloc] initWithObjects:@"myOrders.png",@"myCustomWork.png",@"shouchang.png",@"shoppingCar.png",@"addrees.png",@"geren.png",@"myMessage.png",@"whoseeme.png",@"myFans.png", nil];
    UIColor *myWhiteTransparentColor = [ UIColor colorWithWhite: 0.7 alpha: 0.10 ];
    [self.view setBackgroundColor:myWhiteTransparentColor];
    //创建我的项目列表
    [self createMyInfoList];
    //创建我的头部栏
    [self createTopPart];
    //创建我的中部钱包账户相关信息
    [self createWalletPart];
}

//创建我的中部钱包账户相关信息
- (void)createWalletPart
{
    //中间视图容器
    self.middleView = [[UIView alloc] initWithFrame:CGRectMake(0, 66 + WIN_SIZE.height * 0.15, WIN_SIZE.width,WIN_SIZE.height * 0.15 - 3)];
    UIColor *myWhiteTransparentColor = [ UIColor colorWithWhite: 0.7 alpha: 0.10 ];
    
    [self.middleView setBackgroundColor:myWhiteTransparentColor];
    
    //topHalfView
    UIView * topHalfView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIN_SIZE.width, WIN_SIZE.height * 0.073)];
    [topHalfView setBackgroundColor:[UIColor whiteColor]];
    
    //钱包Image
    UIImageView * headerImage = [[UIImageView alloc] initWithFrame:CGRectMake(10,8,25,25)];
    headerImage.image = [UIImage imageNamed:@"qianbao.png"];
    [self.middleView addSubview:headerImage];
    
    //签到按钮
    UIButton * signButton = [[UIButton alloc] initWithFrame:CGRectMake(WIN_SIZE.width - 60,8,40,20)];
    [signButton setImage:[UIImage imageNamed:@"sign.png"] forState:UIControlStateNormal];
    [signButton addTarget:self action:@selector(ToSign) forControlEvents:UIControlEventTouchUpInside];
    [self.middleView addSubview:signButton];
    
    [topHalfView addSubview:signButton];
    [topHalfView addSubview:headerImage];
    
    
    //我的钱包
    UILabel *lbMyWallet = [[UILabel alloc] initWithFrame:CGRectMake(50,12,100, 20)];
    //设置左对齐
    lbMyWallet.textAlignment=NSTextAlignmentLeft;
    //设置label的字体
    lbMyWallet.font=[UIFont boldSystemFontOfSize:13];
    //设置背景色
    lbMyWallet.backgroundColor=[UIColor clearColor];
    lbMyWallet.text = @"我的钱包";
    //将lable_Title控件添加到当前单元格
    [topHalfView addSubview:lbMyWallet];
    [self.middleView addSubview:topHalfView];
    
    
    //左下角的账户余额
    UIView *viewLeftDown = [[UIView alloc] initWithFrame:CGRectMake(0,WIN_SIZE.height*0.08, WIN_SIZE.width*0.32, 35)];
    [viewLeftDown setBackgroundColor:[UIColor whiteColor]];
    //账户余额字样
    UILabel *lbMyRestMoney = [[UILabel alloc] initWithFrame:CGRectMake(25,16,100, 20)];
    //设置左对齐
    lbMyRestMoney.textAlignment=NSTextAlignmentLeft;
    //设置label的字体
    lbMyRestMoney.font=[UIFont boldSystemFontOfSize:13];
    //设置背景色
    lbMyRestMoney.backgroundColor=[UIColor clearColor];
    lbMyRestMoney.text = @"账户余额";
    
    NSInteger countRestMoney = 1;
    //余额
    UILabel *lbMyRestMoneyCount = [[UILabel alloc] initWithFrame:CGRectMake(35,5,100, 20)];
    //设置左对齐
    lbMyRestMoneyCount.textAlignment=NSTextAlignmentLeft;
    //设置label的字体
    lbMyRestMoneyCount.font=[UIFont boldSystemFontOfSize:13];
    //设置背景色
    lbMyRestMoneyCount.backgroundColor=[UIColor clearColor];
    lbMyRestMoneyCount.text = [NSString stringWithFormat:@"%ld元",countRestMoney];
    [viewLeftDown addSubview:lbMyRestMoney];
    [viewLeftDown addSubview:lbMyRestMoneyCount];
    [self.middleView addSubview:viewLeftDown];
    
    //右下角的优惠券
    UIView *viewRightDown = [[UIView alloc] initWithFrame:CGRectMake(WIN_SIZE.width*0.68, WIN_SIZE.height*0.08, WIN_SIZE.width*0.32, 35)];
    [viewRightDown setBackgroundColor:[UIColor whiteColor]];
    
    //优惠券
    UILabel *lbDiscountCard = [[UILabel alloc] initWithFrame:CGRectMake(35,16,100, 20)];
    //设置左对齐
    lbDiscountCard.textAlignment=NSTextAlignmentLeft;
    //设置label的字体
    lbDiscountCard.font=[UIFont boldSystemFontOfSize:13];
    //设置背景色
    lbDiscountCard.backgroundColor=[UIColor clearColor];
    lbDiscountCard.text = @"优惠券";
    
    //张数
    NSInteger countDiscount = 3;
    //余额
    UILabel *lbDiscountCount = [[UILabel alloc] initWithFrame:CGRectMake(40,5,100, 20)];
    //设置左对齐
    lbDiscountCount.textAlignment=NSTextAlignmentLeft;
    //设置label的字体
    lbDiscountCount.font=[UIFont boldSystemFontOfSize:11];
    //设置背景色
    lbDiscountCount.backgroundColor=[UIColor clearColor];
    lbDiscountCount.text = [NSString stringWithFormat:@"%ld张",countDiscount];
    [viewRightDown addSubview:lbDiscountCount];
    [viewRightDown addSubview:lbDiscountCard];
    //
    [self.middleView addSubview:viewRightDown];

    
    
    //中下角的账户余额
    UIView *viewMiddleDown = [[UIView alloc] initWithFrame:CGRectMake(WIN_SIZE.width*0.35 - 2,WIN_SIZE.height*0.08, WIN_SIZE.width*0.32, 35)];
    [viewMiddleDown setBackgroundColor:[UIColor whiteColor]];
    
    //叮叮币
    UILabel *lbDingDingCoin = [[UILabel alloc] initWithFrame:CGRectMake(25,16,100, 20)];
    //设置左对齐
    lbDingDingCoin.textAlignment=NSTextAlignmentLeft;
    //设置label的字体
    lbDingDingCoin.font=[UIFont boldSystemFontOfSize:13];
    //设置背景色
    lbDingDingCoin.backgroundColor=[UIColor clearColor];
    lbDingDingCoin.text = @"叮叮币";
    
    //
    NSInteger countDingDingCoin = 2;
    //叮叮币
    UILabel *lbDingDingCoinCount = [[UILabel alloc] initWithFrame:CGRectMake(35,5,100, 20)];
    //设置左对齐
    lbDingDingCoinCount.textAlignment=NSTextAlignmentLeft;
    //设置label的字体
    lbDingDingCoinCount.font=[UIFont boldSystemFontOfSize:13];
    //设置背景色
    lbDingDingCoinCount.backgroundColor=[UIColor clearColor];
    lbDingDingCoinCount.text = [NSString stringWithFormat:@"%ld个",countDingDingCoin];
    //
    [viewMiddleDown addSubview:lbDingDingCoinCount];
    [viewMiddleDown addSubview:lbDingDingCoin];
    //
    [self.middleView addSubview:viewMiddleDown];
    
    
    
    
    [self.view addSubview:self.middleView];
}

//签到
- (void)ToSign
{
    NSLog(@"ToSign");
}

//创建我的头部栏
- (void)createTopPart
{
    self.topView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, WIN_SIZE.width,WIN_SIZE.height * 0.15)];
    [self.topView setBackgroundColor:[UIColor whiteColor]];
    //以后要改为从网络获取的图片和昵称
    NSString *headerName = @"tempHeader.png";
    NSString *nickName = @"Wade";
    NSString *description = @"Men/Chigago/MiamiHeat";
    //头像Image
    UIImageView * headerImage = [[UIImageView alloc] initWithFrame:CGRectMake(10,15,50,50)];
    headerImage.image = [UIImage imageNamed:headerName];
    [self.topView addSubview:headerImage];
    
    //昵称
    UILabel *lbNickName = [[UILabel alloc] initWithFrame:CGRectMake(65,20,100, 20)];
    //设置左对齐
    lbNickName.textAlignment=NSTextAlignmentLeft;
    //设置label的字体
    lbNickName.font=[UIFont boldSystemFontOfSize:13];
    //设置背景色
    lbNickName.backgroundColor=[UIColor clearColor];
    lbNickName.text = nickName;
    //将lable_Title控件添加到当前单元格
    [self.topView addSubview:lbNickName];
    
    //性别/地址/国家
    UILabel * lbDescription = [[UILabel alloc] initWithFrame:CGRectMake(65,35,150, 20)];
    //设置左对齐
    lbDescription.textAlignment=NSTextAlignmentLeft;
    //设置label的字体
    lbDescription.font=[UIFont boldSystemFontOfSize:12];
    //设置背景色
    lbDescription.backgroundColor=[UIColor clearColor];
    lbDescription.text = description;
    //将lable_Title控件添加到当前单元格
    [self.topView addSubview:lbDescription];
    
    //右导航箭头
    //设置按钮
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setFrame:CGRectMake(WIN_SIZE.width - 35, 30, 20, 20)];
    [rightButton setBackgroundImage:[UIImage imageNamed:@"right_Arrow.png"] forState:UIControlStateNormal];
    
    [rightButton addTarget:self action:@selector(rightToMyNickName) forControlEvents:UIControlEventTouchUpInside];
    [self.topView addSubview:rightButton];
    
    [self.view addSubview:self.topView];
}

- (void)rightToMyNickName
{
    NSLog(@"rightToMyNickName");
    
}

//创建我的项目列表
- (void)createMyInfoList
{
    //为视图控件开辟空间
    self.myInfoTableVIew = [[UITableView alloc] initWithFrame:CGRectMake(0, WIN_SIZE.height * 0.31, WIN_SIZE.width, WIN_SIZE.height*0.60)];
    //为视图控件设置dataSource和delegate
    self.myInfoTableVIew.dataSource = (id)self;
    self.myInfoTableVIew.delegate = (id)self;
    self.myInfoTableVIew.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.myInfoTableVIew];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    //头标题
    UIImageView *titleView = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2.0 - 22.5, 7, 55, 32)];
    titleView.tag = 501;
    titleView.image = [UIImage imageNamed:@"title.png"];
    //[self .navigationController.navigationBar addSubview:titleView];
    //self.navigationItem.titleView = titleView;
    self.navigationItem.title = @"我的";
    self.navigationController.navigationBar.barTintColor =  [UIColor redColor];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    
    //设置按钮
    UIButton *searchbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchbutton setFrame:CGRectMake(0, [[UIScreen mainScreen] bounds].size.width, 25, 25)];
    [searchbutton setBackgroundImage:[UIImage imageNamed:@"Setting.png"] forState:UIControlStateNormal];
    
    [searchbutton addTarget:self action:@selector(rightToSetting) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *right_button = [[UIBarButtonItem alloc] initWithCustomView:searchbutton];
    
    self.navigationItem.rightBarButtonItem=right_button;
    
    UIButton *messagebutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [messagebutton setFrame:CGRectMake(0, 0, 25, 25)];
    [messagebutton setBackgroundImage:[UIImage imageNamed:@"leftNav.png"] forState:UIControlStateNormal];
    
    [messagebutton addTarget:self action:@selector(leftToHomePage) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftbtn = [[UIBarButtonItem alloc] initWithCustomView:messagebutton];

    self.navigationItem.leftBarButtonItem=leftbtn;
    self.navigationController.navigationBarHidden = NO;
    
   //NSLog(@"....width=%f,height=%f",self.self.navigationController.navigationBar.frame.size.width,self.navigationController.navigationBar.frame.size.height);
    //self.navigationController.navigationBar.frame = CGRectMake(0, 0, WIN_SIZE.width, 10);
    //NSLog(@"||||||width=%f,height=%f",self.self.navigationController.navigationBar.frame.size.width,self.navigationController.navigationBar.frame.size.height);
    
    
    
}

- (void)rightToSetting
{
    NSLog(@"rightToSetting");
    
}

- (void)leftToHomePage
{
    NSLog(@"leftToHomePage");
    
}

#pragma -mark delegate @required

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //返回列表的行数
    NSLog(@"countIcon =%ld",[self.arrIcon count]);
    return [self.arrIcon count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellId = @"cellId";
    MyInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (cell == nil) {
        cell = [[MyInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        //
        [cell.imageItem setImage:[UIImage imageNamed:[self.arrIcon objectAtIndex:[indexPath row]]]];
        [cell.imageRightArrow setImage:[UIImage imageNamed:@"right_Arrow.png"]];
        //
        NSLog(@"content= %@ row=%ld",[self.arrDescription objectAtIndex:[indexPath row]],[indexPath row]);
        [cell.lbWorkName setText:[self.arrDescription objectAtIndex:[indexPath row]]];
        [cell.lbCountShow setText:@"0"];
        
    }
    return cell;
}

//该方法的返回值将作为每个表格行的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return WIN_SIZE.height * 0.065;
}

//单元格的点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Jump to My Infomation detail page!");
    switch ([indexPath row]) {
        case MINE_DING_DAN:
            NSLog(@"MINE_DING_DAN");
            
            break;
        case MINE_DING_ZHI:
            NSLog(@"MINE_DING_ZHI");
            
            break;
        case MINE_SHOU_CHANG:
            NSLog(@"MINE_SHOU_CHANG");
            
            break;
        case MINE_SHOPPING_CAR:
            NSLog(@"MINE_SHOPPING_CAR");
            
            break;
        case MINE_ADRRESS:
            NSLog(@"MINE_ADRRESS");
            
            break;
        case MINE_INFOMATION:
            NSLog(@"MINE_INFOMATION");
        {
            MyPersonalInformationDetail *myPersonalInformationDetailVC = [[MyPersonalInformationDetail alloc] init];
            myPersonalInformationDetailVC.modalTransitionStyle = 2;
            //myPersonalInformationDetailVC.title = @"个人信息";
            [self.navigationController pushViewController:myPersonalInformationDetailVC animated:YES];
            
            //[self presentViewController:myPersonalInformationDetailVC animated:YES completion:nil];
        }
            break;
        case MINE_MESSAGE:
            NSLog(@"MINE_MESSAGE");
            
            break;
        case MINE_WHO_SEE_ME:
            NSLog(@"MINE_WHO_SEE_ME");
            
            break;
        case MINE_CARE_FANS:
            NSLog(@"MINE_CARE_FANS");
            
            break;
        
            
        default:
            break;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
@end
