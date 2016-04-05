#import <UIKit/UIKit.h>

//topic的类型
typedef NS_ENUM(NSUInteger,TopticType) {
    TAXTopicTypeAll = 1,
    TAXTopicTypePicture = 10,
    TAXTopicTypeWord = 29,
    TAXTopicTypeVoice = 31,
    TAXTopicTypeVideo = 41
};
UIKIT_EXTERN CGFloat TAXTitlesViewH;///<顶部titleView的高度
UIKIT_EXTERN CGFloat TAXTitlesViewY;///<顶部titleView的y
UIKIT_EXTERN CGFloat TAXTopicCellMargin;///<帖子的边距
UIKIT_EXTERN CGFloat TAXTopicCellImageH;///<帖子头像的高度
UIKIT_EXTERN CGFloat TAXTopicCellBottomH;///<帖子底部的高度
UIKIT_EXTERN CGFloat TAXPictureMaxH;///<图片的最高的高度
UIKIT_EXTERN CGFloat TAXPictureClipH;///<图片裁剪后的高度
UIKIT_EXTERN CGFloat TAXTopCommentTitleH;///<热门评论的title的高度
UIKIT_EXTERN NSString *TAXUserSexM;///<男
UIKIT_EXTERN NSString *TAXUserSexF;///<女
/** tabBar被选中的通知名字 */
UIKIT_EXTERN NSString * const TAXTabBarDidSelectNotification;

UIKIT_EXTERN NSInteger const TAXMeSquareMaxCols;///<我模块的一行最多个数