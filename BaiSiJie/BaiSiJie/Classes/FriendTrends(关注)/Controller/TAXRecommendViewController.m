//
//  TAXRecommendViewController.m
//  BaiSiJie
//
//  Created by 谭安溪 on 16/3/8.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

#import "TAXRecommendViewController.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "GGNetworking.h"
#import "MJExtension.h"
#import "TAXRecommendCategory.h"
#import "TAXRecommendCategoryCell.h"
#import "TAXRecommendUser.h"
#import "TAXRecommendUserCell.h"
#import "MJRefresh.h"
#define TAXSelectedCategory self.categories[self.categoryTableView.indexPathForSelectedRow.row]
@interface TAXRecommendViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSArray *categories; ///<分类的数据源
//@property (nonatomic, strong) NSArray *users; ///<推荐的用户的数据源

@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
@property (weak, nonatomic) IBOutlet UITableView *userTableView;
@property (nonatomic, strong) NSMutableDictionary *params; ///<请求的参数

@end

static NSString *const categoryId = @"RecommendCategory";
static NSString *const userId = @"RecommendUser";
@implementation TAXRecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置控制器标题
    self.title = @"推荐关注";
    
    //设置控制器的背景色
    self.view.backgroundColor = TAXGlobalBg;
    
    //初始化tableView
    [self setupTableView];
    //加载左边的分类的列表
    [self loadCategories];

}

//初始化tableView
- (void)setupTableView{
    
    //注册tableView
    [self.categoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([TAXRecommendCategoryCell class]) bundle:nil] forCellReuseIdentifier:categoryId];
    self.categoryTableView.tableFooterView = [[UIView alloc] init];
    [self.userTableView registerNib:[UINib nibWithNibName:NSStringFromClass([TAXRecommendUserCell class]) bundle:nil] forCellReuseIdentifier:userId];
    self.userTableView.tableFooterView = [[UIView alloc] init];
    
    //设置tableView的行高
    self.userTableView.rowHeight = 70;
    self.categoryTableView.rowHeight = 44;
    
    //设置inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.categoryTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.userTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    
    //添加上拉加载
    self.userTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];
    
    //添加下拉刷新
    self.userTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUsers)];
}
//加载分类
- (void)loadCategories{
    //将模型caregory的id变成ID
    [TAXRecommendCategory mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                 @"ID":@"id"
                 };
    }];
    
    //设置参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    TAXWeakSelf
    //发送左边分类请求
    [GGNetworking getWithUrl:SERVICE_URL parameters:params success:^(id response) {
        [SVProgressHUD dismiss];
        weakSelf.categories = [TAXRecommendCategory mj_objectArrayWithKeyValuesArray:response[@"list"]];
        [weakSelf.categoryTableView reloadData];
        [weakSelf.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        [weakSelf.userTableView.mj_header beginRefreshing];
        
    } failure:^(NSError *error) {
        
    }];
}

//上拉加载更多数据
- (void)loadMoreUsers{
    TAXRecommendCategory *category = TAXSelectedCategory;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = category.ID;
    params[@"page"] = @(++category.currentPage);
    self.params = params;
    //发送做右边的用户的请求
    TAXWeakSelf
    [GGNetworking getWithUrl:SERVICE_URL parameters:params success:^(id response) {
        NSArray *users = [TAXRecommendUser mj_objectArrayWithKeyValuesArray:response[@"list"]];
        [category.users addObjectsFromArray:users];
        //如果请求参数不同就停止刷新
        if (weakSelf.params != params) return ;
        [weakSelf.userTableView reloadData];
        [weakSelf checkFooterStatus];
    } failure:^(NSError *error) {
        [weakSelf checkFooterStatus];
    }];
}

//下拉刷新数据
- (void)loadNewUsers{
    TAXRecommendCategory *category = TAXSelectedCategory;
    category.currentPage = 1;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = category.ID;
    params[@"page"] = @(category.currentPage);
    self.params = params;
    
    TAXWeakSelf
    //发送做右边的用户的请求
    [GGNetworking getWithUrl:SERVICE_URL parameters:params success:^(id response) {
        NSArray *users = [TAXRecommendUser mj_objectArrayWithKeyValuesArray:response[@"list"]];
        [category.users removeAllObjects];
        category.totalPage = [response[@"total_page"] integerValue];
        [category.users addObjectsFromArray:users];
        //如果请求参数不同就停止刷新
        if (weakSelf.params != params) return ;
        [weakSelf.userTableView reloadData];
        [weakSelf checkFooterStatus];
        [weakSelf.userTableView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        [weakSelf.userTableView.mj_header endRefreshing];
    }];
}

//检查footer的状态
- (void)checkFooterStatus{
    TAXRecommendCategory *category = TAXSelectedCategory;
    if (category.currentPage == category.totalPage) {
        [self.userTableView.mj_footer endRefreshingWithNoMoreData];
    }else{
        [self.userTableView.mj_footer endRefreshing];
    }

}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.categoryTableView) {//左边分类tableView
        return self.categories.count;
    }else{//右边用户的tableView
        TAXRecommendCategory *category = TAXSelectedCategory;
        self.userTableView.mj_footer.hidden = !category.users.count;
        [self checkFooterStatus];
        return category.users.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.categoryTableView) {//左边分类的tableView
        TAXRecommendCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:categoryId];
        cell.recommendCategory = self.categories[indexPath.row];
        return cell;
    }else{//右边的用户的tableView
        TAXRecommendCategory *category = TAXSelectedCategory;
        TAXRecommendUserCell *cell = [tableView dequeueReusableCellWithIdentifier:userId];
        cell.user = category.users[indexPath.row];
        return cell;
    }
    
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.categoryTableView) {
        
        [self.userTableView.mj_header endRefreshing];
        [self.userTableView.mj_footer endRefreshing];
        //取出被点击的左边的分类
        TAXRecommendCategory *category = self.categories[indexPath.row];
        if (category.users.count) {
            [self.userTableView reloadData];
        }else{
            //点击左侧分类按钮让右侧用户列表刷新否则会有问题
            [self.userTableView reloadData];
            [self.userTableView.mj_header beginRefreshing];
        }
    }
}

- (void)dealloc{
    
}

@end
