//
//  TAXTabBarController.m
//  BaiSiJie
//
//  Created by 谭安溪 on 16/3/6.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

#import "TAXTabBarController.h"
#import "TAXEssenceViewController.h"
#import "TAXNewViewController.h"
#import "TAXFriendTrendsViewController.h"
#import "TAXMeViewController.h"
#import "TAXTabBar.h"
#import "TAXNavigationController.h"
@interface TAXTabBarController ()
@end

@implementation TAXTabBarController

+ (void)initialize{
    //统一设置TabBarItemTitle的大小和颜色
    UITabBarItem *item = [UITabBarItem appearance];
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    attributes[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attributes[NSForegroundColorAttributeName] = [UIColor grayColor];
    [item setTitleTextAttributes:attributes forState:UIControlStateNormal];
    NSMutableDictionary *selectAttributes = [NSMutableDictionary dictionary];
    selectAttributes[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    selectAttributes[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    [item setTitleTextAttributes:selectAttributes forState:UIControlStateSelected];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加自控制器
    [self setupChildVc:[[TAXEssenceViewController alloc] init] title:@"精华" image:@"tabBar_essence_icon" selectImage:@"tabBar_essence_click_icon"];
    [self setupChildVc:[[TAXNewViewController alloc] init] title:@"新帖" image:@"tabBar_new_icon" selectImage:@"tabBar_new_click_icon"];
    [self setupChildVc:[[TAXFriendTrendsViewController alloc] init] title:@"关注" image:@"tabBar_friendTrends_icon" selectImage:@"tabBar_friendTrends_click_icon"];
    [self setupChildVc:[[TAXMeViewController alloc] initWithStyle:UITableViewStyleGrouped] title:@"我" image:@"tabBar_me_icon" selectImage:@"tabBar_me_click_icon"];
    [self setValue:[[TAXTabBar alloc] init] forKeyPath:@"tabBar"];
    
}

 - (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
}

- (void)setupChildVc:(UIViewController*)vc title:(NSString *)title image:(NSString *)image selectImage:(NSString *)selectImage
{    
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectImage];
    TAXNavigationController *nav = [[TAXNavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
    
}



@end
