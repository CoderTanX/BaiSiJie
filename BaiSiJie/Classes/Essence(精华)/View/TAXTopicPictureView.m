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
#import "DALabeledCircularProgressView.h"
#import "TAXShowPictureViewController.h"
@interface TAXTopicPictureView ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *gifImageView;
@property (weak, nonatomic) IBOutlet UIButton *seeBigImageBt;
@property (weak, nonatomic) IBOutlet DALabeledCircularProgressView *progressView;


@end
@implementation TAXTopicPictureView

+ (instancetype)pictureView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
    
}

- (void)awakeFromNib{
    self.autoresizingMask = UIViewAutoresizingNone;
    self.progressView.roundedCorners = 5;
    self.progressView.progressLabel.textColor = [UIColor whiteColor];
    
    //打开imageView的交互
    self.imageView.userInteractionEnabled = YES;
    //给图片添加手势
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPicture)]];
}

- (IBAction)showPicture{
    TAXShowPictureViewController *showPictureVc = [[TAXShowPictureViewController alloc] init];
    showPictureVc.topic = self.topic;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:showPictureVc animated:YES completion:nil];
}


- (void)setTopic:(TAXTopic *)topic{
    _topic = topic;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.bigImage] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        self.progressView.hidden = NO;
    
        CGFloat progress = 1.0 * receivedSize/expectedSize;
        [self.progressView setProgress:progress animated:NO];
        
        self.progressView.progressLabel.text = [NSString stringWithFormat:@"%d%%",(int)(progress * 100)];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
    }];
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
