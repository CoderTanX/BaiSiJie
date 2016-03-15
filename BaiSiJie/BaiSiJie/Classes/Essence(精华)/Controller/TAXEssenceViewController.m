//
//  TAXEssenceViewController.m
//  BaiSiJie
//
//  Created by 谭安溪 on 16/3/6.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

#import "TAXEssenceViewController.h"
#import "TAXRecommendTagViewController.h"
@interface TAXEssenceViewController ()

@end

@implementation TAXEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(100)/100. green:arc4random_uniform(100)/100. blue:arc4random_uniform(100)/100. alpha:1];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    //设置左边的itembutton
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highlightImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];

}

- (void)tagClick{
    TAXRecommendTagViewController *rtVC = [[TAXRecommendTagViewController alloc] initWithStyle:UITableViewStylePlain];
    [self.navigationController pushViewController:rtVC animated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor orangeColor];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
