//
//  TAXTopicCell.m
//  BaiSiJie
//
//  Created by 谭安溪 on 16/3/18.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

#import "TAXTopicCell.h"
#import "TAXTopic.h"
#import "UIImageView+WebCache.h"
#import "NSDate+TAXAdditions.h"
#import "TAXTopicPictureView.h"
@interface TAXTopicCell ()
@property (weak, nonatomic) IBOutlet UIImageView *profile_imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *create_timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *dingBt;
@property (weak, nonatomic) IBOutlet UIButton *caiBt;
@property (weak, nonatomic) IBOutlet UIButton *repostBt;
@property (weak, nonatomic) IBOutlet UIButton *commentBt;
@property (weak, nonatomic) IBOutlet UILabel *text_label;
@property (nonatomic, weak) TAXTopicPictureView *pirtureVIew; ///<中间的图片
@end
@implementation TAXTopicCell

- (TAXTopicPictureView *)pirtureVIew{
    
    if (!_pirtureVIew) {
        TAXTopicPictureView *pirtureView = [TAXTopicPictureView pictureView];
        [self.contentView addSubview:pirtureView];
        _pirtureVIew = pirtureView;
    }
    return _pirtureVIew;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setTopic:(TAXTopic *)topic{
    _topic = topic;
    [self.profile_imageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.nameLabel.text = topic.name;
    self.create_timeLabel.text = topic.create_time;
    
    [self setupButtonTitle:self.dingBt count:topic.ding placeholder:@"顶"];
    [self setupButtonTitle:self.caiBt count:topic.cai placeholder:@"踩"];
    [self setupButtonTitle:self.repostBt count:topic.repost placeholder:@"分享"];
    [self setupButtonTitle:self.commentBt count:topic.comment placeholder:@"评论"];
    self.text_label.text = topic.text;
    
    if (topic.type == TAXTopicTypePicture) {
        self.pirtureVIew.frame = topic.pictureF;
        self.pirtureVIew.topic = topic;
        self.pirtureVIew.hidden = NO;
    }else{
        self.pirtureVIew.hidden = YES;
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
//    self.autoresizingMask = UIViewAutoresizingNone;
}

- (void)testDate:(NSString*)create_time{
    NSDate *date = [NSDate date];
    NSDateFormatter *fm = [[NSDateFormatter alloc]init];
    fm.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *create = [fm dateFromString:create_time];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond;
//    NSDateComponents *comps = [calendar components:unit fromDate:date];
//    TAXLog(@"%zd,%zd,%zd,%zd,%zd,%zd",comps.year,comps.month,comps.day,comps.hour,comps.minute,comps.second);
    NSDateComponents * comps = [calendar components:unit fromDate:create toDate:date options:0];
    TAXLog(@"%@",comps);
}


- (void)setupButtonTitle:(UIButton *)button count:(NSString *)count placeholder:(NSString *)placeholder{

    if ([count integerValue] > 10000) {
        count = [NSString stringWithFormat:@"%.1f万",[count integerValue]/10000.];
    }else if([count integerValue] == 0){
        count = placeholder;
    }
    [button setTitle:count forState:UIControlStateNormal];
    
}


- (void)setFrame:(CGRect)frame{
    frame.origin.x = TAXTopicCellMargin;
    frame.size.width -= 2 * TAXTopicCellMargin;
    frame.size.height -= TAXTopicCellMargin;
    frame.origin.y += TAXTopicCellMargin;;
    [super setFrame:frame];
}


@end
