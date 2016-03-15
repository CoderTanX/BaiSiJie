//
//  TAXNavigationController.m
//  BaiSiJie
//
//  Created by 谭安溪 on 16/3/7.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

#import "TAXNavigationController.h"

@implementation TAXNavigationController

+ (void)initialize{
//    UIBarButtonItem *item = [UIBarButtonItem appearance];
//    [item setBackButtonBackgroundImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
//    [item setBackButtonBackgroundImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
   
    if (self.viewControllers.count>0) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        [button setTitle:@"返回" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [button sizeToFit];
        button.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:YES];
    
}

- (void)back{
    [self popViewControllerAnimated:YES];
}



@end
