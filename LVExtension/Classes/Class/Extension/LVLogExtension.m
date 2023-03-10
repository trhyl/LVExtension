//
//  LVLogExtension.m
//  LVExtension_code
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
    NSString *cost = [NSString stringWithFormat:@"π΄[%@θζΆ:] %.1f ms", method, (CFAbsoluteTimeGetCurrent() - startTime) * 1000];
    [rt appendFormat:@"\n======================β€οΈ[LV_NETINFO num:%ld]π€======================\n", (long)_rq_num++];
    [rt appendFormat:@"π[host:] %@\n", webURL.host];
    [rt appendFormat:@"π§‘[path:] %@ %@\n", webURL.relativePath, cost];
    [rt appendFormat:@"π[head:] %@\n", HTTPHeader];
    [rt appendFormat:@"π[body:] %@ εΊεεη±»ε:%@\n", params, [requestSerializer class]];
    if (extra) {
        [rt appendFormat:@"π€[extra:] %@", extra];
    }
    if (error) {
        [rt appendFormat:@"     π΄[.error:] %@\n", error];
    }
#if DEBUG
    [rt appendFormat:@"     π[DEBUG-afsession:] %@\n", manager];
#endif
    [rt appendFormat:@"     π€[sessionTask:]\n%@",[self LV_taskInfo:task]];
    if (response) {
        [rt appendFormat:@"     π’[.responseObject:]\n %@\n", response];
    }
    [rt appendFormat:@"\n====================================================================\n"];
    [LVAppInfoUtils flag:@"[η½η»ζ₯εΏ]" info:rt];
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
    [rt appendFormat:@"          π [.state:] %@\n", stateStr];
    [rt appendFormat:@"          π’[.desc:] %@\n", task.debugDescription];
    if (task.error) {
        [rt appendFormat:@"          π΄[.ERRORβ:] %@\n", task.error];
    }
    [rt appendFormat:@"          π€[.response:] %@\n", task.response];
    return rt.copy;
}

@end
