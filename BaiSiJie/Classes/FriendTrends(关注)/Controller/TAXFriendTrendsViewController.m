//
//  TAXFriendTrendsViewController.m
//  BaiSiJie
//
//  Created by 谭安溪 on 16/3/6.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

#import "TAXFriendTrendsViewController.h"
#import "TAXRecommendViewController.h"
#import "TAXLoginRegisterViewController.h"
@interface TAXFriendTrendsViewController ()

@end

@implementation TAXFriendTrendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = TAXGlobalBg;
    self.navigationItem.title = @"我的关注";
    //设置左边的itembutton
    UIButton *recommendBt = [UIButton buttonWithType:UIButtonTypeCustom];
    [recommendBt setBackgroundImage:[UIImage imageNamed:@"friendsRecommentIcon"] forState:UIControlStateNormal];
    [recommendBt setBackgroundImage:[UIImage imageNamed:@"friendsRecommentIcon-click"] forState:UIControlStateHighlighted];
    [recommendBt sizeToFit];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" highlightImage:@"friendsRecommentIcon-click" target:self action:@selector(recommendClick)];
    
    
}

- (void)recommendClick{
    TAXRecommendViewController *recommendVC = [[TAXRecommendViewController alloc] init];
    [self.navigationController pushViewController:recommendVC animated:YES];
}
- (IBAction)loginRegisterClick {
    TAXLoginRegisterViewController *lfVC = [[TAXLoginRegisterViewController alloc] init];
    [self presentViewController:lfVC animated:YES completion:nil];
}
@end
