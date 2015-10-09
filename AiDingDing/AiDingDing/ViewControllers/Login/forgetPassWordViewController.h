//
//  forgetPassWordViewController.h
//  AiDingDing
//
//  Created by lzy on 14-9-4.
//  Copyright (c) 2014年 bestapp. All rights reserved.
//

#import "BaseViewController.h"

typedef enum : NSUInteger {
    FROM_REGISTER_VC,
    FROM_ADD_EDIT_ADDRESS_VC,
    FROM_ACCOUNTSET_VC,
} FORGET_PASSWORD_VC_MODE;


@interface forgetPassWordViewController : BaseViewController<UITextFieldDelegate>
@property int tag;

@property (assign,nonatomic)FORGET_PASSWORD_VC_MODE mode;

@end
