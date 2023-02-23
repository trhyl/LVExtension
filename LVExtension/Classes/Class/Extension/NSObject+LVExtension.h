//
//  NSObject+LVExtension.h
//  LVExtension_code
//
//  Created by trhyl on 2023/02/23.
//  Copyright © 2023 com.lv All rights reserved.
//

#import <Foundation/Foundation.h>

#define LVPerformSelectorWarning(Stuff) \
    do { \
        _Pragma("clang diagnostic push") \
        _Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
        Stuff; \
        _Pragma("clang diagnostic pop") \
    } while (0)

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (LVExtension)

+ (BOOL)lv_validString:(NSString *)string;

+ (void)safeExchangeInstanceMethod:(Class)aClass oldSel:(SEL)oldSEL newSel:(SEL)newSEL;

+ (NSString *)lv_removeWhitespace:(NSString *)string;

+ (BOOL)simpleJudgeJsonString:(NSString *)jsonString;

+ (NSDictionary *)modelDictionaryWithJson:(id)json;

@end




@interface UIView (LVExtension)

- (CGFloat)left;
- (CGFloat)right;
- (CGSize)size;
- (CGFloat)top;
- (CGFloat)bottom;
- (CGFloat)width;
- (CGFloat)height;
- (CGFloat)centerX;
- (CGFloat)centerY;
- (CGFloat)maxX;
- (CGFloat)maxY;
- (void)setLeft:(CGFloat)left;
- (void)setRight:(CGFloat)right;
- (void)setSize:(CGSize)size;
- (void)setTop:(CGFloat)top;
- (void)setBottom:(CGFloat)bottom;
- (void)setWidth:(CGFloat)width;
- (void)setHeight:(CGFloat)height;
- (void)setCenterX:(CGFloat)centerX;
- (void)setCenterY:(CGFloat)centerY;
- (void)setOrigin:(CGPoint)point;
- (void)setAddTop:(CGFloat)top;
- (void)setAddLeft:(CGFloat)left;

@end

@interface UIFont (LVFontExtension)

// PingFangSC默认字体
+ (UIFont *)lv_light:(CGFloat)fontSize;
+ (UIFont *)lv_regular:(CGFloat)fontSize;
+ (UIFont *)lv_medium:(CGFloat)fontSize;
+ (UIFont *)lv_SemiBold:(CGFloat)fontSize;
+ (UIFont *)lv_Bold:(CGFloat)fontSize;

@end

@interface UIApplication (LVApplicationExtension)

+ (void)lv_openUrl:(NSString *)url;

+ (void)lv_openURL:(NSURL *)url;

+ (void)lv_openUrl:(NSString *)url UniversalLinksOnly:(BOOL)only;

+ (void)lv_openURL:(NSURL *)url option:(NSDictionary *)options completion:(void (^ __nullable)(BOOL success))completion;

@end

@interface NSDictionary (LVApplicationExtension)

/**
 @brief 生成一份flutter平台支持的编解码字典
 
 @note https://docs.flutter.dev/development/platform-integration/platform-channels?tab=type-mappings-obj-c-tab#codec
 */
- (NSDictionary *)flutterStandardCodecMap;

@end

@interface NSArray (LVApplicationExtension)

- (NSArray *)flutterStandardCodecMap;

@end

NS_ASSUME_NONNULL_END
