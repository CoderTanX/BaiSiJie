//
//  TAXTagButton.m
//  BaiSiJie
//
//  Created by 谭安溪 on 16/4/7.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

#import "TAXTagButton.h"

@implementation TAXTagButton

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = TAXRGBColor(74, 139, 209);
        [self setImage:[UIImage imageNamed:@"chose_tag_close_icon"] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return self;
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state{
    [super setTitle:title forState:state];
    [self sizeToFit];
    if (self.width > TAXScreenW - 2*TAXTagMargin) {
        self.width = TAXScreenW - 2*TAXTagMargin;
    }else{
        self.width += 3 * TAXTagMargin;
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.titleLabel.x = TAXTagMargin;
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame) + TAXTagMargin;
}
@end
