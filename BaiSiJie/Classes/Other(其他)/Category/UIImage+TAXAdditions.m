//
//  UIImage+TAXAdditions.m
//  BaiSiJie
//
//  Created by 谭安溪 on 16/4/4.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

#import "UIImage+TAXAdditions.h"

@implementation UIImage (TAXAdditions)
- (instancetype)circleImage{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0);
    //获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //添加一个圆
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextAddEllipseInRect(ctx, rect);
    //裁剪
    CGContextClip(ctx);
    [self drawInRect:rect];
    
    UIImage * image =  UIGraphicsGetImageFromCurrentImageContext();
    //关闭
    UIGraphicsEndImageContext();
    return image;
}
@end
