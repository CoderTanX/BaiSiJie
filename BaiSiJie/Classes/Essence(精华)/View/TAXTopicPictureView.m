//
//  TAXTopicPictureView.m
//  BaiSiJie
//
//  Created by 谭安溪 on 16/3/23.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

#import "TAXTopicPictureView.h"
#import "UIImageView+WebCache.h"
#import "TAXTopic.h"
@interface TAXTopicPictureView ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *gifImageView;
@property (weak, nonatomic) IBOutlet UIButton *seeBigImageBt;

@end
@implementation TAXTopicPictureView

+ (instancetype)pictureView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}

- (void)awakeFromNib{
    self.autoresizingMask = UIViewAutoresizingNone;
}

- (void)setTopic:(TAXTopic *)topic{
    _topic = topic;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.bigImage]];
    self.gifImageView.hidden = !topic.is_gif;
    if (topic.bigPicture) {
        self.seeBigImageBt.hidden = NO;
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    }else{
        self.seeBigImageBt.hidden = YES;
        self.imageView.contentMode = UIViewContentModeScaleToFill;
    }
    
}

@end
