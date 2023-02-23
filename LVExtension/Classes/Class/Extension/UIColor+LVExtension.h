//
//  UIColor+LVExtension.h
//  LVAppModule_Example
//
//  Created by lvhongyang1 on 2021/12/21.
//  Copyright © 2021 com.lv All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define LVRGB(color) [UIColor lv_colorWithRGB:(color)]

@interface UIColor (LVExtension)

@property (nonatomic, readonly) CGFloat red; // Only valid if canProvideRGBComponents is YES
@property (nonatomic, readonly) CGFloat green; // Only valid if canProvideRGBComponents is YES
@property (nonatomic, readonly) CGFloat blue; // Only valid if canProvideRGBComponents is YES
@property (nonatomic, readonly) CGFloat white; // Only valid if colorSpaceModel == kCGColorSpaceModelMonochrome
@property (nonatomic, readonly) CGFloat alpha;


+ (UIColor *)lv_colorWithHex:(UInt32)hex;
+ (UIColor *)lv_colorWithHex:(UInt32)hex andAlpha:(CGFloat)alpha;
+ (UIColor *)lv_colorWithHexString:(NSString *)hexString;
+ (UIColor *)lv_colorWithRGB:(NSInteger)rgbValue;

+ (UIColor *)lv_colorWithString:(NSString *)hexString;

+ (UIColor *)lv_blue;//#337CC4

+ (UIColor *)lv_line;//[UIColor lv_colorWithHex:0x000000 andAlpha:0.1];

+ (UIColor *)lv_randomColor;

+ (UIColor *)lv_bg; //#F4F5F6

+ (UIColor *)lv_orange; //#FF8903

+ (UIColor *)lv_gradientColor:(NSArray *)colors
                    startPoint:(CGPoint)startPoint
                      endPoint:(CGPoint)endPoint;

/**
 @brief 设置饱和度的滤镜值
 */
- (NSArray *)lv_saturate:(CGFloat)amount;

/**
 @brief 饱和度0（黑白）的滤镜值
 */
+ (NSArray *)lv_greyFilter;

+ (NSArray *)lv_singleGreyFilter;

@end

NS_ASSUME_NONNULL_END
