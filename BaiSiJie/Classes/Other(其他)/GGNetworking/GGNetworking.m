//
//  GGNetworking.m
//  HuiTouZi
//
//  Created by 谭安溪 on 16/3/2.
//  Copyright © 2016年 HUITOUZI. All rights reserved.
//

#import "GGNetworking.h"
#import "AFHTTPSessionManager.h"
#import "JSON.h"
#import "SVProgressHUD.h"
// 日志输出
#ifdef DEBUG
#define GGLog(...) NSLog(__VA_ARGS__)
#else
#define GGLog(...)
#endif



@implementation GGNetworking

+ (void)getWithUrl:(NSString *)URLString success:(GGResponseSuccess)success failure:(GGResponseFailure)failure{
    [self getWithUrl:URLString parameters:nil success:success failure:failure];
}

+ (void)getWithUrl:(NSString *)URLString  parameters:(id)parameters success:(GGResponseSuccess)success failure:(GGResponseFailure)failure{
    [self getWithUrl:URLString parameters:parameters progress:nil success:success failure:failure];
}

+ (void)getWithUrl:(NSString *)URLString parameters:(id)parameters progress:(void (^)(NSProgress *progress))progress success:(GGResponseSuccess)success failure:(GGResponseFailure)failure{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:URLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        if (progress) {
            progress(downloadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //为了便于观看，转为json字符串
        GGLog(@"发送的请求：%@\n 参数：%@\n 返回的json数据：%@\n",URLString,parameters,[responseObject JSONRepresentation]);
            success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        GGLog(@"发送的请求：%@\n 参数：%@\n 错误信息：%@\n",URLString,parameters,error);
        [SVProgressHUD showErrorWithStatus:@"发生错误"];
        failure(error);
    }];
}

+ (void)postWithUrl:(NSString *)URLString success:(GGResponseSuccess)success failure:(GGResponseFailure)failure{
    [self postWithUrl:URLString parameters:nil success:success failure:failure];
}
+ (void)postWithUrl:(NSString *)URLString  parameters:(id)parameters success:(GGResponseSuccess)success failure:(GGResponseFailure)failure{
    [self postWithUrl:URLString parameters:parameters progress:nil success:success failure:failure];
}
+ (void)postWithUrl:(NSString *)URLString parameters:(id)parameters progress:(void (^)(NSProgress *progress))progress success:(GGResponseSuccess)success failure:(GGResponseFailure)failure{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //为了便于观看，转为json字符串
        GGLog(@"发送的请求：%@\n 参数：%@\n 返回的json数据：%@\n",URLString,parameters,[responseObject JSONRepresentation]);
                success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        GGLog(@"发送的请求：%@\n 参数：%@\n 错误信息：%@\n",URLString,parameters,error);
        [SVProgressHUD showErrorWithStatus:@"发生错误"];
        failure(error);
    }];
}


@end
