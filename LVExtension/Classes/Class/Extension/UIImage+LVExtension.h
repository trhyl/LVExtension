//
//  UIImage+LVExtension.h
//  LVExtension_code
//
//  Created by trhyl on 2023/02/23.
//  Copyright © 2023 com.lv All rights reserved.
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
