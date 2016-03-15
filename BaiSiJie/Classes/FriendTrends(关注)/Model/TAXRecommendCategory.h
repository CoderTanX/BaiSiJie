//
//  TAXRecommendCategory.h
//  BaiSiJie
//
//  Created by 谭安溪 on 16/3/8.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TAXRecommendCategory : NSObject
@property (nonatomic, copy) NSString *count; ///<数量
@property (nonatomic, copy) NSString *ID; ///<id
@property (nonatomic, copy) NSString *name; ///<分类的名字

@property (nonatomic, strong) NSMutableArray *users; ///<用户数据源

@property (nonatomic, assign) NSInteger totalPage; ///<总页数
@property (nonatomic, assign) NSInteger currentPage; ///<当前页数
@end
