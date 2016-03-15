//
//  TAXRecommendCategoryCell.m
//  BaiSiJie
//
//  Created by 谭安溪 on 16/3/8.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

#import "TAXRecommendCategoryCell.h"
#import "TAXRecommendCategory.h"

@interface TAXRecommendCategoryCell ()
@property (weak, nonatomic) IBOutlet UIView *bottomLine;
@property (weak, nonatomic) IBOutlet UIView *leftRedLine;

@end
@implementation TAXRecommendCategoryCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setRecommendCategory:(TAXRecommendCategory *)recommendCategory{
    _recommendCategory = recommendCategory;
    self.textLabel.text = recommendCategory.name;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    self.textLabel.y = 1;
    self.textLabel.height = self.contentView.height - 2 * self.textLabel.y;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.leftRedLine.hidden = !selected;
    self.textLabel.textColor = selected?[UIColor redColor]:[UIColor blackColor];
}

@end
