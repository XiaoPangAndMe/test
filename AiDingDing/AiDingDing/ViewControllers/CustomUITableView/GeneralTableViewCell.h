//
//  GeneralTableViewCell.h
//  AiDingDing
//
//  Created by CDB on 15/10/7.
//  Copyright (c) 2015年 iDingDing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GeneralTableViewCell : UITableViewCell
@property (nonatomic,strong)UILabel *lbItem1;
@property (nonatomic,strong)UILabel *lbItem2;
@property (nonatomic,strong)UIImageView *imageViewItem1;
@property (nonatomic,strong)UIImageView *imageViewItem2;

- (id)initWithFrame:(CGRect)frame1 andLable1Frame:(CGRect)frame2 andLable2Frame:(CGRect)frame3 andUIImageFrame1:(CGRect)frame4 andUIImageFrame2:(CGRect)frame5 andWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier NS_AVAILABLE_IOS(3_0);
@end
