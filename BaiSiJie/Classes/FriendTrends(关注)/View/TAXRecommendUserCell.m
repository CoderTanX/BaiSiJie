//
//  TAXRecommendUserCell.m
//  BaiSiJie
//
//  Created by 谭安溪 on 16/3/9.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

#import "TAXRecommendUserCell.h"
#import "TAXRecommendUser.h"
#import "UIImageView+WebCache.h"
@interface TAXRecommendUserCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *fansCountLabel;

@end
@implementation TAXRecommendUserCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setUser:(TAXRecommendUser *)user{
    _user = user;
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:user.header] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.usernameLabel.text = user.screen_name;
    NSString *fans = nil;
    if ([user.fans_count integerValue]>10000) {
        fans = [NSString stringWithFormat:@"%.1f万人订阅",[user.fans_count integerValue]/10000.];
    }else{
        fans = [NSString stringWithFormat:@"%@人订阅",user.fans_count];
    }

    self.fansCountLabel.text = fans;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
