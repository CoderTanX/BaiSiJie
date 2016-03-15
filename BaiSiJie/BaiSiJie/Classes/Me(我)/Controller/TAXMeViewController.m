//
//  TAXMeViewController.m
//  BaiSiJie
//
//  Created by 谭安溪 on 16/3/6.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

#import "TAXMeViewController.h"

@interface TAXMeViewController ()

@end

@implementation TAXMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(100)/100. green:arc4random_uniform(100)/100. blue:arc4random_uniform(100)/100. alpha:1];
    self.navigationItem.title = @"我的";
    
    //创建设置按钮
    UIBarButtonItem *settingItem = [UIBarButtonItem itemWithImage:@"mine-setting-icon" highlightImage:@"mine-setting-icon-click" target:self action:@selector(settingClick)];
    
    //创建月亮按钮
    UIBarButtonItem *moonItem2 = [UIBarButtonItem itemWithImage:@"mine-moon-icon" highlightImage:@"mine-moon-icon-click" target:self action:@selector(moonClick)];
    
    self.navigationItem.rightBarButtonItems = @[settingItem,moonItem2];
}

- (void)settingClick{
    NSLog(@"%s",__func__);
}

- (void)moonClick{
    NSLog(@"%s",__func__);
}


@end
