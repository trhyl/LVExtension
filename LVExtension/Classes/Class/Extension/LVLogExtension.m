//
//  LVLogExtension.m
//  LVExtensionModule
//
//  Created by trhyl on 2023/1/18.
//

#import "LVLogExtension.h"

#import "LVAppInfoUtils.h"

@implementation LVLogExtension

#pragma mark - Public Method

static NSInteger _rq_num = 1;
+ (void)logURLInfo:(id)manager task:(NSURLSessionDataTask *)task params:(NSDictionary *)params startTime:(CFAbsoluteTime)startTime error:(NSError *)error rt:(id)response extra:(nonnull id)extra {
    if (![manager isKindOfClass:NSClassFromString(@"AFHTTPSessionManager")]) {
        return;
    }
    id requestSerializer = [manager valueForKeyPath:@"requestSerializer"];
    id HTTPHeader = [requestSerializer valueForKeyPath:@"HTTPRequestHeaders"];
    
    NSMutableString *rt = [NSMutableString string];
    NSURL *webURL = task.currentRequest.URL;
    NSString *method = [NSString stringWithFormat:@"%@", task.currentRequest.HTTPMethod];
    NSString *cost = [NSString stringWithFormat:@"🔴[%@耗时:] %.1f ms", method, (CFAbsoluteTimeGetCurrent() - startTime) * 1000];
    [rt appendFormat:@"\n======================❤️[LV_NETINFO num:%ld]🤎======================\n", (long)_rq_num++];
    [rt appendFormat:@"💙[host:] %@\n", webURL.host];
    [rt appendFormat:@"🧡[path:] %@ %@\n", webURL.relativePath, cost];
    [rt appendFormat:@"💚[head:] %@\n", HTTPHeader];
    [rt appendFormat:@"💛[body:] %@ 序列化类型:%@\n", params, [requestSerializer class]];
    if (extra) {
        [rt appendFormat:@"🤎[extra:] %@", extra];
    }
    if (error) {
        [rt appendFormat:@"     🔴[.error:] %@\n", error];
    }
#if DEBUG
    [rt appendFormat:@"     💜[DEBUG-afsession:] %@\n", manager];
#endif
    [rt appendFormat:@"     🖤[sessionTask:]\n%@",[self LV_taskInfo:task]];
    if (response) {
        [rt appendFormat:@"     🟢[.responseObject:]\n %@\n", response];
    }
    [rt appendFormat:@"\n====================================================================\n"];
    [LVAppInfoUtils flag:@"[网络日志]" info:rt];
}

#pragma mark - Private Method

+ (NSString *)LV_taskInfo:(NSURLSessionTask *)task {
    NSURLSessionTaskState state = task.state;
    
    NSMutableString *rt = [NSMutableString string];
    NSString *stateStr = @"";
    switch (state) {
        case NSURLSessionTaskStateRunning: {
            stateStr = @"NSURLSessionTaskStateRunning";
        } break;
        case NSURLSessionTaskStateSuspended: {
            stateStr = @"NSURLSessionTaskStateSuspended";
        } break;
        case NSURLSessionTaskStateCanceling: {
            stateStr = @"NSURLSessionTaskStateCanceling";
        } break;
        default: {
            stateStr = @"NSURLSessionTaskStateCompleted";
        } break;
    }
    [rt appendFormat:@"          🟠[.state:] %@\n", stateStr];
    [rt appendFormat:@"          🟢[.desc:] %@\n", task.debugDescription];
    if (task.error) {
        [rt appendFormat:@"          🔴[.ERROR❌:] %@\n", task.error];
    }
    [rt appendFormat:@"          🟤[.response:] %@\n", task.response];
    return rt.copy;
}

@end
