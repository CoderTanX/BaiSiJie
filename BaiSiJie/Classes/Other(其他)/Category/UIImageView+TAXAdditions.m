//
//  UIImageView+TAXAdditions.m
//  BaiSiJie
//
//  Created by 谭安溪 on 16/4/4.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

#import "UIImageView+TAXAdditions.h"
#import "UIImageView+WebCache.h"
@implementation UIImageView (TAXAdditions)
- (void)setHeaderUrl:(NSString *)url{
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[[UIImage imageNamed:@"defaultUserIcon"] circleImage] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.image = [image circleImage];
    }];
}
@end
