//
//  SYUIProgressHUD.h
//  zhangshaoyu
//
//  Created by Herman on 2020/4/19.
//  Copyright © 2020 zhangshaoyu. All rights reserved.
//  github:https://github.com/potato512/SYUIProgressHUD

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SYUIToast.h"
#import "SYUIHUD.h"
#import "AppDelegate.h"

NS_ASSUME_NONNULL_BEGIN

#define HUDManager SYUIProgressHUD.share

/// window
#define kDelegateWindow (UIApplication.sharedApplication.delegate.window)

/// hud show
#define AlertHUDMessage(view, tips) [SYUIProgressHUD.share.hud showInView:view enable:YES message:tips autoHide:0 finishHandle:NULL]
/// hud hide
#define AlertHUDHide() [SYUIProgressHUD.share.hud hideDelay:0 finishHandle:NULL]

/// toast show
#define AlertToastMessage(view, tips) [SYUIProgressHUD.share.toast showInView:view enable:YES message:tips autoHide:3 finishHandle:NULL]

@interface SYUIProgressHUD : NSObject

/// 单例
+ (instancetype)share;

/// toast
@property (nonatomic, strong) SYUIToast *toast;

/// toast 在 window显示，且不隐藏
- (void)toast:(NSString *)message;
/// toast 在 window显示，且3秒后自动隐藏
- (void)toastAutoHide:(NSString *)message;
/// toast 在 window显示，且 time 秒后自动隐藏
- (void)toast:(NSString *)message delay:(NSTimeInterval)time;
/// toast 在 view 显示，且 time 秒后自动隐藏
- (void)toast:(UIView *)view message:(NSString *)message delay:(NSTimeInterval)time;

/// toast 隐藏
- (void)toastHide;

/// hud
@property (nonatomic, strong) SYUIHUD *hud;

/// hud 在 window显示， activity
- (void)hudActivity;
/// hud 在 window显示， activity+message
- (void)hudActivity:(NSString *)message;
/// hud 在 window显示，image
- (void)hudImage:(NSString *)imagename;
/// hud 在 window 显示，image+message
- (void)hudImage:(NSString *)imagename message:(NSString *)message;
/// hud 在 view 显示，view 属性 enable，mode 模式设置及自定义 image， time 秒后自动隐藏
- (void)hud:(UIView *)view enable:(BOOL)enable mode:(SYUIHUDMode)mode message:(NSString *)message image:(NSString *)imageName imageAnimation:(BOOL)animation delay:(NSTimeInterval)time;

/// hud 隐藏
- (void)hudHide;


@end

NS_ASSUME_NONNULL_END
