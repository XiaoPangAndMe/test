//
//  MyCustomUITableViewCell.m
//  AiDingDing
//
//  Created by CDB on 15/10/5.
//  Copyright (c) 2015年 iDingDing. All rights reserved.
//

#import "MyCustomUITableViewCell.h"
#import "ConstDefine.h"
@implementation MyCustomUITableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier NS_AVAILABLE_IOS(3_0)
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.frame = CGRectMake(0, 0,WIN_SIZE.width, WIN_SIZE.height*0.32);
    //如果初始化成功
    if (self) {
        //创建最新推荐图片
        self.imageWork = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width * 0.05,3,self.frame.size.width * 0.9, self.frame.size.height - 30)];
        
        
        NSLog(@"win_size.width=%f,frame.size.width=%f",WIN_SIZE.width,self.frame.size.width);
        
        [self.imageWork setImage:[UIImage imageNamed:@"tempworks.png"]];
        
        //self.imageWork.backgroundColor = [UIColor greenColor];
        //self.contentView.backgroundColor = [UIColor clearColor];
        
        [self.contentView addSubview:self.imageWork];
        
        //创建最新推荐下部的白色条视图容器
        self.subView = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width * 0.05,self.frame.size.height - 27, self.frame.size.width * 0.9, 30)];
        UIColor *myWhiteTransparentColor = [ UIColor colorWithWhite: 2.1 alpha: 0.1];
        [self.subView setBackgroundColor:myWhiteTransparentColor];
        [self.contentView addSubview:self.subView];
        
        //创建一个标签用于显示该事件的标题
        self.lbWorkName = [[UILabel alloc] initWithFrame:CGRectMake(0,0,WIN_SIZE.width*0.45, 30)];
        
        NSLog(@"lbHeight=%f",self.frame.size.height);
        //设置左对齐
        self.lbWorkName.textAlignment=NSTextAlignmentLeft;
        //设置label的字体
        self.lbWorkName.font=[UIFont boldSystemFontOfSize:12];
        //设置背景色
        self.lbWorkName.backgroundColor=[UIColor clearColor];
        //lable_Title.backgroundColor=[UIColor clearColor];
        
        //将lable_Title控件添加到当前单元格
        [self.subView addSubview:self.lbWorkName];
        //头像
        
        
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
