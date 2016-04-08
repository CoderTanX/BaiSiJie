//
//  TAXTopicVoiceView.m
//  BaiSiJie
//
//  Created by 谭安溪 on 16/3/28.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

#import "TAXTopicVoiceView.h"
#import "UIImageView+WebCache.h"
#import "TAXTopic.h"
@interface TAXTopicVoiceView ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *playcountLabel;
@property (weak, nonatomic) IBOutlet UILabel *voicetimeLabel;

@end
@implementation TAXTopicVoiceView



- (void)awakeFromNib{
    self.autoresizingMask = UIViewAutoresizingNone;
}

- (void)setTopic:(TAXTopic *)topic{
    _topic = topic;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.bigImage]];
    self.playcountLabel.text = [NSString stringWithFormat:@"%@播放",topic.playcount];
    NSInteger minute = topic.voicetime/60;
    NSInteger second = topic.voicetime%60;
    self.voicetimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd",minute,second];
}

@end
