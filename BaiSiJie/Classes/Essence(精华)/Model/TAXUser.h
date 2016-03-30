//
//  TAXUser.h
//  BaiSiJie
//
//  Created by 谭安溪 on 16/3/30.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TAXUser : NSObject

/** 用户名 */
@property (nonatomic, copy) NSString *username;
/** 性别 */
@property (nonatomic, copy) NSString *sex;
/** 头像 */
@property (nonatomic, copy) NSString *profile_image;

@end
