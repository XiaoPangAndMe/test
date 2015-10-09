//
//  GeneralTableViewCell.m
//  AiDingDing
//
//  Created by CDB on 15/10/7.
//  Copyright (c) 2015年 iDingDing. All rights reserved.
//

#import "GeneralTableViewCell.h"

@implementation GeneralTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithFrame:(CGRect)frame1 andLable1Frame:(CGRect)frame2 andLable2Frame:(CGRect)frame3 andUIImageFrame1:(CGRect)frame4 andUIImageFrame2:(CGRect)frame5 andWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier NS_AVAILABLE_IOS(3_0)
{
    //初始化父类
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.frame = frame1;
    //如果初始化成功
    if (self) {
        //我的信息项目栏的图片Icon
        self.imageViewItem1 = [[UIImageView alloc] initWithFrame:frame4];
        
        [self.contentView addSubview:self.imageViewItem1];
        //
        self.imageViewItem2 = [[UIImageView alloc] initWithFrame:frame5];
        
        [self.contentView addSubview:self.imageViewItem2];
        
        //创建一个标签用于显示该事件的标题
        self.lbItem1 = [[UILabel alloc] initWithFrame:frame2];
        
        NSLog(@"lbHeight=%f",self.frame.size.height);
        //设置左对齐
        self.lbItem1.textAlignment=NSTextAlignmentLeft;
        //设置label的字体
        self.lbItem1.font=[UIFont boldSystemFontOfSize:12];
        //设置背景色
        self.lbItem1.backgroundColor=[UIColor clearColor];
        //将lable_Title控件添加到当前单元格
        [self addSubview:self.lbItem1];
        
        //信息数量显示(可选)
        self.lbItem2 = [[UILabel alloc] initWithFrame:frame3];
        //设置左对齐
        self.lbItem2.textAlignment=NSTextAlignmentLeft;
        //设置label的字体
        self.lbItem2.font=[UIFont boldSystemFontOfSize:12];
        //设置背景色
        self.lbItem2.backgroundColor=[UIColor clearColor];
        //将lable_Title控件添加到当前单元格
        [self addSubview:self.lbItem2];
        
        //
        
    }
    return self;
}





- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
