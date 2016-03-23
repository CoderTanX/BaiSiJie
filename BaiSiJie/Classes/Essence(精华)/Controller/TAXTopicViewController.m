//
//  TAXTopicViewController.m
//  BaiSiJie
//
//  Created by 谭安溪 on 16/3/15.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

#import "TAXTopicViewController.h"
#import "GGNetworking.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"
#import "TAXTopic.h"
#import "MJExtension.h"
#import "TAXTopicCell.h"
@interface TAXTopicViewController ()

@property (nonatomic, strong) NSMutableArray *topics; ///<数据源
@property (nonatomic, copy) NSString *maxtime; ///<最大时间
@property (nonatomic, assign) NSInteger page; ///<当前页
@property (nonatomic, strong) NSDictionary *params; ///<参数

@end

static NSString *const TAXTopicCellId = @"TopicCell";

@implementation TAXTopicViewController

- (NSString *)type{
    return nil;
}

- (NSMutableArray *)topics{
    
    if (!_topics) {
        _topics = [NSMutableArray array];
    }
    return _topics;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化列表
    [self setupTableView];
    //初始化刷新控件
    [self setupRefresh];
}
/**
 *  初始化列表
 */
- (void)setupTableView{
    self.tableView.backgroundColor = TAXGlobalBg;
    CGFloat top = TAXTitlesViewY + TAXTitlesViewH;
    CGFloat bottom = self.tabBarController.tabBar.height;
    self.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TAXTopicCell class]) bundle:nil] forCellReuseIdentifier:TAXTopicCellId];
    
}

/**
 *  初始化刷新控件
 */
- (void)setupRefresh{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
}

/**
 * 下拉刷新
 */
- (void)loadNewTopics{
    [self.tableView.mj_footer endRefreshing];
    self.page = 0;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @(self.topticType);
    params[@"page"] = @(self.page);
    self.params = params;
    [GGNetworking getWithUrl:SERVICE_URL parameters:params success:^(id response) {
        if (self.params != params) return ;
        
        [self.tableView.mj_header endRefreshing];
        [self.topics removeAllObjects];
        self.maxtime = response[@"info"][@"maxtime"];
        NSArray *data = [TAXTopic mj_objectArrayWithKeyValuesArray:response[@"list"]];
        [self.topics addObjectsFromArray:data];
        [self.tableView reloadData];
        self.page = 0;
    } failure:^(NSError *error) {
        if (self.params != params) return ;
        [self.tableView.mj_header endRefreshing];
    }];
}

/**
 * 上拉加载
 */
- (void)loadMoreTopics{
    [self.tableView.mj_header endRefreshing];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @(self.topticType);
    params[@"maxtime"] = self.maxtime;
    params[@"page"] = @(++self.page);
    self.params = params;
    [GGNetworking getWithUrl:SERVICE_URL parameters:params success:^(id response) {
        if (self.params != params) return ;
        [self.tableView.mj_footer endRefreshing];
        self.maxtime = response[@"info"][@"maxtime"];
        NSArray *data = [TAXTopic mj_objectArrayWithKeyValuesArray:response[@"list"]];
        [self.topics addObjectsFromArray:data];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        if (self.params != params) return ;
        [self.tableView.mj_footer endRefreshing];
        self.page--;
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.topics.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TAXTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:TAXTopicCellId];
    cell.topic = self.topics[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TAXTopic *topic = self.topics[indexPath.row];
    return topic.TopicCellH;
}


@end
