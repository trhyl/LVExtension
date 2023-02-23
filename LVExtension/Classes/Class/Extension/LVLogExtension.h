//
//  LVLogExtension.h
//  LVExtension_code
//
//  Created by trhyl on 2023/1/18.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LVLogExtension : NSObject

/**
 @brief 打印AFNetwork请求的结果日志
 
 @note manager 不是当前 AFHTTPSessionManager 类型则不打印！
 
 @param manager AFHTTPSessionManager
 @param task NSURLSessionDataTask
 @param startTime 请求时间
 @param error NSError
 @param response 返回值（NSDictory/NSArray）
 @param extra 额外参数（可以自定义）
 */
+ (void)logURLInfo:(id)manager
              task:(NSURLSessionDataTask *)task
            params:(NSDictionary *)params
         startTime:(CFAbsoluteTime)startTime
             error:(NSError *)error
                rt:(id)response
             extra:(id)extra;

@end

NS_ASSUME_NONNULL_END
