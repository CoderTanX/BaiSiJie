//
//  TAXTopicVideoView.m
//  BaiSiJie
//
//  Created by 谭安溪 on 16/3/28.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

#import "TAXTopicVideoView.h"
#import "UIImageView+WebCache.h"
#import "TAXTopic.h"

@interface TAXTopicVideoView ()
@property (weak, nonatomic) IBOutlet UILabel *playcountLabel;
@property (weak, nonatomic) IBOutlet UILabel *videotimeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end
@implementation TAXTopicVideoView

+ (instancetype)videoView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}

- (void)awakeFromNib{
    self.autoresizingMask = UIViewAutoresizingNone;
}

- (void)setTopic:(TAXTopic *)topic{
    _topic = topic;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.bigImage]];
    self.playcountLabel.text = [NSString stringWithFormat:@"%@播放",topic.playcount];
    NSInteger minute = topic.videotime/60;
    NSInteger second = topic.videotime%60;
    self.videotimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd",minute,second];
}

@end
