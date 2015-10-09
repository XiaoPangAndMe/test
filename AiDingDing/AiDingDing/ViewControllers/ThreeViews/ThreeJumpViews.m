//
//  ThreeJumpViews.m
//  AiDingDing
//
//  Created by CDB on 15/10/4.
//  Copyright (c) 2015年 iDingDing. All rights reserved.
//

#import "ThreeJumpViews.h"

@implementation ThreeJumpViews
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIColor *myWhiteTransparentColor = [ UIColor colorWithWhite: 0.7 alpha: 0.10 ];
        [self setBackgroundColor:myWhiteTransparentColor];
        NSInteger width = self.frame.size.width;
        NSInteger height = self.frame.size.height;
        
        NSLog(@"=%ld,=%ld",(long)width,(long)height);
        
        //热门设计师
        UIButton *hotDesignerBtn = [[UIButton alloc] initWithFrame:CGRectMake(25,20, 50, 50)];
        [hotDesignerBtn setImage:[UIImage imageNamed:@"HotDesigner.png"] forState:UIControlStateNormal];
        [hotDesignerBtn addTarget:self action:@selector(jumpToHotDesigner:) forControlEvents:UIControlEventTouchUpInside];
        //创意商城
        UIButton *newIdeasBtn = [[UIButton alloc] initWithFrame:CGRectMake(25+width*0.33,20,50,50)];
        [newIdeasBtn setImage:[UIImage imageNamed:@"NewIdea.png"] forState:UIControlStateNormal];
        [newIdeasBtn addTarget:self action:@selector(jumpNewIdeas:) forControlEvents:UIControlEventTouchUpInside];
        //艺术发现
        UIButton *artDiscoverBtn = [[UIButton alloc] initWithFrame:CGRectMake(25+width*0.66,20,50,50)];
        [artDiscoverBtn setImage:[UIImage imageNamed:@"ArtDisscover.png"] forState:UIControlStateNormal];
        [artDiscoverBtn addTarget:self action:@selector(jumpArtDiscover:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:hotDesignerBtn];
        [self addSubview:newIdeasBtn];
        [self addSubview:artDiscoverBtn];
            }
    return self;
}

- (void)jumpToHotDesigner:(id)sender
{
    NSLog(@"jumpToHotDesigner");
}

- (void)jumpNewIdeas:(id)sender
{
    NSLog(@"jumpNewIdeas");
}

- (void)jumpArtDiscover:(id)sender
{
    NSLog(@"jumpArtDiscover");
}

@end
