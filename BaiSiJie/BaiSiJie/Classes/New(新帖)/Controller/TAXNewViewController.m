//
//  TAXNewViewController.m
//  BaiSiJie
//
//  Created by 谭安溪 on 16/3/6.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

#import "TAXNewViewController.h"

@interface TAXNewViewController ()

@end

@implementation TAXNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(100)/100. green:arc4random_uniform(100)/100. blue:arc4random_uniform(100)/100. alpha:1];
     self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    //设置左边的itembutton
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highlightImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];

}

- (void)tagClick{
    NSLog(@"%s",__func__);
}

@end
