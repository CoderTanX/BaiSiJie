//
//  TAXAddToolbar.h
//  BaiSiJie
//
//  Created by 谭安溪 on 16/4/6.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TAXAddToolbar;

@protocol TAXAddToolbarDelegate<NSObject>

@optional
- (void)addToolbarAddTagButttonDidClicked:(TAXAddToolbar *)addToolbar;

@end

@interface TAXAddToolbar : UIView

@property (nonatomic, weak) id<TAXAddToolbarDelegate>delegate;
/** 存放所有的标签label */
@property (nonatomic, strong) NSMutableArray *tags;
- (void)reloadTagLabels;

@end
