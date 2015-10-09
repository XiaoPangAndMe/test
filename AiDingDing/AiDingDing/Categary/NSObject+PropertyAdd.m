//
//  NSObject+PropertyAdd.m
//  AiDingDing
//
//  Created by 众乐多屏传媒公司 on 15/8/11.
//  Copyright (c) 2015年 bestapp. All rights reserved.
//

#import "NSObject+PropertyAdd.h"
#import <objc/runtime.h>
static const void *IndieBandNameKey = &IndieBandNameKey;



@implementation NSObject (PropertyAdd)
@dynamic materal_id;

- (NSString *)materal_id {
        return objc_getAssociatedObject(self, IndieBandNameKey);
}

- (void)setMateral_id:(NSString *)materal_id{
        objc_setAssociatedObject(self, IndieBandNameKey, materal_id, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
