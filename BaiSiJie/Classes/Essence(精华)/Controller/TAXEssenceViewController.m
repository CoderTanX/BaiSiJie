//
//  TAXEssenceViewController.m
//  BaiSiJie
//
//  Created by 谭安溪 on 16/3/6.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

#import "TAXEssenceViewController.h"
#import "TAXRecommendTagViewController.h"
#import "TAXAllViewController.h"
#import "TAXVideoViewController.h"
#import "TAXVoiceViewController.h"
#import "TAXPictureViewController.h"
#import "TAXWordViewController.h"
@interface TAXEssenceViewController ()<UIScrollViewDelegate>
@property (nonatomic, weak) UIButton *currentTitleBt; ///<当前别选中的bt
@property (nonatomic, weak) UIView *redLineView; ///<红的细线
@property (nonatomic, weak) UIScrollView *contentView; ///<底部的滚动视图
@property (nonatomic, weak) UIView *titleView; ///<分类的背景视图

@end

@implementation TAXEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航
    [self setupNav];
    
    //添加自控制器
    [self setupChildVc];
    
    //设置底部滚动视图
    [self setupContentView];
    
    //设置顶部分类
    [self setTitleView];

}

- (void)setupChildVc{
    
    TAXAllViewController *allVc = [[TAXAllViewController alloc] init];
    [self addChildViewController:allVc];
    
    TAXVideoViewController *videoVc = [[TAXVideoViewController alloc] init];
    [self addChildViewController:videoVc];
    
    TAXVoiceViewController *voiceVc = [[TAXVoiceViewController alloc] init];
    [self addChildViewController:voiceVc];
    
    TAXPictureViewController *pictureVc = [[TAXPictureViewController alloc] init];
    [self addChildViewController:pictureVc];
    
    TAXWordViewController *wordVc = [[TAXWordViewController alloc] init];
    [self addChildViewController:wordVc];
}

/**
 *  初始化底部的滚动视图
 */
- (void)setupContentView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIScrollView *contentView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    contentView.pagingEnabled = YES;
    contentView.delegate = self;
//    contentView.backgroundColor = [UIColor orangeColor];
    contentView.contentSize = CGSizeMake(contentView.width * self.childViewControllers.count, contentView.height);
    [self.view addSubview:contentView];
    self.contentView = contentView;
}


/**
 *  初始化分类视图
 */
- (void)setTitleView{
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, 40)];
    titleView.backgroundColor = [UIColor whiteColor];
    titleView.alpha = 0.8;
    [self.view addSubview:titleView];
    self.titleView = titleView;
    NSArray *titles = @[@"全部",@"视频视频",@"音频",@"图片",@"段子"];
    CGFloat titleBtW = titleView.width/titles.count;
    CGFloat titleBtH = titleView.height;
    for (int i = 0; i<titles.count; i++) {
        UIButton *titleBt = [UIButton buttonWithType:UIButtonTypeCustom];
        titleBt.tag = 10 + i;
        titleBt.frame = CGRectMake(titleBtW*i, 0, titleBtW, titleBtH);
        [titleBt setTitle:titles[i] forState:UIControlStateNormal];
        [titleBt setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [titleBt setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        titleBt.titleLabel.font = [UIFont systemFontOfSize:14];
        [titleBt addTarget:self action:@selector(titleBtClick:) forControlEvents:UIControlEventTouchUpInside];
        [titleView addSubview:titleBt];
        if (i == 0) {
            [self titleBtClick:titleBt];
            UIView *redLineView = [[UIView alloc] init];
            redLineView.width = [titles[i] sizeWithAttributes:@{NSFontAttributeName:titleBt.titleLabel.font}].width;
            redLineView.height = 2;
            redLineView.centerX = titleBt.centerX;
            redLineView.y = titleView.height - redLineView.height;
            redLineView.backgroundColor = [UIColor redColor];
            [titleView addSubview:redLineView];
            self.redLineView = redLineView;
        }
    }
    
}

- (void)titleBtClick:(UIButton *)titleBt{
    self.currentTitleBt.enabled = YES;
    titleBt.enabled = NO;
    self.currentTitleBt = titleBt;
    [UIView animateWithDuration:0.25 animations:^{
        self.redLineView.width = titleBt.titleLabel.width;
        self.redLineView.centerX = titleBt.centerX;
    }];
    NSInteger i = titleBt.tag - 10;
    UITableViewController *vc = self.childViewControllers[i];
    vc.tableView.x = self.contentView.width * i;
    vc.tableView.y = 0;
    vc.tableView.width = self.contentView.width;
    vc.tableView.height = self.contentView.height;
    CGFloat top = CGRectGetMaxY(self.titleView.frame);
    vc.tableView.contentInset = UIEdgeInsetsMake(top, 0, 49, 0);
    vc.tableView.scrollIndicatorInsets = vc.tableView.contentInset;
    [self.contentView addSubview:vc.tableView];
    [self.contentView setContentOffset:CGPointMake(self.contentView.width * i, 0) animated:YES];
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger i = scrollView.contentOffset.x/scrollView.width;
    UIButton *bt = (UIButton *)[self.titleView viewWithTag:(i + 10)];
    [self titleBtClick:bt];
}

- (void)tagClick{
    TAXRecommendTagViewController *rtVC = [[TAXRecommendTagViewController alloc] initWithStyle:UITableViewStylePlain];
    [self.navigationController pushViewController:rtVC animated:YES];
}
/**
 *  初始化导航
 */
- (void)setupNav{
    self.view.backgroundColor = TAXGlobalBg;
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    //设置左边的itembutton
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highlightImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
}




@end
