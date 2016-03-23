//
//  TAXTopicViewController.h
//  BaiSiJie
//
//  Created by 谭安溪 on 16/3/21.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TAXTopicViewController : UITableViewController
//- (NSString *)type;///<帖子的类型交给子类实现
@property (nonatomic, assign) TopticType topticType; ///<类型
@end
