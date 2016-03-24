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
@interface TAXShowPictureViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *imageView; ///<图片
@end

@implementation TAXShowPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *imageView = [[UIImageView alloc] init];
    [self.scrollView addSubview:imageView];
    self.imageView = imageView;
    //添加点击手势
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backClick)]];

    [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.bigImage]];
    
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
