
//
//  MyInfoTableViewCell.m
//  AiDingDing
//
//  Created by CDB on 15/10/6.
//  Copyright (c) 2015年 iDingDing. All rights reserved.
//

#import "MyInfoTableViewCell.h"
#import "ConstDefine.h"

@implementation MyInfoTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier NS_AVAILABLE_IOS(3_0)
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.frame = CGRectMake(0, 0,WIN_SIZE.width, WIN_SIZE.height*0.1);
    //如果初始化成功
    if (self) {
        //我的信息项目栏的图片Icon
        self.imageItem = [[UIImageView alloc] initWithFrame:CGRectMake(10,5,20,20)];
    
        NSLog(@"win_size.width=%f,frame.size.width=%f",WIN_SIZE.width,self.frame.size.width);
        
        [self.contentView addSubview:self.imageItem];
        
        //创建一个标签用于显示该事件的标题
        self.lbWorkName = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width * 0.15,5,100, 20)];
        
        NSLog(@"lbHeight=%f",self.frame.size.height);
        //设置左对齐
        self.lbWorkName.textAlignment=NSTextAlignmentLeft;
        //设置label的字体
        self.lbWorkName.font=[UIFont boldSystemFontOfSize:12];
        //设置背景色
        self.lbWorkName.backgroundColor=[UIColor clearColor];
        //将lable_Title控件添加到当前单元格
        [self addSubview:self.lbWorkName];
        
        //右导向箭头
        self.imageRightArrow = [[UIImageView alloc] initWithFrame:CGRectMake(WIN_SIZE.width - 30,9,15,15)];
        [self.contentView addSubview:self.imageRightArrow];
        
        //信息数量显示(可选)
        self.lbCountShow = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width - 50,5,40, 20)];
        
        NSLog(@"lbHeight=%f",self.frame.size.height);
        //设置左对齐
        self.lbCountShow.textAlignment=NSTextAlignmentLeft;
        //设置label的字体
        self.lbCountShow.font=[UIFont boldSystemFontOfSize:12];
        //设置背景色
        self.lbCountShow.backgroundColor=[UIColor clearColor];
        //将lable_Title控件添加到当前单元格
        [self addSubview:self.lbCountShow];
    }
    return self;
}



@end
