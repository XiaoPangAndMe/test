//
//  DynamicScrollView.m
//  AiDingDing
//
//  Created by CDB on 15/10/2.
//  Copyright (c) 2015年 iDingDing. All rights reserved.
//

#import "DynamicScrollView.h"
#import "ConstDefine.h"
#import <QuartzCore/QuartzCore.h>
@implementation DynamicScrollView

-(void)initArray
{
    //存放图片的数组
    self.imageArray = [NSMutableArray arrayWithObjects: [UIImage imageNamed:@"t1.png"],[UIImage imageNamed:@"t2.png"],[UIImage imageNamed:@"t3.png"],nil];
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectMake(0, WIN_SIZE.height * 0.003 - 2, WIN_SIZE.width, WIN_SIZE.height *0.20)];
    
    [self initArray];
    
    [self configScrollView];
    
    [self setBackgroundColor:[UIColor blackColor]];
    
    /*if (self) {
        self.dynamicScrollView.backgroundColor = [UIColor whiteColor];
        self.dynamicScrollView.pagingEnabled = YES;
        self.dynamicScrollView.showsVerticalScrollIndicator = NO;
        self.dynamicScrollView.showsHorizontalScrollIndicator = NO;
        self.dynamicScrollView.delegate = (id)self;
        [self addSubview:self.dynamicScrollView];
        
        UIImageView *firstView=[[UIImageView alloc] initWithImage:[_imageArray lastObject]];
        CGFloat Width=self.dynamicScrollView.frame.size.width;
        CGFloat Height=self.dynamicScrollView.frame.size.height;
        firstView.frame=CGRectMake(0, 0, Width, Height);
        [self.dynamicScrollView addSubview:firstView];
        NSLog(@"----------:%lu",(unsigned long)[_imageArray count]);
        for (int i=0; i<[_imageArray count]; i++) {
            UIImageView *subViews=[[UIImageView alloc] initWithImage:[_imageArray objectAtIndex:i]];
            
            subViews.frame=CGRectMake(Width*(i+1), 0, Width, Height);
            [self.dynamicScrollView addSubview: subViews];
        }
        NSLog(@"------=%lu",(unsigned long)[_imageArray count]);
        UIImageView *lastView=[[UIImageView alloc] initWithImage:[_imageArray objectAtIndex:0]];
        lastView.frame=CGRectMake(Width*(_imageArray.count+1), 0, Width, Height);
        [self.dynamicScrollView addSubview:lastView];
        
        [self.dynamicScrollView setContentSize:CGSizeMake(Width*(_imageArray.count+2), Height)];
        
        [self.dynamicScrollView scrollRectToVisible:CGRectMake(Width, 0, Width, Height) animated:NO];
        
        //设置pageControl的位置，及相关属性，可选
        CGRect pageControlFrame=CGRectMake([[UIScreen mainScreen] bounds].size.width * 0.5 - 39, Height + 36, 78, 36);
        self.pageControl=[[UIPageControl alloc]initWithFrame:pageControlFrame];
        
        [self.pageControl setBounds:CGRectMake(0, 0, 16*(self.pageControl.numberOfPages-1), 16)];//设置pageControl中点的间距为16
        [self.pageControl.layer setCornerRadius:8];//设置圆角
        
        self.pageControl.numberOfPages= _imageArray.count;
        //self.pageControl.backgroundColor=[UIColor blueColor];//背景
        self.pageControl.currentPageIndicatorTintColor = [UIColor redColor];
        self.pageControl.currentPage=0;
        self.pageControl.enabled=YES;
        [self addSubview:self.pageControl];
        [self.pageControl addTarget:self action:@selector(pageTurn:)forControlEvents:UIControlEventValueChanged];
        
        _myTimer = [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(scrollToNextPage:) userInfo:nil repeats:YES];
        
    }*/
    
    
    return self;
}

-(void)configScrollView
{
     //初始化UIScrollView，设置相关属性，均可在storyBoard中设置
     CGRect frame=CGRectMake(0, 0,WIN_SIZE.width, WIN_SIZE.height *0.20);
     self.dynamicScrollView = [[UIScrollView alloc]initWithFrame:frame];    //scrollView的大小
     self.dynamicScrollView.backgroundColor=[UIColor blueColor];
     self.dynamicScrollView.pagingEnabled=YES;//以页为单位滑动，即自动到下一页的开始边界
     self.dynamicScrollView.showsVerticalScrollIndicator=NO;
     self.dynamicScrollView.showsHorizontalScrollIndicator=NO;//隐藏垂直和水平显示条
    
    self.dynamicScrollView.delegate = (id)self;
    UIImageView *firstView=[[UIImageView alloc] initWithImage:[self.imageArray lastObject]];
    CGFloat Width=self.dynamicScrollView.frame.size.width;
    CGFloat Height=self.dynamicScrollView.frame.size.height;
    firstView.frame=CGRectMake(0, 0, Width, Height);
    [self.dynamicScrollView addSubview:firstView];
    //set the last as the first
    
    for (int i=0; i<[self.imageArray count]; i++) {
        UIImageView *subViews=[[UIImageView alloc] initWithImage:[self.imageArray objectAtIndex:i]];
        subViews.frame=CGRectMake(Width*(i+1), 0, Width, Height);
        [self.dynamicScrollView addSubview: subViews];
    }
    
    UIImageView *lastView=[[UIImageView alloc] initWithImage:[self.imageArray objectAtIndex:0]];
    lastView.frame=CGRectMake(Width*(self.imageArray.count+1), 0, Width, Height);
    [self.dynamicScrollView addSubview:lastView];
    //set the first as the last
    
    [self.dynamicScrollView setContentSize:CGSizeMake(Width*(self.imageArray.count+2), Height)];
    [self addSubview:self.dynamicScrollView];
    [self.dynamicScrollView scrollRectToVisible:CGRectMake(Width, 0, Width, Height) animated:NO];
    //show the real first image,not the first in the scrollView
    
    
     //设置pageControl的位置，及相关属性，可选
     CGRect pageControlFrame=CGRectMake(Width*0.36, WIN_SIZE.height *0.16, 60, 36);
     self.pageControl=[[UIPageControl alloc]initWithFrame:pageControlFrame];
     
     [self.pageControl setBounds:CGRectMake(0, 0, 16*(self.pageControl.numberOfPages-1), 16)];//设置pageControl中点的间距为16
     [self.pageControl.layer setCornerRadius:8];//设置圆角
    
    self.pageControl.numberOfPages = self.imageArray.count;
    //    self.pageControl.backgroundColor=[UIColor blueColor];//背景
    self.pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    
    self.pageControl.currentPage=0;
    self.pageControl.enabled=YES;
    [self addSubview:self.pageControl];
    [self.pageControl addTarget:self action:@selector(pageTurn:)forControlEvents:UIControlEventValueChanged];
    
    self.myTimer=[NSTimer scheduledTimerWithTimeInterval:3.0f target:self selector:@selector(scrollToNextPage:) userInfo:nil repeats:YES];
    
}





#pragma UIScrollView delegate
-(void)scrollToNextPage:(id)sender
{
    NSInteger pageNum = self.pageControl.currentPage;
    CGSize viewSize=self.dynamicScrollView.frame.size;
    CGRect rect=CGRectMake((pageNum+2)*viewSize.width, 0, viewSize.width, viewSize.height);
    [self.dynamicScrollView scrollRectToVisible:rect animated:NO];
    pageNum++;
    if (pageNum==_imageArray.count) {
        CGRect newRect=CGRectMake(viewSize.width, 0, viewSize.width, viewSize.height);
        [self.dynamicScrollView scrollRectToVisible:newRect animated:NO];
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat pageWidth=self.dynamicScrollView.frame.size.width;
    int currentPage=floor((self.dynamicScrollView.contentOffset.x-pageWidth/2)/pageWidth)+1;
    if (currentPage==0) {
        self.pageControl.currentPage=_imageArray.count-1;
    }else if(currentPage==_imageArray.count+1){
        self.pageControl.currentPage=0;
    }
    self.pageControl.currentPage=currentPage-1;
    
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [_myTimer invalidate];
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    _myTimer=[NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(scrollToNextPage:) userInfo:nil repeats:YES];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pageWidth=self.dynamicScrollView.frame.size.width;
    CGFloat pageHeigth=self.dynamicScrollView.frame.size.height;
    int currentPage=floor((self.dynamicScrollView.contentOffset.x-pageWidth/2)/pageWidth)+1;
    NSLog(@"the current offset==%f",self.dynamicScrollView.contentOffset.x);
    NSLog(@"the current page==%d",currentPage);
    
    if (currentPage==0) {
        [self.dynamicScrollView scrollRectToVisible:CGRectMake(pageWidth*_imageArray.count, 0, pageWidth, pageHeigth) animated:NO];
        self.pageControl.currentPage=_imageArray.count-1;
        NSLog(@"pageControl currentPage==%ld",(long)self.pageControl.currentPage);
        NSLog(@"the last image");
        return;
    }else  if(currentPage==[_imageArray count]+1){
        [self.dynamicScrollView scrollRectToVisible:CGRectMake(pageWidth, 0, pageWidth, pageHeigth) animated:NO];
        self.pageControl.currentPage=0;
        NSLog(@"pageControl currentPage==%ld",(long)self.pageControl.currentPage);
        NSLog(@"the first image");
        return;
    }
    self.pageControl.currentPage=currentPage-1;
    NSLog(@"pageControl currentPage==%ld",(long)self.pageControl.currentPage);
    
}

-(void)pageTurn:(UIPageControl *)sender
{
    NSInteger pageNum = self.pageControl.currentPage;
    CGSize viewSize=self.dynamicScrollView.frame.size;
    [self.dynamicScrollView setContentOffset:CGPointMake((pageNum+1)*viewSize.width, 0)];
    NSLog(@"myscrollView.contentOffSet.x==%f",self.dynamicScrollView.contentOffset.x);
    NSLog(@"pageControl currentPage==%ld",(long)self.pageControl.currentPage);   [_myTimer invalidate];
}










@end
