//
//  TAXCommentViewController.m
//  BaiSiJie
//
//  Created by 谭安溪 on 16/3/30.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

#import "TAXCommentViewController.h"
#import "TAXTopicCell.h"
#import "TAXTopic.h"
#import "MJRefresh.h"
#import "AFNetworking.h"
#import "GGNetworking.h"
#import "TAXComment.h"
#import "TAXUser.h"
#import "MJExtension.h"
#import "TAXCommentCell.h"
@interface TAXCommentViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSpace;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *hotComments; ///<热门评论
@property (nonatomic, strong) NSMutableArray *latestComment; ///<最新评论
@property (nonatomic, strong) TAXComment *saved_top_cmt; ///<用来保存热门评论
@property (nonatomic, assign) NSInteger page; ///<页数
@property (nonatomic, strong) AFHTTPSessionManager *manager; ///<管理者
@end

static NSString *const TAXCommentID = @"comment";
@implementation TAXCommentViewController

- (AFHTTPSessionManager *)manager{
    
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"评论";
    [TAXNoteCenter addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    self.tableView.backgroundColor = TAXGlobalBg;
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TAXCommentCell class]) bundle:nil] forCellReuseIdentifier:TAXCommentID];
//    self.tableView.estimatedRowHeight = 44;
//    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, TAXTopicCellMargin, 0);
    [self setupHeaderView];
    [self setupRefresh];
}

- (void)setupRefresh{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewComments)];
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreComments)];
}

- (void)loadNewComments{
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.ID;
    params[@"hot"] = @"1";
    
    [self.manager GET:SERVICE_URL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self.tableView.mj_header endRefreshing];
        self.hotComments = [TAXComment mj_objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        self.latestComment = [TAXComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [self.tableView reloadData];
        NSInteger total = [responseObject[@"total"] integerValue];
        if (self.latestComment.count >= total) {
            self.tableView.mj_footer.hidden = YES;
        }else{
            [self.tableView.mj_footer endRefreshing];
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         [self.tableView.mj_header endRefreshing];
    }];
}


- (void)loadMoreComments{
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.ID;
    params[@"page"] = @(self.page++);
    TAXComment *cmt = [self.latestComment lastObject];
    params[@"lastcid"] = cmt.ID;
    
    [self.manager GET:SERVICE_URL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *newComment = [TAXComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [self.latestComment addObjectsFromArray:newComment];
        [self.tableView reloadData];
        
        NSInteger total = [responseObject[@"total"] integerValue];
        if (self.latestComment.count >= total) {
            self.tableView.mj_footer.hidden = YES;
        }else{
            [self.tableView.mj_footer endRefreshing];
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        self.page --;
        [self.tableView.mj_footer endRefreshing];
    }];
}


- (void)setupHeaderView{
    
    TAXTopicCell *headerView = [TAXTopicCell viewFromXib];
    if (self.topic.top_cmt) {
        self.saved_top_cmt = self.topic.top_cmt;
        self.topic.top_cmt = nil;
        [self.topic setValue:@0 forKeyPath:@"topicCellH"];
    }
    headerView.topic = self.topic;
    headerView.frame = CGRectMake(0, 0, TAXScreenW, self.topic.topicCellH);
    UIView *view = [[UIView alloc] init];
    view.height = self.topic.topicCellH + 10;
    [view addSubview:headerView];
    self.tableView.tableHeaderView = view;
}

- (NSArray *)commentsWithSection:(NSInteger)section{
    NSInteger hotCount = self.hotComments.count;
    if (section == 0) {
        return hotCount?self.hotComments:self.latestComment;
    }
    return self.latestComment;
}

- (TAXComment *)commentsWithIndexPath:(NSIndexPath *)indexPath{
    return [self commentsWithSection:indexPath.section][indexPath.row];
}


#pragma mark - <UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    NSInteger hotCount = self.hotComments.count;
    NSInteger latestCount = self.latestComment.count;
    tableView.mj_footer.hidden = (latestCount == 0);
    if (hotCount) return 2;
    if (latestCount)return 1;
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSInteger hotCount = self.hotComments.count;
    NSInteger latestCount = self.latestComment.count;
    if (section == 0) {
        return hotCount?hotCount:latestCount;
    }
    return latestCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TAXCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:TAXCommentID];
    TAXComment *comment = [self commentsWithIndexPath:indexPath];
    cell.comment = comment;
    return cell;
}
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    
//    UILabel *titleLabel = [[UILabel alloc] init];
//    titleLabel.backgroundColor = TAXGlobalBg;
//    
//    if (section == 0) {
//        return self.hotComments.count?@"最热评论":@"最新评论";
//    }
//    return @"最新评论";
//}

/*
 - (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = TAXGlobalBg;
    UILabel *titleLabel = [[UILabel alloc] init];
//    titleLabel.backgroundColor = TAXGlobalBg;
    titleLabel.textColor = [UIColor grayColor];
    titleLabel.width = 200;
    titleLabel.x = TAXTopicCellMargin;
    titleLabel.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [view addSubview:titleLabel];
    if (section == 0) {
        titleLabel.text = self.hotComments.count?@"最热评论":@"最新评论";
    }else{
        titleLabel.text = @"最新评论";
    }
    return view;
}
*/

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    static NSString *ID = @"header";
    UITableViewHeaderFooterView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    if (!header) {
        header = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:ID];
        header.contentView.backgroundColor = TAXGlobalBg;
        header.textLabel.textColor = [UIColor grayColor];
    }
    if (section == 0) {
       header.textLabel.text = self.hotComments.count?@"最热评论":@"最新评论";
    }else{
         header.textLabel.text = @"最新评论";
    }
    return header;
}
    



#pragma mark - <UITableViewDelegate>
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
    [[UIMenuController sharedMenuController] setMenuVisible:NO animated:YES];
}



- (void)keyboardWillChangeFrame:(NSNotification *)note{
    CGRect keyboardFrame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.bottomSpace.constant = TAXScreenH - keyboardFrame.origin.y;
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    TAXComment *comment = [self commentsWithIndexPath:indexPath];
    return comment.commentCellH;
}

- (void)dealloc{
    [TAXNoteCenter removeObserver:self];
    if (self.saved_top_cmt) {
        self.topic.top_cmt = self.saved_top_cmt;
        [self.topic setValue:@0 forKeyPath:@"topicCellH"];
    }
    [self.manager invalidateSessionCancelingTasks:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UIMenuController *menuVc = [UIMenuController sharedMenuController];
    if (menuVc.isMenuVisible) {
        [menuVc setMenuVisible:NO animated:YES];
    }else{
        TAXCommentCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        [cell becomeFirstResponder];
        UIMenuItem *ding = [[UIMenuItem alloc] initWithTitle:@"顶" action:@selector(ding:)];
        UIMenuItem *reply = [[UIMenuItem alloc] initWithTitle:@"回复" action:@selector(reply:)];
        UIMenuItem *report = [[UIMenuItem alloc] initWithTitle:@"举报" action:@selector(report:)];
        menuVc.menuItems = @[ding,reply,report];
        CGRect rect = CGRectMake(0, cell.height * 0.5, cell.width, cell.height * 0.5);
        [menuVc setTargetRect:rect inView:cell];
        [menuVc setMenuVisible:YES animated:YES];
    }
    
}

- (void)ding:(UIMenuController *)menuVc{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    TAXLog(@"%@",[self commentsWithIndexPath:indexPath].content);
}

- (void)reply:(UIMenuController *)menuVc{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    TAXLog(@"%@",[self commentsWithIndexPath:indexPath].content);
}

- (void)report:(UIMenuController *)menuVc{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    TAXLog(@"%@",[self commentsWithIndexPath:indexPath].content);
}

@end
