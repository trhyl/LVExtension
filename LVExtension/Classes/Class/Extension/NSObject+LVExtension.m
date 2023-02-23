//
//  NSObject+LVExtension.m
//  LVAppModule_Example
//
//  Created by lvhongyang1 on 2021/12/23.
//  Copyright © 2021 com.lv All rights reserved.
//

#import "NSObject+LVExtension.h"

#import "LVAppInfoUtils.h"

#import <objc/runtime.h>

@implementation NSObject (LVExtension)

#pragma mark - Public Method

+ (BOOL)lv_validString:(NSString *)string {
    if (!string || ![string isKindOfClass:[NSString class]] || string.length <= 0) {
        return NO;
    }
    return YES;
}

+ (void)safeExchangeInstanceMethod:(Class)aClass oldSel:(SEL)oldSEL newSel:(SEL)newSEL {
    Method oldMethod = class_getInstanceMethod(aClass, oldSEL);
    Method newMethod = class_getInstanceMethod(aClass, newSEL);
    
    BOOL addNewMethod = class_addMethod(aClass,
                                        oldSEL,
                                        method_getImplementation(newMethod),
                                        method_getTypeEncoding(newMethod));
    if (addNewMethod) {
        class_replaceMethod(aClass,
                            newSEL,
                            method_getImplementation(oldMethod),
                            method_getTypeEncoding(oldMethod));
    } else {
        method_exchangeImplementations(oldMethod, newMethod);
    }
}

+ (id)error2Json:(NSError*) error {
    if (error && error.userInfo) {
        if ([error.userInfo isKindOfClass:[NSDictionary class]]) {
            NSDictionary *userInfo = (NSDictionary*) error.userInfo;
            NSArray *allKeys = userInfo.allKeys;
            for (int i = 0; i < allKeys.count; ++i) {
                id value = userInfo[allKeys[i]];
                if ([value isKindOfClass:[NSData class]]) {
                    return [NSJSONSerialization JSONObjectWithData:value options:NSJSONReadingMutableContainers error:nil];
                }
            }
        }
    }
    return nil;
}

+ (NSString *)lv_removeWhitespace:(NSString *)string {
    if (![string isKindOfClass:[NSString class]] || string.length <= 0) {
        return @"";
    }
    return [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

+ (BOOL)simpleJudgeJsonString:(NSString *)jsonString {
    if (!jsonString || ![jsonString isKindOfClass:[NSString class]]) {
        return NO;
    }
    if (jsonString.length < 2) {
        return NO;
    }
    if (([jsonString hasPrefix:@"{"] && [jsonString hasSuffix:@"}"]) ||
        ([jsonString hasPrefix:@"["] && [jsonString hasSuffix:@"]"])) {
        return YES;
    }
    return NO;
}

+ (NSDictionary *)modelDictionaryWithJson:(id)json {
    if (!json) return nil;
    NSDictionary *dic = nil;
    NSData *jsonData = nil;
    if ([json isKindOfClass:[NSDictionary class]]) {
        dic = json;
    } else if ([json isKindOfClass:[NSString class]]) {
        jsonData = [(NSString *)json dataUsingEncoding : NSUTF8StringEncoding];
    } else if ([json isKindOfClass:[NSData class]]) {
        jsonData = json;
    }
    if (jsonData) {
        dic = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:NULL];
        if (![dic isKindOfClass:[NSDictionary class]]) dic = nil;
    }
    return dic;
}

@end

@implementation UIView (LVExtension)

- (CGFloat)left
{
    return self.frame.origin.x;
}

- (CGFloat)right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (CGFloat)top
{
    return self.frame.origin.y;
}

- (CGFloat)bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (CGSize)size{
    return self.frame.size;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (CGFloat)maxX
{
    return CGRectGetMaxX(self.frame);
}

- (CGFloat)maxY
{
    return CGRectGetMaxY(self.frame);
}

- (void)setLeft:(CGFloat)left
{
    CGRect frame = self.frame;
    frame.origin.x = left;
    self.frame = frame;
}

- (void)setRight:(CGFloat)right;
{
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (void)setBottom:(CGFloat)bottom
{
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (void)setTop:(CGFloat)top
{
    CGRect frame = self.frame;
    frame.origin.y = top;
    self.frame = frame;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (void)setOrigin:(CGPoint)point
{
    CGRect frame = self.frame;
    frame.origin = point;
    self.frame = frame;
}

- (void)setCenterX:(CGFloat)centerX
{
    self.center = CGPointMake(centerX, self.center.y);
}

- (void)setCenterY:(CGFloat)centerY
{
    self.center = CGPointMake(self.center.x, centerY);
}

- (void)setAddTop:(CGFloat)top
{
    CGRect frame = self.frame;
    frame.origin.y += top;
    self.frame = frame;
}

- (void)setAddLeft:(CGFloat)left
{
    CGRect frame = self.frame;
    frame.origin.x += left;
    self.frame = frame;
}

@end

@implementation UIFont (LVFontExtension)

#pragma mark - Public Method

+ (UIFont *)lv_light:(CGFloat)fontSize {
    return [self lv_fontName:@"PingFangSC-Light" size:fontSize];
}
+ (UIFont *)lv_regular:(CGFloat)fontSize {
    return [self lv_fontName:@"PingFangSC-Regular" size:fontSize];
}

+ (UIFont *)lv_medium:(CGFloat)fontSize {
    return [self lv_fontName:@"PingFangSC-Medium" size:fontSize];
}

+ (UIFont *)lv_SemiBold:(CGFloat)fontSize {
    return [self lv_fontName:@"PingFangSC-Semibold" size:fontSize];
}

+ (UIFont *)lv_Bold:(CGFloat)fontSize {
    return [self lv_fontName:@"PingFangSC-Bold" size:fontSize];
}

#pragma mark - Private Method

+ (UIFont *)lv_fontName:(NSString *)name size:(CGFloat)fontSize {
    UIFont *font = [UIFont fontWithName:name size:fontSize];
    return font;
}

@end


@implementation UIApplication (LVApplicationExtension)

#pragma mark - Private Method

+ (void)lv_openUrl:(NSString *)url {
    if (url) {
        [self lv_openURL:[NSURL URLWithString:url]];
    }
}

+ (void)lv_openURL:(NSURL *)url {
    [self lv_openURL:url option:@{} completion:nil];
}

+ (void)lv_openUrl:(NSString *)url UniversalLinksOnly:(BOOL)only {
    if (!url) return;
    if (@available(iOS 10.0, *)) {
        [self lv_openURL:[NSURL URLWithString:url] option:@{
            UIApplicationOpenURLOptionUniversalLinksOnly : @(only)
        } completion:nil];
    } else {
        [self lv_openUrl:url];
    }
}

+ (void)lv_openURL:(NSURL *)url option:(NSDictionary *)options completion:(void (^ __nullable)(BOOL success))completion {
    _LVLog(@"|- [UIApplication sharedApplication] openURL -------");
    _LVLog(@"|- url: %@", url);
    _LVLog(@"|- options: %@", options);
    _LVLog(@"|- handler: %@", completion);
    if (@available(iOS 10.0, *)) {
        [[UIApplication sharedApplication] openURL:url options:options completionHandler:completion];
    } else {
        BOOL rt = [[UIApplication sharedApplication] openURL:url];
        if (completion) {
            completion(rt);
        }
    }
    _END_
}

@end


@implementation NSDictionary (LVApplicationExtension)

#pragma mark - Public Method

- (NSDictionary *)flutterStandardCodecMap {
    NSDictionary *params = self;
    if (params.count <= 0) return @{};
    _LVLog(@"|- Map 转化为 Flutter Map");
    
    NSArray *keys = params.allKeys;
    NSMutableDictionary *rt = @{}.mutableCopy;
    
    for(NSString *key in keys) {
        id objc = params[key];
        BOOL canCodecs = NO;
        if([objc isKindOfClass:[NSNumber class]] ||
           [objc isKindOfClass:[NSString class]]) {
            canCodecs = YES;
        } else if ([objc isKindOfClass:[NSDictionary class]]) {
            objc = [(NSDictionary *)objc flutterStandardCodecMap];
            canCodecs = YES;
        } else if ([objc isKindOfClass:[NSArray class]]) {
            objc = [(NSArray *)objc flutterStandardCodecMap];
            canCodecs = YES;
        } else {
            _LVLog(@"|- ❌移除数据: %@ (class: %@)", objc, [objc class]);
        }
        if(canCodecs && objc) {
            [rt setObject:objc forKey:key];
        }
    }
    
    _LVLog(@"|- 原数据: %@", params);
    _LVLog(@"|- Convert Map: %@", rt);
    return rt.copy;
}

@end

@implementation NSArray (LVApplicationExtension)

#pragma mark - Public Method

- (NSArray *)flutterStandardCodecMap {
    NSArray *datas = self;
    if (datas.count <= 0) return @[];
    _LVLog(@"|- Array 转化为 Flutter Array");
    
    NSMutableArray *rt = @[].mutableCopy;
    
    for (id object in datas) {
        id obj = object;
        BOOL canCodecs = NO;
        if ([obj isKindOfClass:[NSNumber class]]) {
            canCodecs = YES;
        } else if ([obj isKindOfClass:[NSString class]]) {
            canCodecs = YES;
        } else if ([obj isKindOfClass:[NSDictionary class]]) {
            canCodecs = YES;
            obj = [(NSDictionary *)obj flutterStandardCodecMap];
        } else if ([obj isKindOfClass:[NSArray class]]) {
            canCodecs = YES;
            obj = [obj flutterStandardCodecMap];
        } else {
            _LVLog(@"|- ❌移除数据: %@ (class: %@)", obj, [obj class]);
        }
        if(canCodecs && obj) {
            [rt addObject:obj];
        }
    }
    
    _LVLog(@"|- 原数据: %@", datas);
    _LVLog(@"|- Convert Array: %@", rt);
    return rt.copy;
}

@end
