//
//  TAXMeCell.m
//  BaiSiJie
//
//  Created by 谭安溪 on 16/4/5.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

#import "TAXMeCell.h"

@implementation TAXMeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.textLabel.textColor = [UIColor darkGrayColor];
        self.textLabel.font = [UIFont systemFontOfSize:15];
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    if (!self.imageView.image) return;
    self.imageView.width = 30;
    self.imageView.height = self.imageView.width;
    self.imageView.centerY = self.contentView.height * 0.5;
    self.textLabel.x = CGRectGetMaxX(self.imageView.frame) + TAXTopicCellMargin;
}


@end
