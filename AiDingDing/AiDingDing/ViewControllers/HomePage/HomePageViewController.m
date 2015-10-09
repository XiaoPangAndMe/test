//
//  HomePageViewController.m
//  AiDingDing
//
//  Created by CDB on 15/10/2.
//  Copyright (c) 2015年 iDingDing. All rights reserved.
//

#import "HomePageViewController.h"
#import "DynamicScrollView.h"
#import "ThreeJumpViews.h"
#import "ConstDefine.h"
#import "SwipeView.h"
#import "MyCustomUITableViewCell.h"
#import "TableViewCellUseXib.h"
@interface HomePageViewController ()<SwipeViewDelegate,SwipeViewDataSource,UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)NSMutableArray *scrollViewPicArr;
@property(nonatomic,strong)DynamicScrollView *dynamicScrollView;
@property(nonatomic,strong)ThreeJumpViews *threeView;
@property (nonatomic,strong)SwipeView* clothListSwipeView;//衣服列表?

@property(strong,nonatomic)UITableView* tableViewWorkList;//自定义的衣服列表

@property NSMutableArray * dataArray;

@property NSMutableArray * arrayWorks;

@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //从服务器获取图片
    [self initDynamicScrollViewPic];
    //增加滚动视图
    self.dynamicScrollView= [[DynamicScrollView alloc] initWithFrame:CGRectMake(0, WIN_SIZE.height * 0.15, WIN_SIZE.width, WIN_SIZE.height *0.20)];
    
    //增加艺术家，热门设计师，艺术发现
    self.threeView = [[ThreeJumpViews alloc] initWithFrame:CGRectMake(WIN_SIZE.width * 0.05, WIN_SIZE.height * 0.22, WIN_SIZE.width * 0.9, WIN_SIZE.height *0.15)];
    
    
    [self.view addSubview:self.threeView];
                                                                      
    [self.view addSubview:self.dynamicScrollView];
    
    
    //初始化衣服列表 ？
    [self createClothListSwipeView];
    
    //初始化最新推荐作品列表
    [self createLatestWorkList];
}
#pragma -mark 创建最新推荐作品列表
- (void)createLatestWorkList
{
    self.arrayWorks = [[NSMutableArray alloc] init];
    
    //为视图控件开辟空间
    self.tableViewWorkList = [[UITableView alloc] initWithFrame:CGRectMake(0, WIN_SIZE.height * 0.415, WIN_SIZE.width, WIN_SIZE.height * 0.4)];
    //为视图控件设置dataSource和delegate
    self.tableViewWorkList.dataSource = (id)self;
    self.tableViewWorkList.delegate = (id)self;
    
    [self.view addSubview:self.tableViewWorkList];
    
    
}

#pragma -mark UITableView Delegate DataSource@required
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //返回数据的数量
    NSLog(@"count= %ld",[self.arrayWorks count]);
    return 2;//[self.arrayWorks count];
}

//该方法决定 tableView的  显示
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //为每个表格定义一个静态字符作为标记符
    static NSString *cellId = @"cellId";
    //从可重用的表格行的队列中取出一个表格
    MyCustomUITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];

    //如果取出的表格行为nil
    if (cell == nil) {
        //创建自定义的MyCustomUITableViewCell的对象
        cell = [[MyCustomUITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
       //cell.imageWork = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"temp.png"]];
        //[cell.imageWork setImage:[UIImage imageWithContentsOfFile:@"temp.png"]];
        cell.lbWorkName.text = @"董丽茹";
    }
    
    /*
    //为每个表格定义一个静态字符作为标记符
    static NSString *cellId = @"cellId";
    //从可重用的表格行的队列中取出一个表格
    TableViewCellUseXib * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    //TableViewCellUseXib
    //如果取出的表格行为nil
    if (cell == nil) {
        //创建自定义的MyCustomUITableViewCell的对象
        cell = [[TableViewCellUseXib alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        //cell.imageWork = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"temp.png"]];
        //[cell.imageWork setImage:[UIImage imageWithContentsOfFile:@"temp.png"]];
        //cell.lbWorkName.text = @"董丽茹";
    }
     */
    return cell;
}

//该方法的返回值将作为每个表格行的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return WIN_SIZE.height * 0.32;
}

//单元格的点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Jump to detail page!");
}


#pragma -mark 创建衣服刷新列表
- (void)createClothListSwipeView
{
    //
    UILabel* label = [[UILabel alloc] init];
    label.text = @"|最新推荐";
    [label setFrame:CGRectMake(2, WIN_SIZE.height*0.37, WIN_SIZE.width, 35)];
    label.textColor = [UIColor redColor];
    label.textAlignment = NSTextAlignmentLeft;
    label.font =[ UIFont systemFontOfSize:15];
    [self.view addSubview:label];
}

#pragma -mark SwipeViewDataSource delegate
//
- (NSInteger)numberOfItemsInSwipeView:(SwipeView *)swipeView
{
    return _dataArray.count;
}

//
- (UIView *)swipeView:(SwipeView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    if (!view)
    {
        view = [[UILabel alloc]initWithFrame:CGRectMake(0, WIN_SIZE.height*0.5, WIN_SIZE.width, 34)];
        view.backgroundColor = [UIColor blackColor];
    }
    UILabel* label = (UILabel*)view;
    label.text = @"|推荐";
    label.textColor = [UIColor redColor];
    label.textAlignment = NSTextAlignmentLeft;
    label.font =[ UIFont systemFontOfSize:15];
    
    return view;
    
}

- (CGSize)swipeViewItemSize:(SwipeView *)swipeView
{
    if (_clothListSwipeView == swipeView)
    {
        return CGSizeMake(WIN_SIZE.width, 35);
    }
    
    return self.clothListSwipeView.bounds.size;
}

//作废的滚动视图的图片数组
- (void)initDynamicScrollViewPic
{
   self.scrollViewPicArr = [NSMutableArray arrayWithObjects: [UIImage imageNamed:@"t1.png"],[UIImage imageNamed:@"t2.png"],[UIImage imageNamed:@"t3.png"],nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.tableViewWorkList reloadData];
    UIImageView *titleView = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2.0 - 22.5, 7, 55, 32)];
    titleView.tag = 500;
    titleView.image = [UIImage imageNamed:@"title.png"];
    //[self .navigationController.navigationBar addSubview:titleView];
    self.navigationItem.titleView = titleView;
    
    self.navigationController.navigationBar.barTintColor =  [UIColor redColor];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    
    //右边的  导航按钮
    UIButton *searchbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchbutton setFrame:CGRectMake(0, [[UIScreen mainScreen] bounds].size.width, 25, 25)];
    [searchbutton setBackgroundImage:[UIImage imageNamed:@"search.png"] forState:UIControlStateNormal];
    
    [searchbutton addTarget:self action:@selector(rightTo) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *right_button = [[UIBarButtonItem alloc] initWithCustomView:searchbutton];
    
    self.navigationItem.rightBarButtonItem=right_button;
    
    UIButton *messagebutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [messagebutton setFrame:CGRectMake(0, 0, 25, 25)];
    [messagebutton setBackgroundImage:[UIImage imageNamed:@"message.png"] forState:UIControlStateNormal];
    
    [messagebutton addTarget:self action:@selector(leftTo) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftbtn = [[UIBarButtonItem alloc] initWithCustomView:messagebutton];
    
    self.navigationItem.leftBarButtonItem=leftbtn;
    self.navigationController.navigationBarHidden = NO;
}

//跳转搜索页
- (void)rightTo
{
    NSLog(@"rightTo...searchJump");
    
    
}

//跳转私信界面
- (void)leftTo
{
    NSLog(@"leftTo...messageJump");
    
    
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
