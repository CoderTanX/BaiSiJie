//
//  TAXRecommendTagViewController.m
//  BaiSiJie
//
//  Created by 谭安溪 on 16/3/14.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

#import "TAXRecommendTagViewController.h"
#import "GGNetworking.h"
#import "TAXRecommendTag.h"
#import "MJExtension.h"
#import "UIImageView+WebCache.h"
#import "TAXRecommendTagCell.h"
#import "SVProgressHUD.h"
@interface TAXRecommendTagViewController ()

@property (nonatomic, strong) NSArray *tags; ///<数据源
@end

static NSString *const tagCellId = @"TagCell";
@implementation TAXRecommendTagViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置title
    self.title = @"推荐标签";
    //请求数据
    [self loadTags];
    //初始化tableView
    [self setupTableView];
    
}
/**
 *  初始化tableView
 */
- (void)setupTableView{
    self.tableView.backgroundColor = TAXGlobalBg;
    self.tableView.rowHeight = 70;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}
/**
 *  请求数据
 */
- (void)loadTags{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TAXRecommendTagCell class]) bundle:nil] forCellReuseIdentifier:tagCellId];
    params[@"a"] = @"tag_recommend";
    params[@"action"] = @"sub";
    params[@"c"] = @"topic";
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    TAXWeakSelf
    [GGNetworking getWithUrl:SERVICE_URL parameters:params success:^(id response) {
        [SVProgressHUD dismiss];
        weakSelf.tags = [TAXRecommendTag mj_objectArrayWithKeyValuesArray:response];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];

}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tags.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TAXRecommendTagCell *cell = [tableView dequeueReusableCellWithIdentifier:tagCellId];
    cell.recommendTag = self.tags[indexPath.row];
    return cell;
}




@end
