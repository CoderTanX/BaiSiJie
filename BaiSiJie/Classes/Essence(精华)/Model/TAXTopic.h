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

@property (nonatomic, assign) NSInteger type; ///<topic的类型

@property (nonatomic, copy) NSString *smallImage; ///<小图片
@property (nonatomic, copy) NSString *bigImage; ///<大图片
@property (nonatomic, copy) NSString *middleImage; ///<中等图片

@property (nonatomic, assign) CGFloat height; ///<图片高度
@property (nonatomic, assign) CGFloat width; ///<图片宽度

@property (nonatomic, assign) BOOL is_gif; ///<是否是gif
/**自己加的属性*/
@property (nonatomic, assign) CGFloat TopicCellH;///<cell的高度
@property (nonatomic, assign) CGRect pictureF; ///<图片的frame
@property (nonatomic, assign, getter=isBigPicture) BOOL bigPicture; ///<是否是大图 需要裁剪
@property (nonatomic, assign) CGFloat pictureProgress; ///<进度
@end
