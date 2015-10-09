//
//  MyPersonalInformationDetail.m
//  AiDingDing
//
//  Created by CDB on 15/10/7.
//  Copyright (c) 2015年 iDingDing. All rights reserved.
//

#import "MyPersonalInformationDetail.h"
#import "ConstDefine.h"
#import "GeneralTableViewCell.h"

@interface MyPersonalInformationDetail ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)NSMutableArray * arrItemString;
@property(nonatomic,strong)NSMutableArray * arrItemDetailUrlString;
@property(nonatomic,strong)UITableView *tableViewPersonal;
@end

@implementation MyPersonalInformationDetail

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:CUSTOM_GRAY_COLOR];
    
    self.arrItemString = [[NSMutableArray alloc] initWithObjects:@"头像",@"用户名",@"性别",@"生日",@"居住地",@"邮箱",@"手机",@"QQ",@"微信",@"签名",@"等级", nil];
    
    //先开辟空间,初始化数据从服务器get 暂时用假数据
    self.arrItemDetailUrlString = [[NSMutableArray alloc] initWithObjects:@"tempHeader.png",@"爱吃牛肉的兔子",@"女",@"1990-06-21",@"中国-广东-深圳",@"3182942431@qq.com",@"13121923616",@"3182942431",@"Wade",@"想爱就别怕伤痛",@"LV.1", nil];
    
    //初始化tableview列表
    //为视图控件开辟空间
    self.tableViewPersonal = [[UITableView alloc] initWithFrame:CGRectMake(0,0, WIN_SIZE.width, WIN_SIZE.height*0.90)];
    //为视图控件设置dataSource和delegate
    self.tableViewPersonal.dataSource = (id)self;
    self.tableViewPersonal.delegate = (id)self;
    self.tableViewPersonal.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self.view addSubview:self.tableViewPersonal];
}

- (void)viewWillAppear:(BOOL)animated
{
    //头标题
    UIImageView *titleView = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2.0 - 22.5, 7, 55, 32)];
    titleView.tag = 501;
    titleView.image = [UIImage imageNamed:@"title.png"];
    //[self .navigationController.navigationBar addSubview:titleView];
    //self.navigationItem.titleView = titleView;
    self.navigationItem.title = @"个人信息";
    self.navigationController.navigationBar.barTintColor =  [UIColor redColor];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    
    UIButton *messagebutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [messagebutton setFrame:CGRectMake(0, 0, 25, 25)];
    [messagebutton setBackgroundImage:[UIImage imageNamed:@"leftNav.png"] forState:UIControlStateNormal];
    
    [messagebutton addTarget:self action:@selector(backToMine) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftbtn = [[UIBarButtonItem alloc] initWithCustomView:messagebutton];
    
    self.navigationItem.leftBarButtonItem=leftbtn;
    self.navigationController.navigationBarHidden = NO;
}

- (void)backToMine
{
    NSLog(@"backToMine");
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

#pragma -mark delegate @required

//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    //返回列表的行数
//    NSLog(@"countIcon =%ld",[self.arrItemString count]);
//    return [self.arrItemString count];
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellId = @"cellId";
    GeneralTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    //
    CGRect frame1 = CGRectMake(0, 0, WIN_SIZE.width, WIN_SIZE.height * 0.8);
    CGRect frame2 = CGRectMake(10, 10, 140, 20);
    CGRect frame3 = CGRectMake(WIN_SIZE.width - 150, 5, 100,40);
    CGRect frame4 = CGRectMake(WIN_SIZE.width - 80,4,36,36);
    CGRect frame5 = CGRectMake(WIN_SIZE.width - 30,10,20,20);
    if (cell == nil) {
        //传递各个控件的位置初始化控件
        if (0 == [indexPath row]) {
            cell = [[GeneralTableViewCell alloc] initWithFrame:frame1 andLable1Frame:frame2 andLable2Frame:frame3 andUIImageFrame1:frame4 andUIImageFrame2:frame5 andWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            
            
            
        }else
        {
            cell = [[GeneralTableViewCell alloc] initWithFrame:frame1 andLable1Frame:frame2 andLable2Frame:frame3 andUIImageFrame1:frame4 andUIImageFrame2:frame5 andWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            
            
        }
        
        [cell.imageViewItem2 setImage:[UIImage imageNamed:@"right_Arrow.png"]];
        
        
    }
    switch (indexPath.section) {
            
        case 0://对应各自的分区
        {
            [cell.lbItem1 setText:[self.arrItemString objectAtIndex:[indexPath row]]];
            [cell.imageViewItem1 setImage:[UIImage imageNamed:[self.arrItemDetailUrlString objectAtIndex:[indexPath row]]]];//给cell添加数据
        }
        break;
            
        case 1:
        {
            [cell.lbItem1 setText:[self.arrItemString objectAtIndex:[indexPath row]+1]];
            [cell.lbItem2 setText:[self.arrItemDetailUrlString objectAtIndex:[indexPath row]+1]];
        }
            break;
        case 2:
            {
                [cell.lbItem1 setText:[self.arrItemString objectAtIndex:[indexPath row]+4]];
                [cell.lbItem2 setText:[self.arrItemDetailUrlString objectAtIndex:[indexPath row]+4]];
            }
            break;
        case 3:
            {
                [cell.lbItem1 setText:[self.arrItemString objectAtIndex:[indexPath row]+5]];
                [cell.lbItem2 setText:[self.arrItemDetailUrlString objectAtIndex:[indexPath row]+5]];
            }
            
            break;
        case 4:
            {
                [cell.lbItem1 setText:[self.arrItemString objectAtIndex:[indexPath row]+9]];
                [cell.lbItem2 setText:[self.arrItemDetailUrlString objectAtIndex:[indexPath row]+9]];
            }
           break;
        case 5:
            
            {
                [cell.lbItem1 setText:[self.arrItemString objectAtIndex:[indexPath row]+10]];
                [cell.lbItem2 setText:[self.arrItemDetailUrlString objectAtIndex:[indexPath row]+10]];
            }
            break;
        default:
            NSLog(@"");
    }
    
    
    return cell;
}

//指定标题的高度

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 8;
    
}

//每个section显示的标题

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    switch (section) {
            
        case 0:
            
            return  @"";//每个分区通常对应不同的数组，返回其元素个数来确定分区的行数
            
            break;
            
        case 1:
            
            return  @"";
            
            break;
        case 2:
            
            return  @"";
            
            break;
        case 3:
            
            return  @"";
            
            break;
        case 4:
            
            return  @"";
            
            break;
        case 5:
            
            return  @"";
            
            break;
            
        default:
            
            return @"";
            
            break;
            
    }
    
    
    
}



//指定有多少个分区(Section)，默认为1

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 6;//返回标题数组中元素的个数来确定分区的个数
    
}



//指定每个分区中有多少行，默认为1

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    switch (section) {
            
        case 0:
            
            return  1;//每个分区通常对应不同的数组，返回其元素个数来确定分区的行数
            
            break;
            
        case 1:
            
            return  3;
            
            break;
        case 2:
            
            return  1;
            
            break;
        case 3:
            
            return  4;
            
            break;
        case 4:
            
            return  1;
            
            break;
        case 5:
            
            return  1;
            
            break;
            
        default:
            
            return 0;
            
            break;
            
    }
    
}

//该方法的返回值将作为每个表格行的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return WIN_SIZE.height * 0.08;
}

//单元格的点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"[indexPath row]= %ld",[indexPath row]);
    NSLog(@"Jump to My Infomation detail Edit page!");
    switch (indexPath.section) {
        case 0://对应各自的分区
        {
            switch ([indexPath row]) {
                case SELF_HEADER_EDIT:
                {
                    NSLog(@"SELF_HEADER_EDIT");
//                    MyPersonalInformationDetail *myPersonalInformationDetailVC = [[MyPersonalInformationDetail alloc] init];
//                    myPersonalInformationDetailVC.modalTransitionStyle = 2;
//                    //myPersonalInformationDetailVC.title = @"个人信息";
//                    [self.navigationController pushViewController:myPersonalInformationDetailVC animated:YES];
                }
                    break;
                    
                default:
                    break;
            }
            break;
        }
        case 1://对应各自的分区
        {
            switch ([indexPath row]) {
                case SELF_USER_NAME:
                    NSLog(@"SELF_USER_NAME");
                    
                    break;
                case SELF_SEX:
                    NSLog(@"SELF_SEX");
                    break;
                case SELF_BIRTHDAY:
                    NSLog(@"SELF_BIRTHDAY");
                    break;
                default:
                    break;
            }
            break;
        }
        case 2:
        {
            switch ([indexPath row]) {
                case SELF_ADRESS:
                    NSLog(@"SELF_ADRESS");
                    break;
                    
                default:
                    break;
            }
            break;
        }
        case 3:
        {
            switch ([indexPath row]) {
                case SELF_MAILBOX:
                    NSLog(@"SELF_MAILBOX");
                    break;
                case SELF_TELEPHONE:
                    NSLog(@"SELF_TELEPHONE");
                    break;
                case SELF_QQ:
                    NSLog(@"SELF_QQ");
                    break;
                case SELF_WE_CHAT:
                    NSLog(@"SELF_WE_CHAT");
                    break;
                default:
                    break;
            }
            break;
        }
        case 4:
        {
            switch ([indexPath row]) {
                case SELF_SIGN:
                    NSLog(@"SELF_SIGN");
                    break;
                    
                default:
                    break;
            }
            break;
        }
        case 5:
        {
            switch ([indexPath row]) {
                case SELF_LEVEL:
                    NSLog(@"SELF_LEVEL");
                    
                    break;
                    
                default:
                    break;
            }
            break;
        }
            break;
            default:
        break;
    
    }

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
