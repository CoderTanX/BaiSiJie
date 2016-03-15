//
//  UIBarButtonItem+TAXAdditions.h
//  BaiSiJie
//
//  Created by 谭安溪 on 16/3/7.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (TAXAdditions)

+ (instancetype)itemWithImage:(NSString *)image highlightImage:(NSString *)highlightImage target:(id)target action:(SEL)action;

@end
