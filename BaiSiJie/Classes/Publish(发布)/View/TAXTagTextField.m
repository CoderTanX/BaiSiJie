//
//  TAXTagTextField.m
//  BaiSiJie
//
//  Created by 谭安溪 on 16/4/7.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

#import "TAXTagTextField.h"

@implementation TAXTagTextField

- (void)deleteBackward{
    
    !self.deleteBlock?:self.deleteBlock();
    [super deleteBackward];

}

@end
