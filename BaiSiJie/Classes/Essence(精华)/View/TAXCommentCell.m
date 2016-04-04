//
//  TAXCommentCell.m
//  BaiSiJie
//
//  Created by 谭安溪 on 16/3/31.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

#import "TAXCommentCell.h"
#import "UIImageView+WebCache.h"
#import "TAXComment.h"
#import "TAXUser.h"
@interface TAXCommentCell ()
@property (weak, nonatomic) IBOutlet UIImageView *profile_imageView;
@property (weak, nonatomic) IBOutlet UIImageView *sexImageView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *like_countLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIButton *voiceButton;

@end
@implementation TAXCommentCell

- (void)awakeFromNib{
    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bgView;

}
- (void)setComment:(TAXComment *)comment{
    _comment = comment;

    [self.profile_imageView setHeaderUrl:comment.user.profile_image];
    self.usernameLabel.text = comment.user.username;
    self.like_countLabel.text = [NSString stringWithFormat:@"%zd",comment.like_count];
    self.contentLabel.text = comment.content;
    if ([comment.user.sex isEqualToString:TAXUserSexF]) {
        self.sexImageView.image = [UIImage imageNamed:@"Profile_womanIcon"];
    }else{
        self.sexImageView.image = [UIImage imageNamed:@"Profile_manIcon"];
    }
    
    if (comment.voiceuri.length) {
        self.voiceButton.hidden = NO;
        [self.voiceButton setTitle:[NSString stringWithFormat:@"%zd''", comment.voicetime] forState:UIControlStateNormal];
        self.contentLabel.hidden = YES;

    }else{
        self.voiceButton.hidden = YES;
        self.contentLabel.hidden = NO;
    }
    
}

- (void)setFrame:(CGRect)frame{
    frame.origin.x = TAXTopicCellMargin;
    frame.size.width -= 2 *TAXTopicCellMargin;
    [super setFrame:frame];
}

- (BOOL)canBecomeFirstResponder{
    return YES;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    return NO;
}

@end
