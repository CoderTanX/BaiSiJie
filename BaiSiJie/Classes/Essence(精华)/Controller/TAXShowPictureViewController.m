//
//  TAXShowPictureViewController.m
//  BaiSiJie
//
//  Created by 谭安溪 on 16/3/24.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

#import "TAXShowPictureViewController.h"
#import "TAXTopic.h"
#import "UIImageView+WebCache.h"
#import "SVProgressHUD.h"
#import "DALabeledCircularProgressView.h"
@interface TAXShowPictureViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *imageView; ///<图片
@property (weak, nonatomic) IBOutlet  DALabeledCircularProgressView*progressView;

@end

@implementation TAXShowPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *imageView = [[UIImageView alloc] init];
    [self.scrollView addSubview:imageView];
    self.imageView = imageView;
    self.progressView.progressLabel.textColor = [UIColor whiteColor];
    self.progressView.roundedCorners = 5;
    //添加点击手势
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backClick)]];
    [self.progressView setProgress:self.topic.pictureProgress animated:YES];
    self.progressView.progressLabel.text = [NSString stringWithFormat:@"%d%%",(int)(self.topic.pictureProgress * 100)];
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.bigImage] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        CGFloat process = 1.0 * receivedSize/expectedSize;
        [self.progressView setProgress:process animated:YES];
        self.progressView.progressLabel.text = [NSString stringWithFormat:@"%d%%",(int)(process * 100)];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
    }];
    
    //计算picture的frame
    CGFloat pictureW = TAXScreenW;
    CGFloat pictureH = self.topic.height * pictureW/self.topic.width;
    self.imageView.frame = CGRectMake(0, 0, pictureW, pictureH);
    if(pictureH > TAXScreenH){
        self.scrollView.contentSize = CGSizeMake(0, pictureH);
    }else{
        self.imageView.centerY = TAXScreenH * 0.5;
    }
    
    
    
}
- (IBAction)backClick {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)saveClcik {
    //保存到相册
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    if (error) {
         [SVProgressHUD showErrorWithStatus:@"保存失败"];
    }else{
         [SVProgressHUD showSuccessWithStatus:@"保存成功"];
    }
   
}

@end
