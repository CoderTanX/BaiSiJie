//
//  TAXPlaceholderTextView.m
//  BaiSiJie
//
//  Created by 谭安溪 on 16/4/6.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

#import "TAXPlaceholderTextView.h"

@interface TAXPlaceholderTextView ()
@property (nonatomic, weak) UILabel *placeholderLabel;
@end

@implementation TAXPlaceholderTextView

- (UILabel *)placeholderLabel{
    
    if (!_placeholderLabel) {
        UILabel *placeholderLabel = [[UILabel alloc] init];
        placeholderLabel.x = 6;
        placeholderLabel.y = 7;
        [self addSubview:placeholderLabel];
        _placeholderLabel = placeholderLabel;
    }
    return _placeholderLabel;
}


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.placeholderLabel.numberOfLines = 0;
        self.placeholderLabel.textColor = [UIColor grayColor];
        self.font = [UIFont systemFontOfSize:15];
        [TAXNoteCenter addObserver:self selector:@selector(textchange) name:UITextViewTextDidChangeNotification object:nil];
    }
    return self;
}

/**
 *  监听placeholderLabel内容的改变
 */
- (void)textchange{
    self.placeholderLabel.hidden = self.hasText;
}
/**
 *  更新placeholderLabel的大小
 */
- (void)updatePlaceholderLabelSize{
    CGSize maxSize = [self.placeholder boundingRectWithSize:CGSizeMake(TAXScreenW - 2 * self.placeholderLabel.x, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.font} context:nil].size;
    self.placeholderLabel.size = maxSize;
}

//重写set方法

- (void)setPlaceholderColor:(UIColor *)placeholderColor{
    _placeholderColor = placeholderColor;
    self.placeholderLabel.textColor = placeholderColor;
}

- (void)setPlaceholder:(NSString *)placeholder{
    _placeholder = [placeholder copy];
    self.placeholderLabel.text = placeholder;
    [self updatePlaceholderLabelSize];
}

- (void)setText:(NSString *)text{
    [super setText:text];
    [self textchange];
}

- (void)setAttributedText:(NSAttributedString *)attributedText{
    [super setAttributedText:attributedText];
    [self textchange];
}

- (void)setFont:(UIFont *)font{
    [super setFont:font];
    self.placeholderLabel.font = font;
    [self updatePlaceholderLabelSize];
}


- (void)dealloc{
    [TAXNoteCenter removeObserver:self];
}

@end
