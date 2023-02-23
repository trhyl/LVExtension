//
//  LVAppInfoUtils.h
//  LVWebContainer
//
//  Created by lvhongyang1 on 2022/10/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


#define LV_IS_PHONEX [LVAppInfoUtils isIPhoneXSeries] ///< 是否为iPhoneX以后刘海儿

//---------尺寸
#define LV_TOP_SAFE_H ([LVAppInfoUtils statusBarHeight])
#define LV_NAV_H (44 + LV_TOP_SAFE_H)     ///< 导航条高度
#define LV_BOT_SAFE_H (LV_IS_PHONEX ? 35 : 0)  ///< TabBar安全区高度
#define LV_BOT_H (48 + LV_BOT_SAFE_H)     ///< Tabbar高度

//---------Screen
#ifndef LV_SCREEN
#define LV_SCREEN ([LVAppScreenInfo mainScreen])
#endif

#ifndef LV_SCREEN_B
#define LV_SCREEN_B ([LV_SCREEN bounds])
#endif

#ifndef LV_SF_W
#define LV_SF_W (LV_SCREEN_B.size.width)
#endif

#ifndef LV_SF_H
#define LV_SF_H (LV_SCREEN_B.size.height)
#endif

#ifndef LV_SF_MinSize
#define LV_SF_MinSize (LV_SF_W > LV_SF_H ? LV_SF_H : LV_SF_W)
#endif

#ifndef LV_SF_MaxSize
#define LV_SF_MaxSize (LV_SF_W > LV_SF_H ? LV_SF_W : LV_SF_H)
#endif

#ifndef LV_ONEPIX
#define LV_ONEPIX (1/LV_SCREEN.scale)
#endif


#define _LVLOG_CMD NSStringFromSelector(_cmd)

#define _LVLOG_CLASS NSStringFromClass([self class])

#define _LVLog(format, ...) [LVAppInfoUtils info:[NSString stringWithFormat:(format), ##__VA_ARGS__]]

#define _LVFlagLog(flagString, format, ...) [LVAppInfoUtils flag:(flagString) info:[NSString stringWithFormat:(format), ##__VA_ARGS__]]

#define _END_ _LVLog(@"|- cmd: %@(%@)", _LVLOG_CMD, _LVLOG_CLASS);_LVLog(@"|__________end__________");_LVLog(@"");

@interface LVAppInfoUtils : NSObject

+ (BOOL)isIPhoneXSeries;

+ (CGFloat)statusBarHeight;

+ (void)info:(NSString *)info;
+ (void)flag:(NSString *)flag info:(NSString *)info;

@end

NS_ASSUME_NONNULL_END
