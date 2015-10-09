//
//  MyCustomUITableViewCell.h
//  AiDingDing
//
//  Created by CDB on 15/10/5.
//  Copyright (c) 2015年 iDingDing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCustomUITableViewCell : UITableViewCell

@property(nonatomic,strong)UIImageView *imageWork;
@property(nonatomic,strong)UILabel *lbWorkName;
@property(nonatomic,strong)UILabel *lbAuthorName;
@property(nonatomic,strong)UIImageView *imageAuthorHeader;
@property(nonatomic,strong)UIView *subView;

@end