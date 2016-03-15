//
//  TAXRecommendCategory.m
//  BaiSiJie
//
//  Created by 谭安溪 on 16/3/8.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

#import "TAXRecommendCategory.h"

@implementation TAXRecommendCategory

/**
 *  懒加载users数组
 */
- (NSMutableArray *)users{
    
    if (!_users) {
        _users = [NSMutableArray array];
    }
    return _users;
}

@end
