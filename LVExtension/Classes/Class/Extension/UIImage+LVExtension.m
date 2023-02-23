//
//  UIImage+LVExtension.m
//  LVExtension_code
//
//  Created by trhyl on 2023/02/23.
//  Copyright © 2023 com.lv All rights reserved.
//

#import "UIImage+LVExtension.h"

@implementation UIImage (LVExtension)

#pragma mark - Public Method

+ (UIImage *)imageWithColor:(UIColor *)color {
    return [UIImage imageWithColor:color size:CGSizeMake(1.f, 1.f)];
}

+ (UIImage *)lv_gradientImage:(NSArray *)colors startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint {
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, 10, 10);
    
    gradientLayer.startPoint = startPoint;
    gradientLayer.endPoint = endPoint;
    gradientLayer.locations = @[@(0), @(1)];
    
    gradientLayer.colors = colors;
    
    UIGraphicsBeginImageContext(gradientLayer.bounds.size);
    [gradientLayer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *rtImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return rtImage;
}

#pragma mark - Private Method

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}

@end
