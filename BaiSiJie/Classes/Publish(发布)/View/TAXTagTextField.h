//
//  TAXTagTextField.h
//  BaiSiJie
//
//  Created by 谭安溪 on 16/4/7.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^deleteBlock)();
@interface TAXTagTextField : UITextField
@property (nonatomic, copy) deleteBlock deleteBlock; ///<删除block

@end
