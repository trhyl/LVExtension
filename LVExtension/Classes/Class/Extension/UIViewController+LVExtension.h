//
//  UIViewController+Extension.h
//  LVAppModule_Example
//
//  Created by lvhongyang1 on 2021/12/15.
//  Copyright © 2021 com.lv All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 @brief ViewController 的生命周期状态
 */
typedef NS_OPTIONS(NSInteger, LVVCState) {
    LVVCStateUnknow                = 0,
    LVVCStateDidLoadBefore         = 1 << 0,
    LVVCStateDidLoadAfter          = 1 << 1,
    LVVCStateWillAppearBefore      = 1 << 2,
    LVVCStateWillAppearAfter       = 1 << 3,
    LVVCStateDidAppearBefore       = 1 << 4,
    LVVCStateDidAppearAfter        = 1 << 5,
    LVVCStateWillDisappearBefore   = 1 << 6,
    LVVCStateWillDisappearAfter    = 1 << 7,
    LVVCStateDidDisappearBefore    = 1 << 8,
    LVVCStateDidDisappearAfter     = 1 << 9,
    LVVCStateDellocAfter           = 1 << 10
};

@interface LVVCLifeIndicator : NSObject

@property (nonatomic, assign, readonly) LVVCState state;   ///< 状态

@end

/**
 @brief 页面的指示器
 */
@interface LVVCIndicator : NSObject

@property (nonatomic, strong, readonly) LVVCLifeIndicator *life;   ///< 生命周期
@property (nonatomic, copy) NSString *pageName; ///< 页面名称
@property (nonatomic, assign) BOOL isFlutterContainer;  ///< 是否是Flutter容器页面，默认NO

@end

@interface UIViewController (LVExtension)

@property (nonatomic, strong, readonly) LVVCIndicator *LVIndictor;

/**
 @brief 成为Appdelegate的RootVC
 */
- (void)lv_changeToAppdelegateRootController;

/**
 @brief 打开给定的页面，优先使用push方式
 */
+ (void)openPagePreferPush:(UIViewController *)vc;

/**
 @brief 关闭当前页面
 */
+ (void)closeCurrentPageWithAnimated:(BOOL)animated completion:(nullable void(^)(BOOL))completion;

+ (UIViewController *)currentViewController;

/**
 @brief 开启页面指示器
 */
- (instancetype)openLifeIndictor;

/**
 @brief 正在展示的VC，最小单位为ViewController
 */
+ (UIViewController *)lv_currentShowViewController;

@end

NS_ASSUME_NONNULL_END
