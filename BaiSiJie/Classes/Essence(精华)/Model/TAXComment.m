//
//  TAXComment.m
//  BaiSiJie
//
//  Created by 谭安溪 on 16/3/30.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

#import "TAXComment.h"
#import "MJExtension.h"
@implementation TAXComment
{
    CGFloat _commentCellH;
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"ID":@"id"};
}

- (CGFloat)commentCellH{
    if (!_commentCellH) {
        CGFloat top = 18 + TAXTopicCellMargin;
        if (self.content) {
            CGFloat middleW = TAXScreenW - 40 - 35.5 - 6 * TAXTopicCellMargin;
            CGFloat middleH = [self.content boundingRectWithSize:CGSizeMake(middleW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size.height;
            _commentCellH += middleH +TAXTopicCellMargin;
            
        }
        _commentCellH += top + TAXTopicCellMargin;
    }
    return _commentCellH;
}
@end
