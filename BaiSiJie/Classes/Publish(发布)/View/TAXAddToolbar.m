//
//  TAXAddToolbar.m
//  BaiSiJie
//
//  Created by 谭安溪 on 16/4/6.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

#import "TAXAddToolbar.h"

@interface TAXAddToolbar ()
@property (weak, nonatomic) IBOutlet TAXAddToolbar *topView;///<顶部视图
@property (nonatomic, strong) NSMutableArray *tagLabels; ///<tagLabel数组


@property (nonatomic, weak) UIButton *addButton; ///<添加按钮

@end
@implementation TAXAddToolbar


- (NSMutableArray *)tagLabels{
    
    if (!_tagLabels) {
        _tagLabels = [NSMutableArray array];
    }
    return _tagLabels;
}
- (void)awakeFromNib{
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addButton setImage:[UIImage imageNamed:@"tag_add_icon"] forState:UIControlStateNormal];
    [addButton sizeToFit];
    addButton.x = TAXTagMargin;
    addButton.y = TAXTagMargin;
    [addButton addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.topView addSubview:addButton];
    self.addButton = addButton;
}

- (void)addButtonClick{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(addToolbarAddTagButttonDidClicked:)]) {
        [self.delegate addToolbarAddTagButttonDidClicked:self];
    }
}

- (void)reloadTagLabels{
        [self.tagLabels makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self.tagLabels removeAllObjects];
        for (int i = 0; i<self.tags.count; i++) {
            UILabel *tagLabel = [[UILabel alloc] init];
            tagLabel.textAlignment = NSTextAlignmentCenter;
            tagLabel.backgroundColor = TAXRGBColor(74, 139, 209);
            tagLabel.textColor = [UIColor whiteColor];
            tagLabel.text = self.tags[i];
            [tagLabel sizeToFit];
            tagLabel.width += 2*TAXTagMargin;
            tagLabel.height = 25;
            [self.topView addSubview:tagLabel];
            [self.tagLabels addObject:tagLabel];
            if (i == 0) {
                tagLabel.x = TAXTagMargin;
                tagLabel.y = 0;
            }else{
                UILabel *previousTagLabel = self.tagLabels[i - 1];
                CGFloat leftW = TAXScreenW - CGRectGetMaxX(previousTagLabel.frame) - 2 * TAXTagMargin;
                if (leftW > tagLabel.width) {
                    tagLabel.x = CGRectGetMaxX(previousTagLabel.frame) + TAXTagMargin;
                    tagLabel.y = previousTagLabel.y;
                }else{
                    tagLabel.x = TAXTagMargin;
                    tagLabel.y = CGRectGetMaxY(previousTagLabel.frame) + TAXTagMargin;
                }
            }
        }
        UILabel *lastTagLabel = self.tagLabels.lastObject;
    
    if (lastTagLabel) {
        CGFloat leftW = TAXScreenW - CGRectGetMaxX(lastTagLabel.frame) - 2 * TAXTagMargin;
        if (leftW>self.addButton.width) {
            self.addButton.x = CGRectGetMaxX(lastTagLabel.frame) + TAXTagMargin;
            self.addButton.centerY = lastTagLabel.y + lastTagLabel.height * 0.5;
        }else{
            self.addButton.x = TAXTagMargin;
            self.addButton.centerY = CGRectGetMaxY(lastTagLabel.frame) + TAXTagMargin + lastTagLabel.height * 0.5;
        }
    }else{
        self.addButton.x = TAXTagMargin;
        self.addButton.y = TAXTagMargin;
    }
    CGFloat oldH = self.height;
    self.height = CGRectGetMaxY(self.addButton.frame) + 44 + TAXTagMargin;
    self.y += oldH - self.height;
}

- (void)setTags:(NSMutableArray *)tags{
    _tags = tags;
    [self reloadTagLabels];
}


@end
