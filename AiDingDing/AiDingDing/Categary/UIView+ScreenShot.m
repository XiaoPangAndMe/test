//
//  UIView+ScreenShot.m
//  AiDingDing
//
//  Created by libohao on 14-10-16.
//  Copyright (c) 2014年 bestapp. All rights reserved.
//

#import "UIView+ScreenShot.h"

@implementation UIView (ScreenShot)


// 使用上下文截图,并使用指定的区域裁剪,模板代码
- (UIImage*)screenShot
{
//    UIImage* image;
//    // 将要被截图的view
//    // 背景图片 总的大小
    CGSize size = self.bounds.size;
//    UIGraphicsBeginImageContext(size);
//    // 开启上下文,使用参数之后,截出来的是原图（YES  0.0 质量高）
//    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
//    
//    // 裁剪的关键代码,要裁剪的矩形范围
//    CGRect rect = CGRectMake(0, 0, size.width, size.height  );
//    //注：iOS7以后renderInContext：由drawViewHierarchyInRect：afterScreenUpdates：替代
//    [self drawViewHierarchyInRect:rect  afterScreenUpdates:YES];
//    // 从上下文中,取出UIImage
//    UIImage *snapshot = UIGraphicsGetImageFromCurrentImageContext();
//    // 添加截取好的图片到图片View里面
//    image = snapshot;
//    
//    // 千万记得,结束上下文(移除栈顶上下文)
//    UIGraphicsEndImageContext();
//    
//    return image;

    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0f);
    
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    
//    CGRect rect = CGRectMake(0, 0, size.width, size.height  );
//    
//    
//    [self drawViewHierarchyInRect:rect  afterScreenUpdates:YES];

    
    UIImage *screenShot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return screenShot;
     
    
    
    /*
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);     //设置截屏大小
    [[self layer] renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
//    CGImageRef imageRef = viewImage.CGImage;
    //    CGRect rect = CGRectMake(166, 211, 426, 320);//这里可以设置想要截图的区域
//    CGRect rect = CGRectMake(0, 0,size.width,size.height);//这里可以设置想要截图的区域
//    CGImageRef imageRefRect =CGImageCreateWithImageInRect(imageRef, rect);
//    UIImage *sendImage = [[UIImage alloc] initWithCGImage:imageRef];
    return viewImage;
    */
}

//-(UIImage *)ScreenShot{
//    //这里因为我需要全屏接图所以直接改了，宏定义iPadWithd为1024，iPadHeight为
//}
- (UIImage*)screenShotAfterScreenUpdates:(BOOL)update
{
    UIImage* image;
    // 将要被截图的view
    // 背景图片 总的大小
    CGSize size = CGSizeMake(self.bounds.size.width, self.bounds.size.height - 20);
    UIGraphicsBeginImageContext(size);
    // 开启上下文,使用参数之后,截出来的是原图（YES  0.0 质量高）
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    
    // 裁剪的关键代码,要裁剪的矩形范围
    CGRect rect = CGRectMake(0, 0, size.width, size.height  );
    //注：iOS7以后renderInContext：由drawViewHierarchyInRect：afterScreenUpdates：替代
    
    
    [self drawViewHierarchyInRect:rect  afterScreenUpdates:YES];
//    [self drawViewHierarchyInRect:rect  afterScreenUpdates:NO];
    // 从上下文中,取出UIImage
    UIImage *snapshot = UIGraphicsGetImageFromCurrentImageContext();
    // 添加截取好的图片到图片View里面
    image = snapshot;
    
    // 千万记得,结束上下文(移除栈顶上下文)
    UIGraphicsEndImageContext();
    
    return image;
}

@end
