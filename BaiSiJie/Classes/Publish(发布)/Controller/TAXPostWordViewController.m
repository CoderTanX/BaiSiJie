//
//  TAXPostWordViewController.m
//  BaiSiJie
//
//  Created by 谭安溪 on 16/4/5.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

#import "TAXPostWordViewController.h"
#import "TAXPlaceholderTextView.h"
#import "TAXAddToolbar.h"
#import "TAXAddTagViewController.h"
@interface TAXPostWordViewController ()<TAXAddToolbarDelegate>
@property (nonatomic, weak) TAXPlaceholderTextView *textView;
@property (nonatomic, weak) TAXAddToolbar *addToolbar; ///<底部的工具栏
@property (nonatomic, strong) NSMutableArray *tags; ///<标签数组
@end

@implementation TAXPostWordViewController

- (NSMutableArray *)tags{
    
    if (!_tags) {
        _tags = [NSMutableArray arrayWithObjects:@"吐槽",@"搞笑搞笑搞笑搞笑",@"搞笑搞笑搞",@"搞笑搞笑搞笑", nil];
    }
    return _tags;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = TAXGlobalBg;
    //设置导航栏
    [self setupNav];
    //添加textView
    [self setupTextView];
    //添加底部工具栏
    [self setupAddToolbar];
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

- (void)setupAddToolbar{
    TAXAddToolbar *addToolbar = [TAXAddToolbar viewFromXib];
    
    addToolbar.delegate = self;
    addToolbar.width = TAXScreenW;
    addToolbar.y = TAXScreenH - addToolbar.height;
    [self.view addSubview:addToolbar];
    self.addToolbar = addToolbar;
    [TAXNoteCenter addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)addToolbarAddTagButttonDidClicked:(TAXAddToolbar *)addToolbar{
    TAXAddTagViewController *addTagVc = [[TAXAddTagViewController alloc] init];
    addTagVc.tags = self.tags;
    [self.navigationController pushViewController:addTagVc animated:YES];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.textView becomeFirstResponder];
    
}

- (void)viewWillAppear:(BOOL)animated{
    self.addToolbar.tags = self.tags;
}
- (void)keyboardWillChangeFrame:(NSNotification *)note{
//    NSLog(@"%@",note.userInfo);7
    
    self.addToolbar.transform = CGAffineTransformMakeTranslation(0, [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].origin.y - TAXScreenH);
}

- (void)cancel{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)post{
    TAXLogFunc;
}

@end
