//
//  TAXTopic.m
//  BaiSiJie
//
//  Created by 谭安溪 on 16/3/18.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

#import "TAXTopic.h"
#import "NSDate+TAXAdditions.h"

@implementation TAXTopic
- (NSString *)create_time{
    
    NSDate *date = [NSDate date];
    NSDateFormatter *fm = [[NSDateFormatter alloc]init];
    fm.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *create = [fm dateFromString:_create_time];
    NSDateComponents *comps = [date componentsFromDate:create];
    if ([create isThisYear]) {
        if ([create isToday]) {
            if (comps.hour>1) {
                return [NSString stringWithFormat:@"%zd小时前",comps.hour];
            }else if(comps.minute>1){
                return [NSString stringWithFormat:@"%zd分钟前",comps.minute];
            }else{
               return @"刚刚";
            }
        }else if ([create isYesterday]){
            fm.dateFormat = @"昨天HH:mm:ss";            
            return [fm stringFromDate:create];
        }else{
            fm.dateFormat = @"MM-dd HH:mm:ss";
            return [fm stringFromDate:create];
        }
    }else{
        return _create_time;
    }

}

- (CGFloat)TopicCellH{
    
    if (_TopicCellH == 0) {
        CGFloat topH = TAXTopicCellMargin + TAXTopicCellImageH;
        CGFloat middleH = [self.text boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 4*TAXTopicCellMargin, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.height + 2 * TAXTopicCellMargin;
        CGFloat bottomH = TAXTopicCellBottomH;
        _TopicCellH = topH + middleH + bottomH + TAXTopicCellMargin;
    }
    return _TopicCellH;
    
}


@end
