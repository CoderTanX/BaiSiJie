//
//  TAXPublishView.m
//  BaiSiJie
//
//  Created by 谭安溪 on 16/3/24.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

#import "TAXPublishView.h"
#import "TAXVerticalButton.h"
#import "POP.h"
#import "TAXPostWordViewController.h"
#import "TAXNavigationController.h"
typedef void(^completion)();
@interface TAXPublishView ()
@property (nonatomic, weak) UIImageView *sloganView; ///<logo

@end

static CGFloat const AnimationDelay = 0.1;
static CGFloat const SpringFactor = 10;
@implementation TAXPublishView

static UIWindow * window_;

+ (void)show{
    
    window_ = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    window_.hidden = NO;
    window_.backgroundColor = [UIColor whiteColor];
    
    TAXPublishView *publishView = [self publicView];
    publishView.frame = window_.bounds;
    [window_ addSubview:publishView];
}


+(instancetype)publicView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
}

- (void)awakeFromNib{
    self.userInteractionEnabled = NO;
    //发布的按钮
    NSArray *images = @[@"publish-video", @"publish-picture", @"publish-text", @"publish-audio", @"publish-review", @"publish-offline"];
    NSArray *titles = @[@"发视频", @"发图片", @"发段子", @"发声音", @"审帖", @"离线下载"];
    int maxCols = 3;
    CGFloat buttonW = 72;
    CGFloat buttonH = buttonW + 30;
    CGFloat buttonStartX = 20;
    CGFloat buttonStartY = (TAXScreenH - buttonH*2)/2;
    //间距
    CGFloat margin = (TAXScreenW -  3 * buttonW - 2 * buttonStartX)/2;
    
    for (int i = 0; i<images.count; i++) {
        TAXVerticalButton *button = [TAXVerticalButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        button.tag = 10 +i;
        [button setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        CGFloat buttonX = buttonStartX + i%maxCols * (buttonW + margin);
        CGFloat buttonY = buttonStartY + buttonH * (i/maxCols);
        
        POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        anim.beginTime = CACurrentMediaTime() + AnimationDelay * i;
        anim.springSpeed = 10;
        anim.springBounciness = 10;
        //        [anim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
        //            if (i == images.count - 1) {
        //                self.sloganView.hidden = NO;
        //            }
        //        }];
        anim.fromValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonY - TAXScreenH, buttonW, buttonH)];
        anim.toValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonY, buttonW, buttonH)];
        [button pop_addAnimation:anim forKey:nil];
        
    }
    //logo
    UIImageView *sloganView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_slogan"]];
    [self addSubview:sloganView];
    sloganView.hidden = YES;
    self.sloganView = sloganView;
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    anim.beginTime = CACurrentMediaTime() + AnimationDelay * images.count;
    anim.springSpeed = SpringFactor;
    anim.springBounciness = SpringFactor;
    [anim setAnimationDidStartBlock:^(POPAnimation *anim) {
        sloganView.hidden = NO;
    }];
    [anim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
        self.userInteractionEnabled = YES;
    }];
    anim.fromValue = [NSValue valueWithCGPoint:CGPointMake(TAXScreenW * 0.5, -100)];
    anim.toValue = [NSValue valueWithCGPoint:CGPointMake(TAXScreenW * 0.5, TAXScreenH * 0.2)];
    [sloganView pop_addAnimation:anim forKey:nil];

}



- (void)buttonClick:(UIButton *)button{
    switch (button.tag - 10) {
        case 0:
            [self cancelClickWithCompletion:^{
                TAXLog(@"发视频");
            }];
            break;
        case 1:
            [self cancelClickWithCompletion:^{
                TAXLog(@"发图片");
            }];
            break;
        case 2:
            [self cancelClickWithCompletion:^{
                TAXPostWordViewController *postwordVc = [[TAXPostWordViewController alloc]init];
                TAXNavigationController *nav = [[TAXNavigationController alloc] initWithRootViewController:postwordVc];
                UIViewController *root = [UIApplication sharedApplication].keyWindow.rootViewController;
                [root presentViewController:nav animated:YES completion:nil];
            }];
            break;
        default:
            break;
    }
}

- (IBAction)cancelClick {
   
    [self cancelClickWithCompletion:nil];
}

- (void)cancelClickWithCompletion:(completion)completion{
    int index = 1;
    self.userInteractionEnabled = NO;
    for (int i = index; i<self.subviews.count; i++) {
        UIView *view = self.subviews[i];
        POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
        anim.toValue = [NSValue valueWithCGPoint:CGPointMake(view.centerX, view.centerY + TAXScreenH)];
        anim.beginTime = CACurrentMediaTime() + (i - index) * AnimationDelay;
        [view pop_addAnimation:anim forKey:nil];
        [anim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
            if (i == self.subviews.count - 1) {
                completion ? completion() : nil ;
                window_.hidden = YES;
                window_ = nil;
                
            }
        }];
    }

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self cancelClick];
    
}



@end
