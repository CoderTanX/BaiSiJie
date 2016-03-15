//
//  GGNetworking.h
//  HuiTouZi
//
//  Created by 谭安溪 on 16/3/2.
//  Copyright © 2016年 HUITOUZI. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  成功的block
 *
 *  @param response 返回的数据
 */
typedef void(^GGResponseSuccess)(id response);

/**
 *  失败的block
 *
 *  @param error 错误信息
 */
typedef void(^GGResponseFailure)(NSError *error);

@interface GGNetworking : NSObject


/**
 *  get请求
 *
 *  @param url     请求的url
 *  @param success 请求成功的回调
 *  @param failure    求情失败的回调
 */
+ (void)getWithUrl:(NSString *)URLString success:(GGResponseSuccess)success failure:(GGResponseFailure)failure;

/**
 *  get请求(带参数)
 *
 *  @param URLString  请求的url
 *  @param parameters 请求的参数
 *  @param success    请求成功的回调
 *  @param failure       求情失败的回调
 */
+ (void)getWithUrl:(NSString *)URLString  parameters:(id)parameters success:(GGResponseSuccess)success failure:(GGResponseFailure)failure;
/**
 *  get请求（带参数，带进度）
 *
 *  @param URLString   请求的url
 *  @param parameters  请求的参数
 *  @param progress    进度
 *  @param success     请求成功的回调
 *  @param failure        求情失败的回调
 */
+ (void)getWithUrl:(NSString *)URLString parameters:(id)parameters progress:(void (^)(NSProgress *progress))progress success:(GGResponseSuccess)success failure:(GGResponseFailure)failure;

/**
 *  post请求
 *
 *  @param url     请求的url
 *  @param success 请求成功的回调
 *  @param failure    求情失败的回调
 */
+ (void)postWithUrl:(NSString *)URLString success:(GGResponseSuccess)success failure:(GGResponseFailure)failure;
/**
 *  post请求(带参数)
 *
 *  @param URLString  请求的url
 *  @param parameters 请求的参数
 *  @param success    请求成功的回调
 *  @param failure       求情失败的回调
 */
+ (void)postWithUrl:(NSString *)URLString  parameters:(id)parameters success:(GGResponseSuccess)success failure:(GGResponseFailure)failure;
/**
 *  post请求（带参数，带进度）
 *
 *  @param URLString   请求的url
 *  @param parameters  请求的参数
 *  @param progress    进度
 *  @param success     请求成功的回调
 *  @param failure        求情失败的回调
 */
+ (void)postWithUrl:(NSString *)URLString parameters:(id)parameters progress:(void (^)(NSProgress *progress))progress success:(GGResponseSuccess)success failure:(GGResponseFailure)failure;
@end
