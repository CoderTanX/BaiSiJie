//
//  TAXWebViewController.m
//  BaiSiJie
//
//  Created by 谭安溪 on 16/4/5.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

#import "TAXWebViewController.h"
#import "NJKWebViewProgress.h"
#import "NJKWebViewProgressView.h"
@interface TAXWebViewController ()<UIWebViewDelegate,NJKWebViewProgressDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic, weak) UIButton *backBt; ///<返回按钮
@property (nonatomic, weak) UIButton *closeBt; ///<关闭按钮

@end

@implementation TAXWebViewController
{
    NJKWebViewProgressView *_progressView;
    NJKWebViewProgress *_progressProxy;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    self.webView.delegate = self;
    [self setLeftBarButtonItems];
    _progressProxy = [[NJKWebViewProgress alloc] init]; // instance variable
    self.webView.delegate = _progressProxy;
    _progressProxy.webViewProxyDelegate = self;
    _progressProxy.progressDelegate = self;
    
    CGFloat progressBarHeight = 2.f;
    CGRect navigationBarBounds = self.navigationController.navigationBar.bounds;
    CGRect barFrame = CGRectMake(0, navigationBarBounds.size.height - progressBarHeight, navigationBarBounds.size.width, progressBarHeight);
    _progressView = [[NJKWebViewProgressView alloc] initWithFrame:barFrame];
    _progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
}

- (void)setLeftBarButtonItems{
    
    //创建返回按钮
    UIButton *backBt = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBt setTitle:@"返回" forState:UIControlStateNormal];
    [backBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [backBt setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [backBt setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
    [backBt setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
//    backBt.backgroundColor = [UIColor orangeColor];
    [backBt addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [backBt sizeToFit];
    backBt.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBt];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBt];
    self.backBt = backBt;
    //创建关闭按钮
    UIButton *closeBt = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBt setTitle:@"关闭" forState:UIControlStateNormal];
    [closeBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [closeBt setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [closeBt sizeToFit];
    [closeBt addTarget:self action:@selector(quit) forControlEvents:UIControlEventTouchUpInside];
    closeBt.hidden = YES;
    UIBarButtonItem *closeItem = [[UIBarButtonItem alloc] initWithCustomView:closeBt];
    self.navigationItem.leftBarButtonItems = @[backItem,closeItem];
    self.closeBt = closeBt;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar addSubview:_progressView];
    [_progressView setProgress:0. animated:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // Remove progress view
    // because UINavigationBar is shared with other ViewControllers
    [_progressView removeFromSuperview];
}
- (void)back{
    if ([self.webView canGoBack]) {
        [self.webView goBack];
        self.closeBt.hidden = NO;
    }else{
        [self.navigationController popViewControllerAnimated:YES];
        self.closeBt.hidden = YES;
    }
    
}

- (void)quit{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    if ([self.webView canGoBack]) {
        self.closeBt.hidden = NO;
    }else{
        self.closeBt.hidden = YES;
    }

}

-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    [_progressView setProgress:progress animated:YES];
}
@end
