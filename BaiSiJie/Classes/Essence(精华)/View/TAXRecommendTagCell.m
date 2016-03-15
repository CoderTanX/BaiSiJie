//
//  TAXRecommendTagCell.m
//  BaiSiJie
//
//  Created by 谭安溪 on 16/3/14.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

#import "TAXRecommendTagCell.h"
#import "TAXRecommendTag.h"
#import "UIImageView+WebCache.h"
@interface TAXRecommendTagCell ()
@property (weak, nonatomic) IBOutlet UIImageView *image_listImageVIew;
@property (weak, nonatomic) IBOutlet UILabel *theme_nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *sub_numberLabel;

@end
@implementation TAXRecommendTagCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setRecommendTag:(TAXRecommendTag *)recommendTag{
    _recommendTag = recommendTag;
    [self.image_listImageVIew sd_setImageWithURL:[NSURL URLWithString:recommendTag.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.theme_nameLabel.text = recommendTag.theme_name;
    
    NSString *subscribe = nil;
    if ([recommendTag.sub_number integerValue]>10000) {
        subscribe = [NSString stringWithFormat:@"%.1f万人订阅",[recommendTag.sub_number integerValue]/10000.];
    }else{
        subscribe = [NSString stringWithFormat:@"%@人订阅",recommendTag.sub_number];
    }
    self.sub_numberLabel.text = subscribe;
    
}

- (void)setFrame:(CGRect)frame{
    frame.origin.x = 5;
    frame.size.width -= 2 * frame.origin.x;
    frame.size.height -= 1;
    [super setFrame:frame];
}


@end
