//
//  TAXPostWordViewController.m
//  BaiSiJie
//
//  Created by 谭安溪 on 16/4/5.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

#import "TAXPostWordViewController.h"
#import "TAXPlaceholderTextView.h"
@interface TAXPostWordViewController ()
@property (nonatomic, weak) TAXPlaceholderTextView *textView; ///<<#注释#>
@end

@implementation TAXPostWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = TAXGlobalBg;
    //设置导航栏
    [self setupNav];
    //添加textView
    [self setupTextView];
}
/**
 *  设置导航栏
 */
- (void)setupNav{
    self.title = @"发表文字";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发表" style:UIBarButtonItemStyleDone target:self action:@selector(post)];
    
    self.navigationItem.rightBarButtonItem.enabled = NO; // 默认不能点击
    // 强制刷新
    [self.navigationController.navigationBar layoutIfNeeded];
}

- (void)setupTextView{
    TAXPlaceholderTextView *textView = [[TAXPlaceholderTextView alloc] init];
   
    textView.placeholder = @"把好玩的图片，好笑的段子或糗事发到这里，接受千万网友膜拜吧！发布违反国家法律内容的，我们将依法提交给有关部门处理。";
    textView.frame = self.view.bounds;
    textView.alwaysBounceVertical = YES;
    [self.view addSubview:textView];
    self.textView = textView;
}



- (void)cancel{
//    [self dismissViewControllerAnimated:YES completion:nil];
//    self.textView.text = @"天神下凡";
    self.textView.font = [UIFont systemFontOfSize:20];
}

- (void)post{
    TAXLogFunc;
}

@end
