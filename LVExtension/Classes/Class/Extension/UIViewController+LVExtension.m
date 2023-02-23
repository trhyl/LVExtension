//
//  UIViewController+Extension.m
//  LVExtension_code
//
//  Created by trhyl on 2023/02/23.
//  Copyright © 2023 com.lv All rights reserved.
//

#import "UIViewController+LVExtension.h"

#import "LVAppInfoUtils.h"

#import "UIImage+LVExtension.h"
#import "NSObject+LVExtension.h"

#import <objc/runtime.h>

@interface LVVCLifeIndicator ()

@property (nonatomic, assign, readwrite) LVVCState state;   ///< 状态

@end

@implementation LVVCLifeIndicator

- (void)dealloc {
    
}

@end



@interface LVVCIndicator ()

@property (nonatomic, strong, readwrite) LVVCLifeIndicator *life;   ///< 生命周期

@end

@implementation LVVCIndicator

#pragma mark - Life Cycle

- (instancetype)init {
    if (self = [super init]) {
        _life = [LVVCLifeIndicator new];
    }
    return self;
}

- (void)dealloc {
    self.life.state = LVVCStateDellocAfter;
}

@end




@interface UIViewController ()

@property (nonatomic, strong, readwrite) LVVCIndicator *LVIndictor;

@end

@implementation UIViewController (LVExtension)

#pragma mark - Life Cycle

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self _addAop];
    });
}

#pragma mark - Public Method

- (void)lv_changeToAppdelegateRootController {
    id<UIApplicationDelegate> appDelegate = [UIApplication sharedApplication].delegate;
    if (!appDelegate) {
        return;
    }
    appDelegate.window.rootViewController = self;
    appDelegate.window.backgroundColor = [UIColor whiteColor];
    [appDelegate.window makeKeyAndVisible];
}

+ (void)openPagePreferPush:(UIViewController *)vc {
    if (!vc) return;
    UIViewController *nc = [self currentViewController];
    if (nc.navigationController) {
        [nc.navigationController pushViewController:vc animated:YES];
    } else {
        [nc presentViewController:vc animated:YES completion:nil];
    }
}

+ (void)closeCurrentPageWithAnimated:(BOOL)animated completion:(void (^)(BOOL))completion {
    UIViewController *nc = [self currentViewController];
    if(!nc) return;
    void(^ flutterCompletion)(BOOL rt) = ^(BOOL rt) {
        if (completion) {
            completion(rt);
        }
    };
    UIViewController *vc = nc.navigationController.presentedViewController;
    if(vc) {
        [vc dismissViewControllerAnimated:animated completion:^{
            flutterCompletion(YES);
        }];
    } else if (nc.navigationController) {
        [nc.navigationController popViewControllerAnimated:animated];
        flutterCompletion(YES);
    } else {
        [nc dismissViewControllerAnimated:animated completion:^{
            flutterCompletion(YES);
        }];
    }
}

+ (UIViewController *)currentViewController {
    UIViewController *top = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (top.presentedViewController) {
        top = top.presentedViewController;
    }
    return [[self class] currentViewControllerWithRootViewController:top];
}

- (instancetype)openLifeIndictor {
    self.LVIndictor = [[LVVCIndicator alloc] init];
    return self;
}

+ (UIViewController *)lv_currentShowViewController {
    UIViewController *vc = [UIViewController currentViewController];
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return ((UINavigationController *)vc).viewControllers.lastObject;
    } else {
        return vc;
    }
}

#pragma mark - Private Method

+ (UIViewController*)currentViewControllerWithRootViewController:(UIViewController*)rootViewController {
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController* tabBarController = (UITabBarController*)rootViewController;
        return [self currentViewControllerWithRootViewController:tabBarController.selectedViewController];
    } else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController* navigationController = (UINavigationController*)rootViewController;
        return [self currentViewControllerWithRootViewController:navigationController.visibleViewController];
    } else if (rootViewController.presentedViewController) {
        UIViewController* presentedViewController = rootViewController.presentedViewController;
        return [self currentViewControllerWithRootViewController:presentedViewController];
    } else {
        return rootViewController;
    }
}

+ (void)_addAop {
    Class aClass = NSClassFromString(@"UIViewController");
    [self safeExchangeInstanceMethod:aClass
                              oldSel:NSSelectorFromString(@"dealloc")
                              newSel:@selector(lv_dealloc)];
    [self safeExchangeInstanceMethod:aClass
                              oldSel:@selector(viewDidLoad)
                              newSel:@selector(lv_viewDidLoad)];
    [self safeExchangeInstanceMethod:aClass
                              oldSel:@selector(viewWillAppear:)
                              newSel:@selector(lv_viewWillAppear:)];
    [self safeExchangeInstanceMethod:aClass
                              oldSel:@selector(viewDidAppear:)
                              newSel:@selector(lv_viewDidAppear:)];
    [self safeExchangeInstanceMethod:aClass
                              oldSel:@selector(viewWillDisappear:)
                              newSel:@selector(lv_viewWillDisappear:)];
    [self safeExchangeInstanceMethod:aClass
                              oldSel:@selector(viewDidDisappear:)
                              newSel:@selector(lv_viewDidDisappear:)];
}

#pragma mark - Hook

- (void)lv_dealloc {
    // 提前执行，因为后执行self可能会被释放掉
    [self _logPageDealloc];
    [self lv_dealloc];
}

- (void)lv_viewDidLoad {
    if (!self.LVIndictor) {
        [self lv_viewDidLoad];
        return;
    } else {
        [self _updateVCState:LVVCStateDidLoadBefore];
        [self lv_viewDidLoad];
        [self _updateVCState:LVVCStateDidLoadAfter];
    }
}

- (void)lv_viewWillAppear:(BOOL)animated {
    if (!self.LVIndictor) {
        [self lv_viewWillAppear:animated];
        return;
    } else {
        [self _updateVCState:LVVCStateWillAppearBefore];
        [self lv_viewWillAppear:animated];
        [self _updateVCState:LVVCStateWillAppearAfter];
    }
}

- (void)lv_viewDidAppear:(BOOL)animated {
    [self _logPageState:YES];
    if (!self.LVIndictor) {
        [self lv_viewDidAppear:animated];
        return;
    } else {
        [self _updateVCState:LVVCStateDidAppearBefore];
        [self lv_viewDidAppear:animated];
        [self _updateVCState:LVVCStateDidAppearAfter];
    }
}

- (void)lv_viewWillDisappear:(BOOL)animated {
    if (!self.LVIndictor) {
        [self lv_viewWillDisappear:animated];
        return;
    } else {
        [self _updateVCState:LVVCStateWillDisappearBefore];
        [self lv_viewWillDisappear:animated];
        [self _updateVCState:LVVCStateWillDisappearAfter];
    }
}

- (void)_logPageDealloc {
    _LVLog(@"♻️ %@ (Release)(P)\n", NSStringFromClass([self class]));
}

- (void)_logPageState:(BOOL)open{
    if ([self isKindOfClass:[UINavigationController class]] ||
        [self isKindOfClass:NSClassFromString(@"UICompatibilityInputViewController")] ||
        [self isKindOfClass:NSClassFromString(@"UISystemInputAssistantViewController")] ||
        [self isKindOfClass:NSClassFromString(@"UIPredictionViewController")] ||
        [self isKindOfClass:NSClassFromString(@"UISystemKeyboardDockController")]) {
        return;
    }
    if (open) {
        _LVLog(@"|-进入->🅾️ %@(P)\n", NSStringFromClass([self class]));
    } else {
        _LVLog(@"<-退出-| %@(P)\n", NSStringFromClass([self class]));
    }
}

- (void)lv_viewDidDisappear:(BOOL)animated {
    [self _logPageState:NO];
    if (!self.LVIndictor) {
        [self lv_viewDidDisappear:animated];
        return;
    } else {
        [self _updateVCState:LVVCStateDidDisappearBefore];
        [self lv_viewDidDisappear:animated];
        [self _updateVCState:LVVCStateDidDisappearAfter];
    }
}

- (void)_updateVCState:(LVVCState)state {
    self.LVIndictor.life.state = state;
}

#pragma mark - Getter

- (LVVCIndicator *)LVIndictor {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setLVIndictor:(LVVCIndicator *)LVIndictor {
    if (LVIndictor) {
        objc_setAssociatedObject(self, @selector(LVIndictor), LVIndictor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

@end
