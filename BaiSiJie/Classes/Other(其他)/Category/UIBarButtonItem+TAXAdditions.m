//
//  UIBarButtonItem+TAXAdditions.m
//  BaiSiJie
//
//  Created by 谭安溪 on 16/3/7.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

#import "UIBarButtonItem+TAXAdditions.h"

@implementation UIBarButtonItem (TAXAdditions)
+ (instancetype)itemWithImage:(NSString *)image highlightImage:(NSString *)highlightImage target:(id)target action:(SEL)action{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:highlightImage] forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    return [[self alloc] initWithCustomView:button];
}
@end
