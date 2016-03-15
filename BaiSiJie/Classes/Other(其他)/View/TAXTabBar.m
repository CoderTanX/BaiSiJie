//
//  TAXTabBar.m
//  BaiSiJie
//
//  Created by 谭安溪 on 16/3/6.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

#import "TAXTabBar.h"

@interface TAXTabBar ()
@property (nonatomic, weak) UIButton *publicBt;
@end
@implementation TAXTabBar

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UIButton *publicBt = [UIButton buttonWithType:UIButtonTypeCustom];
        [publicBt setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [publicBt setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        [publicBt sizeToFit];
        [self addSubview:publicBt];
        self.publicBt = publicBt;
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.publicBt.center = CGPointMake(self.frame.size.width*0.5, self.frame.size.height*0.5);
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

@end
