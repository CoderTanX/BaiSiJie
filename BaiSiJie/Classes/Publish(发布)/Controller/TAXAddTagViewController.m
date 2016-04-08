//
//  TAXAddTagViewController.m
//  BaiSiJie
//
//  Created by 谭安溪 on 16/4/7.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

#import "TAXAddTagViewController.h"
#import "TAXTagButton.h"
#import "TAXTagTextField.h"
#import "SVProgressHUD.h"
@interface TAXAddTagViewController ()<UITextFieldDelegate>
@property (nonatomic, weak) UIView *contentView; ///<底部的contentView
@property (nonatomic, weak) TAXTagTextField *textField; ///<输入框
@property (nonatomic, weak) UIButton *addTagButton; ///<添加标签
@property (nonatomic, strong) NSMutableArray *tagButtons; ///<标签数组
@property (nonatomic, strong) NSMutableArray *save_tags; ///<保存tags
@end

@implementation TAXAddTagViewController

- (NSMutableArray *)save_tags{
    
    if (!_save_tags) {
        _save_tags = [NSMutableArray array];
    }
    return _save_tags;
}

- (NSMutableArray *)tagButtons{
    
    if (!_tagButtons) {
        _tagButtons = [NSMutableArray array];
    }
    return _tagButtons;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    //设置nav
    [self setupNav];
    //设置内容contentView
    [self setupContentView];
    //设置textField
    [self setupTextField];
    //设置添加标签按钮
    [self setupAddTagButton];
//    [TAXNoteCenter addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:nil];
    for (NSString *tagText in self.tags) {
        self.textField.text = tagText;
        [self addTagButtonClick];
    }
}

- (void)textChange{
//    TAXLogFunc;
    if (self.textField.hasText) {
        self.addTagButton.hidden = NO;
        [self.addTagButton setTitle:[NSString stringWithFormat:@"添加标签：%@",self.textField.text] forState:UIControlStateNormal];
        NSString *lastLetter = [self.textField.text substringFromIndex:self.textField.text.length - 1];
        if ([lastLetter isEqualToString:@","]||[lastLetter isEqualToString:@"，"]) {
            self.textField.text = [self.textField.text substringToIndex:self.textField.text.length - 1];
            [self addTagButtonClick];
        }
        
    }else{
        self.addTagButton.hidden = YES;
    }
}


/**
 *设置添加标签按钮
; */
- (void)setupAddTagButton{
    UIButton *addTagButton = [UIButton buttonWithType:UIButtonTypeCustom];
    addTagButton.width = self.contentView.width;
    addTagButton.height = 35;
    addTagButton.y = CGRectGetMaxY(self.textField.frame);
    addTagButton.backgroundColor = TAXRGBColor(74, 139, 209);
    addTagButton.titleLabel.font = [UIFont systemFontOfSize:14];
    addTagButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    addTagButton.contentEdgeInsets = UIEdgeInsetsMake(0, TAXTagMargin, 0, TAXTagMargin);
    addTagButton.hidden = YES;
    [addTagButton addTarget:self action:@selector(addTagButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:addTagButton];
    self.addTagButton = addTagButton;
}
/**
 *  点击了添加按钮
 */
- (void)addTagButtonClick{
    if (self.tagButtons.count >= 5) {
        [SVProgressHUD showErrorWithStatus:@"最多添加5个标签"];
        self.addTagButton.hidden = YES;
        return;
    }
    TAXTagButton *tagButton = [TAXTagButton buttonWithType:UIButtonTypeCustom];
    [tagButton setTitle:self.textField.text forState:UIControlStateNormal];
    tagButton.height = self.textField.height;
    [tagButton addTarget:self action:@selector(tagButtonsClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:tagButton];
    [self.tagButtons addObject:tagButton];
    [self.save_tags addObject:self.textField.text];
    [self updateTagButtonFrame];
    self.textField.text = nil;
    self.addTagButton.hidden = YES;
}

- (void)tagButtonsClick:(TAXTagButton *)tagButton{
    [tagButton removeFromSuperview];
    [self.tagButtons removeObject:tagButton];
    NSLog(@"%@",tagButton.currentTitle);
    [self.save_tags removeObject:tagButton.currentTitle];
    [UIView animateWithDuration:0.25 animations:^{
        [self updateTagButtonFrame];
    }];
    
}



/**
 *  更新标签按钮的frame
 */
- (void)updateTagButtonFrame{
    
    for (int i = 0; i<self.tagButtons.count;i++) {
        TAXTagButton *tagButton = self.tagButtons[i];
        if (i == 0) {
            tagButton.x = 0;
            tagButton.y = 0;
        }else{
            TAXTagButton *previousTagButton = self.tagButtons[i - 1];
            //剩下的长度
            CGFloat leftW = self.contentView.width -  CGRectGetMaxX(previousTagButton.frame) - TAXTagMargin;
            if (leftW > tagButton.width) {
                tagButton.x = CGRectGetMaxX(previousTagButton.frame) + TAXTagMargin;
                tagButton.y = previousTagButton.y;
            }else{
                tagButton.x = 0;
                tagButton.y = CGRectGetMaxY(previousTagButton.frame) + TAXTagMargin;
            }
        }
    }
    TAXTagButton *lastButton = [self.tagButtons lastObject];
    CGFloat leftW = self.contentView.width -  CGRectGetMaxX(lastButton.frame) - TAXTagMargin;
    
    if (leftW > [self textFieldTextWidth]) {
        self.textField.y = lastButton.y;
        self.textField.x = CGRectGetMaxX(lastButton.frame) + TAXTagMargin;
    }else{
        self.textField.x = 0;
        self.textField.y = CGRectGetMaxY(lastButton.frame) + TAXTagMargin;
    }
    
    
    self.addTagButton.y = CGRectGetMaxY(self.textField.frame) + TAXTagMargin;
}


/**
 *  设置textField
 */
- (void)setupTextField{
    TAXTagTextField *textField = [[TAXTagTextField alloc] init];
    __weak typeof(self) weakSelf = self;
    textField.deleteBlock = ^(){
        if (!weakSelf.textField.hasText) {
            TAXTagButton *lastButton = weakSelf.tagButtons.lastObject;
            [weakSelf tagButtonsClick:lastButton];
        }
    };
    textField.width = self.contentView.width;
    textField.height = 25;
//    textField.backgroundColor = [UIColor orangeColor];
    textField.placeholder = @"多个标签用逗号或换行隔开";
    [textField addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
    [textField becomeFirstResponder];
    textField.delegate =self;
    [self.contentView addSubview:textField];
    self.textField = textField;
    
}
/**
 *  设置内容contentView
 */
- (void)setupContentView{
    UIView *contentView = [[UIView alloc] init];
    contentView.x = TAXTagMargin;
    contentView.width = TAXScreenW - 2 * TAXTagMargin;
    contentView.y = 64 + TAXTagMargin;
    contentView.height = TAXScreenH - contentView.y - TAXTagMargin;
//    contentView.backgroundColor = [UIColor redColor];
    [self.view addSubview:contentView];
    self.contentView = contentView;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (self.textField.hasText) {
        [self addTagButtonClick];
    }
    return YES;
}
/**
 *  设置nav
 */
- (void)setupNav{
    self.title = @"添加标签";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(complete)];
}

- (void)complete{
    [self.tags removeAllObjects];
    [self.tags addObjectsFromArray:self.save_tags];
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 * textField的文字宽度
 */
- (CGFloat)textFieldTextWidth
{
    CGFloat textW = [self.textField.text sizeWithAttributes:@{NSFontAttributeName : self.textField.font}].width;
    return MAX(100, textW);
}


@end
