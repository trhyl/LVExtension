//
//  UIColor+LVExtension.m
//  LVAppModule_Example
//
//  Created by trhyl on 2021/12/21.
//  Copyright © 2021 com.lv All rights reserved.
//  Copy自滴滴的DoraemonKit

#import "UIColor+LVExtension.h"

#import "UIImage+LVExtension.h"

CGFloat LVColorComponentFrom(NSString *string, NSUInteger start, NSUInteger length) {
    NSString *substring = [string substringWithRange:NSMakeRange(start, length)];
    NSString *fullHex = length == 2 ? substring : [NSString stringWithFormat: @"%@%@", substring, substring];
    
    unsigned hexComponent;
    [[NSScanner scannerWithString: fullHex] scanHexInt: &hexComponent];
    return hexComponent / 255.0;
}

@implementation UIColor (LVExtension)

- (CGColorSpaceModel)colorSpaceModel {
    return CGColorSpaceGetModel(CGColorGetColorSpace(self.CGColor));
}

- (BOOL)canProvideRGBComponents {
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelRGB:
        case kCGColorSpaceModelMonochrome:
            return YES;
        default:
            return NO;
    }
}

- (CGFloat)red {
    NSAssert(self.canProvideRGBComponents, @"Must be an RGB color to use -red");
    const CGFloat *c = CGColorGetComponents(self.CGColor);
    return c[0];
}

- (CGFloat)green {
    NSAssert(self.canProvideRGBComponents, @"Must be an RGB color to use -green");
    const CGFloat *c = CGColorGetComponents(self.CGColor);
    if (self.colorSpaceModel == kCGColorSpaceModelMonochrome) return c[0];
    return c[1];
}

- (CGFloat)blue {
    NSAssert(self.canProvideRGBComponents, @"Must be an RGB color to use -blue");
    const CGFloat *c = CGColorGetComponents(self.CGColor);
    if (self.colorSpaceModel == kCGColorSpaceModelMonochrome) return c[0];
    return c[2];
}

- (CGFloat)white {
    NSAssert(self.colorSpaceModel == kCGColorSpaceModelMonochrome, @"Must be a Monochrome color to use -white");
    const CGFloat *c = CGColorGetComponents(self.CGColor);
    return c[0];
}

- (CGFloat)alpha {
    return CGColorGetAlpha(self.CGColor);
}

+ (UIColor *)lv_colorWithHex:(UInt32)hex{
    return [UIColor lv_colorWithHex:hex andAlpha:1];
}
+ (UIColor *)lv_colorWithHex:(UInt32)hex andAlpha:(CGFloat)alpha{
    return [UIColor colorWithRed:((hex >> 16) & 0xFF)/255.0
                           green:((hex >> 8) & 0xFF)/255.0
                            blue:(hex & 0xFF)/255.0
                           alpha:alpha];
}

+ (UIColor *)lv_colorWithRGB:(NSInteger)rgbValue {
    return [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0
                           green:((float)((rgbValue & 0xFF00) >> 8))/255.0
                            blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0];
}

+ (UIColor *)lv_colorWithString:(NSString *)hexString{
    return [self lv_colorWithHexString:hexString];
}

+ (UIColor *)lv_colorWithHexString:(NSString *)hexString {
    CGFloat alpha, red, blue, green;
    
    NSString *colorString = [[hexString stringByReplacingOccurrencesOfString:@"#" withString:@""] uppercaseString];
    switch ([colorString length]) {
        case 3: // #RGB
            alpha = 1.0f;
            red   = LVColorComponentFrom(colorString, 0, 1);
            green = LVColorComponentFrom(colorString, 1, 1);
            blue  = LVColorComponentFrom(colorString, 2, 1);
            break;
            
        case 4: // #ARGB
            alpha = LVColorComponentFrom(colorString, 0, 1);
            red   = LVColorComponentFrom(colorString, 1, 1);
            green = LVColorComponentFrom(colorString, 2, 1);
            blue  = LVColorComponentFrom(colorString, 3, 1);
            break;
            
        case 6: // #RRGGBB
            alpha = 1.0f;
            red   = LVColorComponentFrom(colorString, 0, 2);
            green = LVColorComponentFrom(colorString, 2, 2);
            blue  = LVColorComponentFrom(colorString, 4, 2);
            break;
            
        case 8: // #AARRGGBB
            alpha = LVColorComponentFrom(colorString, 0, 2);
            red   = LVColorComponentFrom(colorString, 2, 2);
            green = LVColorComponentFrom(colorString, 4, 2);
            blue  = LVColorComponentFrom(colorString, 6, 2);
            break;
            
        default:
            return nil;
    }
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

+ (UIColor *)lv_black_1 { // #333333
#if defined(__IPHONE_13_0) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_13_0)
    if (@available(iOS 13.0, *)) {
        return [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
            if (traitCollection.userInterfaceStyle == UIUserInterfaceStyleLight) {
                return [UIColor lv_colorWithString:@"#333333"];
            } else {
                return [UIColor lv_colorWithString:@"#DDDDDD"];
            }
        }];
    }
#endif
    return [UIColor lv_colorWithString:@"#333333"];
}

+ (UIColor *)lv_black_2 {  // #666666
#if defined(__IPHONE_13_0) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_13_0)
    if (@available(iOS 13.0, *)) {
        return [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
            if (traitCollection.userInterfaceStyle == UIUserInterfaceStyleLight) {
                return [UIColor lv_colorWithString:@"#666666"];
            } else {
                return [UIColor lv_colorWithString:@"#AAAAAA"];
            }
        }];
    }
#endif
    return [UIColor lv_colorWithString:@"#666666"];
}

+ (UIColor *)lv_black_3 {  // #999999
#if defined(__IPHONE_13_0) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_13_0)
    if (@available(iOS 13.0, *)) {
        return [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
            if (traitCollection.userInterfaceStyle == UIUserInterfaceStyleLight) {
                return [UIColor lv_colorWithString:@"#999999"];
            } else {
                return [UIColor lv_colorWithString:@"#666666"];
            }
        }];
    }
#endif
    return [UIColor lv_colorWithString:@"#999999"];
}

+ (UIColor *)lv_blue { // #337CC4
#if defined(__IPHONE_13_0) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_13_0)
    if (@available(iOS 13.0, *)) {
        return [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
            if (traitCollection.userInterfaceStyle == UIUserInterfaceStyleLight) {
                return [UIColor lv_colorWithString:@"#337CC4"];
            } else {
                return [UIColor systemBlueColor];
            }
        }];
    }
#endif
    return [UIColor lv_colorWithString:@"#337CC4"];
}

+ (UIColor *)lv_bg{ // #F4F5F6
    return [UIColor lv_colorWithString:@"#F4F5F6"];
}

+ (UIColor *)lv_orange{ //#FF8903
    return [UIColor lv_colorWithString:@"#FF8903"];
}

+ (UIColor *)lv_line {
#if defined(__IPHONE_13_0) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_13_0)
    if (@available(iOS 13.0, *)) {
        return [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
            if (traitCollection.userInterfaceStyle == UIUserInterfaceStyleLight) {
                return [UIColor lv_colorWithHex:0x000000 andAlpha:0.1];
            } else {
                return [UIColor lv_colorWithHex:0x68686B andAlpha:0.6];
            }
        }];
    }
#endif
    return [UIColor lv_colorWithHex:0x000000 andAlpha:0.1];
}

+ (UIColor *)lv_randomColor {
    CGFloat red = ( arc4random() % 255 / 255.0 );
    CGFloat green = ( arc4random() % 255 / 255.0 );
    CGFloat blue = ( arc4random() % 255 / 255.0 );
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}

+ (UIColor *)lv_gradientColor:(NSArray *)colors startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint {
    UIImage *rtImage = [UIImage lv_gradientImage:colors
                                       startPoint:startPoint
                                         endPoint:endPoint];
    return [UIColor colorWithPatternImage:rtImage];
}

- (NSArray *)lv_saturate:(CGFloat)amount {
    CGFloat r,g,b,a;
    [self getRed:&r green:&g blue:&b alpha:&a];
    NSString *clsN = [NSString stringWithFormat:@"JXC%@%@JXC%@", @"C",@"AFi",@"lter"];
    NSString *name = [NSString stringWithFormat:@"LV%@%@LV%@",@"color",@"Sat",@"urate"];
    NSString *param2 = [NSString stringWithFormat:@"%@%@%@", @"input",@"A",@"mount"];
    NSString *method = [NSString stringWithFormat:@"%@JKC%@%@JKC:", @"fil", @"terWith", @"Name"];
    
    NSString *ftObject = [name stringByReplacingOccurrencesOfString:@"LV" withString:@""];
    NSString *ftParams = [param2 stringByReplacingOccurrencesOfString:@"LV" withString:@""];
    NSString *ftMethod = [method stringByReplacingOccurrencesOfString:@"JKC" withString:@""];
    id cls = NSClassFromString([clsN stringByReplacingOccurrencesOfString:@"JXC" withString:@""]);
    
    SEL selector = NSSelectorFromString(ftMethod);
    if (![cls respondsToSelector:selector]) {
        return @[];
    }
    id filter = [cls performSelector:selector withObject:ftObject];
    if (filter) {
        [filter setValue:@(amount) forKey:ftParams];
    }
    return [NSArray arrayWithObject:filter];
}

+ (NSArray *)lv_greyFilter {
    return [[UIColor lightGrayColor] lv_saturate:0];
}

+ (NSArray *)lv_singleGreyFilter {
    static dispatch_once_t onceToken;
    static NSArray *_singleGreyFilter;
    dispatch_once(&onceToken, ^{
        _singleGreyFilter = [self lv_greyFilter] ? : @[];
    });
    return _singleGreyFilter;
}

@end

