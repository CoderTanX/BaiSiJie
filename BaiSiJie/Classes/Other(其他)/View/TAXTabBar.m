//
//  TAXTabBar.m
//  BaiSiJie
//
//  Created by 谭安溪 on 16/3/6.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

#import "TAXTabBar.h"
#import "TAXPublishView.h"
#import "TAXPostWordViewController.h"
#import "TAXNavigationController.h"
@interface TAXTabBar ()
@property (nonatomic, weak) UIButton *publishBt;
@end
@implementation TAXTabBar

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UIButton *publishBt = [UIButton buttonWithType:UIButtonTypeCustom];
        [publishBt setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [publishBt setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        [publishBt addTarget:self action:@selector(publishBtClick) forControlEvents:UIControlEventTouchUpInside];
        [publishBt sizeToFit];
        [self addSubview:publishBt];
        self.publishBt = publishBt;
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.publishBt.center = CGPointMake(self.frame.size.width*0.5, self.frame.size.height*0.5);
    CGFloat buttonY = 0;
    CGFloat buttonW = self.frame.size.width/5;
    CGFloat buttonH = self.frame.size.height;
    NSInteger index = 0;
    for (UIView *button in self.subviews) {
        if ([button isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            CGFloat buttonX = buttonW * (index<2?index:index+1);
            button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
            index ++;
        }
    }
}

- (void)publishBtClick{
    [TAXPublishView show];
//    TAXNavigationController *nav = [[TAXNavigationController alloc] initWithRootViewController:[[TAXPostWordViewController alloc]init]];
//    UIViewController *root = [UIApplication sharedApplication].keyWindow.rootViewController;
//    [root presentViewController:nav animated:YES completion:nil];
}



@end
