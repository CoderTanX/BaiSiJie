//
//  TAXMeViewController.m
//  BaiSiJie
//
//  Created by 谭安溪 on 16/3/6.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

#import "TAXMeViewController.h"
#import "TAXMeCell.h"
#import "TAXMeFooterView.h"
#import "GGNetworking.h"
#import "TAXSquare.h"
#import "MJExtension.h"
@interface TAXMeViewController ()<UITableViewDataSource>
@property (nonatomic, strong) NSArray *squares; ///<数据源
@property (nonatomic, weak) TAXMeFooterView *footerView; ///<底部视图
@end

static NSString *const TAXMeId = @"me";
@implementation TAXMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //基本设置
    [self setupBasic];
    //设置tableView
    [self setupTableView];
    //请求数据
    [self requestData];
}
/**
 * 基本设置
 */
- (void)setupBasic{
    
    self.navigationItem.title = @"我的";
    
    //创建设置按钮
    UIBarButtonItem *settingItem = [UIBarButtonItem itemWithImage:@"mine-setting-icon" highlightImage:@"mine-setting-icon-click" target:self action:@selector(settingClick)];
    
    //创建月亮按钮
    UIBarButtonItem *moonItem2 = [UIBarButtonItem itemWithImage:@"mine-moon-icon" highlightImage:@"mine-moon-icon-click" target:self action:@selector(moonClick)];
    
    self.navigationItem.rightBarButtonItems = @[settingItem,moonItem2];
    
    
}

/**
 *  设置tableView
 */
- (void)setupTableView{
    //设置背景颜色
    self.tableView.backgroundColor = TAXGlobalBg;
    //设置分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //注册tableView
    [self.tableView registerClass:[TAXMeCell class] forCellReuseIdentifier:TAXMeId];
    //设置sectionHeaderHeight
    self.tableView.sectionHeaderHeight = 0;
    //设置sectionFooterHeight
    self.tableView.sectionFooterHeight = TAXTopicCellMargin;
    //设置内边距
    self.tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);
    
//    self.tableView.tableFooterView = footerView;
//    self.footerView = footerView;
}
/**
 *  请求数据
 */
- (void)requestData{
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"square";
    params[@"c"] = @"topic";

    [GGNetworking getWithUrl:SERVICE_URL parameters:params success:^(id response) {
        self.squares = [TAXSquare mj_objectArrayWithKeyValuesArray:response[@"square_list"]];
        //设置底部视图
        TAXMeFooterView *footerView = [[TAXMeFooterView alloc] init];
        footerView.squares = self.squares;
        self.tableView.tableFooterView = footerView;
    } failure:^(NSError *error) {
        
    }];
}


#pragma mark - <UITableViewDataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TAXMeCell *cell = [tableView dequeueReusableCellWithIdentifier:TAXMeId];
    if (indexPath.section == 0) {
        cell.imageView.image = [UIImage imageNamed:@"mine_icon_nearby"];
        cell.textLabel.text = @"登录/注册";
    }else{
        cell.textLabel.text = @"离线下载";
    }
    
    return cell;
}


- (void)settingClick{
    NSLog(@"%s",__func__);
}

- (void)moonClick{
    NSLog(@"%s",__func__);
}


@end
