//
//  UIView+TAXAdditions.h
//  BaiSiJie
//
//  Created by 谭安溪 on 16/3/6.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (TAXAdditions)
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
/**
 *  判断一个空间是否正真显示在主窗口
 */
- (BOOL)isShowingOnKeyWindow;

@end
