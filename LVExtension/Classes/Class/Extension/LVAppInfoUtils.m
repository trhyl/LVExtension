//
//  LVAppInfoUtils.m
//  LVWebContainer
//
//  Created by lvhongyang1 on 2022/10/14.
//

#import "LVAppInfoUtils.h"

#import "NSObject+LVExtension.h"

#import <sys/utsname.h>

@implementation LVAppInfoUtils

static BOOL canResponseLogger;
static Class aClass;

+ (void)initialize {
    if (self == [LVAppInfoUtils class]) {
        aClass = NSClassFromString(@"LVLogger");
        if (aClass) {
            canResponseLogger = YES;
        }
    }
}

#pragma mark - Public Method

+ (void)flag:(NSString *)flag info:(NSString *)info {
    if (flag) {
        info = [NSString stringWithFormat:@"%@%@", flag, info];
    }
    [self info:info];
}

+ (void)info:(NSString *)info {
    if (canResponseLogger) {
        LVPerformSelectorWarning([aClass performSelector:_cmd withObject:info]);
    } else {
#if DEBUG
        printf("[LOG] %s\n", [info UTF8String]);
#endif
    }
}

+ (BOOL)isIPhoneXSeries {
    static BOOL _iPhoneXSeries;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        BOOL iPhoneXSeries = NO;
        if (UIDevice.currentDevice.userInterfaceIdiom != UIUserInterfaceIdiomPhone) {
            iPhoneXSeries = NO;
        }
        if (@available(iOS 11.0, *)) {
            UIWindow *mainWindow = [self getKeyWindow];
            if (mainWindow.safeAreaInsets.bottom > 0.0) {
                iPhoneXSeries = YES;
            }
        }
        _iPhoneXSeries = iPhoneXSeries;
    });
    return _iPhoneXSeries;
}

+ (CGFloat)statusBarHeight {
    static dispatch_once_t onceToken;
    static CGFloat _statusBarHeight;
    dispatch_once(&onceToken, ^{
        if (@available(iOS 13.0, *)) {
            _statusBarHeight = [UIApplication sharedApplication].windows.firstObject.windowScene.statusBarManager.statusBarFrame.size.height;
        } else {
            _statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
        }
        _LVLog(@"|- App 状态栏高度: %f", _statusBarHeight);
    });
    return _statusBarHeight;
}

#pragma mark - Private Method

+ (UIWindow *)getKeyWindow{
    UIWindow *keyWindow = nil;
    if ([[UIApplication sharedApplication].delegate respondsToSelector:@selector(window)]) {
        keyWindow = [[UIApplication sharedApplication].delegate window];
    }else{
        NSArray *windows = [UIApplication sharedApplication].windows;
        for (UIWindow *window in windows) {
            if (!window.hidden) {
                keyWindow = window;
                break;
            }
        }
    }
    return keyWindow;
}

@end
