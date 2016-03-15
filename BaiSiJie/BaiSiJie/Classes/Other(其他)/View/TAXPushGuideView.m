//
//  TAXPushGuideView.m
//  BaiSiJie
//
//  Created by 谭安溪 on 16/3/15.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

#import "TAXPushGuideView.h"
static NSString *const VersionKey = @"CFBundleShortVersionString";

@interface TAXPushGuideView ()

@end
@implementation TAXPushGuideView

+ (void)show{
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[VersionKey];
    NSString *sanboxVersion = [[NSUserDefaults standardUserDefaults] objectForKey:VersionKey];
    if (![currentVersion isEqualToString:sanboxVersion]) {
        TAXPushGuideView *pushGuideView = [self pushGuideView];
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        pushGuideView.frame = window.frame;
        [window addSubview:pushGuideView];        
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:VersionKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    }

}

+ (instancetype)pushGuideView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (IBAction)removeGuideView {
    [self removeFromSuperview];
}


@end
