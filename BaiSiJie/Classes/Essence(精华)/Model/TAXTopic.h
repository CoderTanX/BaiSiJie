//
//  TAXTopic.h
//  BaiSiJie
//
//  Created by 谭安溪 on 16/3/18.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TAXTopic : NSObject
/** 名称 */
@property (nonatomic, copy) NSString *name;
/** 头像 */
@property (nonatomic, copy) NSString *profile_image;
/** 发帖时间 */
@property (nonatomic, copy) NSString *create_time;
/** 文字内容 */
@property (nonatomic, copy) NSString *text;
/** 顶的数量 */
@property (nonatomic, copy) NSString *ding;
/** 踩的数量 */
@property (nonatomic, copy) NSString *cai;
/** 转发的数量 */
@property (nonatomic, copy) NSString *repost;
/** 评论的数量 */
@property (nonatomic, copy) NSString *comment;

/**自己加的属性*/
@property (nonatomic, assign) CGFloat TopicCellH;
@end
