//
//  TAXTopWindow.m
//  BaiSiJie
//
//  Created by 谭安溪 on 16/4/4.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

#import "TAXTopWindow.h"

@implementation TAXTopWindow

static UIWindow *window_;
+ (void)initialize{
    window_ = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, TAXScreenW, 20)];
    window_.windowLevel = UIWindowLevelAlert;
    [window_ addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(windowClick)]];
    
}

+ (void)show{
    window_.hidden = NO;
}

+ (void)hide{
    window_.hidden = YES;
}

+ (void)windowClick{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [self searchScrollViewInView:window];
}

+ (void)searchScrollViewInView:(UIView *)view{
    
    for (UIScrollView *subview in view.subviews) {
        if ([subview isKindOfClass:[UIScrollView class]]) {
                if ([subview isShowingOnKeyWindow]){
                    CGPoint offset = subview.contentOffset;
                    offset.y = - subview.contentInset.top;
                    [subview setContentOffset:offset animated:YES];
            }
        }
        [self searchScrollViewInView:subview];
    }

}

@end
