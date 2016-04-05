//
//  TAXMeFooterView.m
//  BaiSiJie
//
//  Created by 谭安溪 on 16/4/5.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

#import "TAXMeFooterView.h"
#import "TAXSquare.h"
#import "UIButton+WebCache.h"
#import "TAXSquareButton.h"
#import "TAXWebViewController.h"
@implementation TAXMeFooterView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
    }
    return self;
}

- (void)setSquares:(NSArray *)squares{
    _squares = squares;
    
    [self createSquareBts];
}

- (void)createSquareBts{
    
    CGFloat buttonW = TAXScreenW/TAXMeSquareMaxCols;
    CGFloat buttonH = buttonW;
    
    for (int i = 0; i<self.squares.count; i++) {
        TAXSquare *square = self.squares[i];
        TAXSquareButton *button = [TAXSquareButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i%TAXMeSquareMaxCols*buttonW, i/TAXMeSquareMaxCols*buttonH, buttonW, buttonH);
        button.url = square.url;
        [button setTitle:square.name forState:UIControlStateNormal];
        [button sd_setImageWithURL:[NSURL URLWithString:square.icon] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
    
    // 总页数 == (总个数 + 每页的最大数 - 1) / 每页最大数
    NSUInteger rows = (self.squares.count + TAXMeSquareMaxCols - 1) / TAXMeSquareMaxCols;
    
    // 计算footer的高度
    self.height = rows * buttonH;
    
}

- (void)buttonClick:(TAXSquareButton *)button{
    if (![button.url hasPrefix:@"http"]) return;
    UITabBarController *tab = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    UINavigationController *nav = tab.selectedViewController;
    TAXWebViewController *webVc = [[TAXWebViewController alloc] init];

    webVc.url = button.url;
    [nav pushViewController:webVc animated:YES];
}


@end
