//
//  UIImage+LVExtension.h
//  LVAppModule_Example
//
//  Created by lvhongyang1 on 2021/12/28.
//  Copyright © 2021 com.lv All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (LVExtension)

+ (UIImage *)imageWithColor:(UIColor *)color;

+ (UIImage *)lv_gradientImage:(NSArray *)colors
                    startPoint:(CGPoint)startPoint
                      endPoint:(CGPoint)endPoint;

@end

NS_ASSUME_NONNULL_END
