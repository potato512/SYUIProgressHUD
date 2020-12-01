//
//  SYUIProgressHUD.m
//  zhangshaoyu
//
//  Created by Herman on 2020/4/19.
//  Copyright © 2020 zhangshaoyu. All rights reserved.
//

#import "SYUIProgressHUD.h"


@interface SYUIProgressHUD ()

@end

@implementation SYUIProgressHUD

/// 单例
+ (instancetype)share
{
    static SYUIProgressHUD *hudManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        hudManager = [[SYUIProgressHUD alloc] init];
    });
    return hudManager;
}

#pragma mark - toast

- (SYUIToast *)toast
{
    if (_toast == nil) {
        _toast = [[SYUIToast alloc] init];
    }
    return _toast;
}

/// toast 在 window显示，且不隐藏
- (void)toast:(NSString *)message
{
    [self toast:message delay:0];
}
/// toast 在 window显示，且3秒后自动隐藏
- (void)toastAutoHide:(NSString *)message
{
    [self toast:message delay:3];
}
/// toast 在 window显示，且 time 秒后自动隐藏
- (void)toast:(NSString *)message delay:(NSTimeInterval)time
{
    [self toast:kDelegateWindow message:message delay:time];
}
/// toast 在 view 显示，且 time 秒后自动隐藏
- (void)toast:(UIView *)view message:(NSString *)message delay:(NSTimeInterval)time
{
    self.toast.isAmination = YES;
    [self.toast showInView:view enable:YES message:message autoHide:time finishHandle:NULL];
}

/// toast 隐藏
- (void)toastHide
{
    [self.toast hideDelay:0 finishHandle:NULL];
}

#pragma mark - hud

- (SYUIHUD *)hud
{
    if (_hud == nil) {
        _hud = [[SYUIHUD alloc] init];
    }
    return _hud;
}

/// hud 在 window显示， activity
- (void)hudActivity
{
    [self hud:kDelegateWindow enable:YES mode:SYUIHUDModeActivity message:nil image:nil imageAnimation:NO delay:0];
}
/// hud 在 window显示， activity+message
- (void)hudActivity:(NSString *)message
{
    [self hud:kDelegateWindow enable:YES mode:SYUIHUDModeActivityText message:message image:nil imageAnimation:NO delay:0];
}
/// hud 在 window显示，image
- (void)hudImage:(NSString *)imagename
{
    [self hud:kDelegateWindow enable:YES mode:SYUIHUDModeCustomView message:nil image:imagename imageAnimation:YES delay:0];
}
/// hud 在 window 显示，image+message
- (void)hudImage:(NSString *)imagename message:(NSString *)message
{
    [self hud:kDelegateWindow enable:YES mode:SYUIHUDModeCustomViewText message:message image:imagename imageAnimation:YES delay:0];
}
/// hud 在 view 显示，view 属性 enable，mode 模式设置及自定义 image， time 秒后自动隐藏
- (void)hud:(UIView *)view enable:(BOOL)enable mode:(SYUIHUDMode)mode message:(NSString *)message image:(NSString *)imageName imageAnimation:(BOOL)animation delay:(NSTimeInterval)time
{
    self.hud.isAmination = YES;
    self.hud.mode = mode;
    self.hud.imageName = imageName;
    self.hud.imageAnimation = animation;
    [self.hud showInView:view enable:enable message:message autoHide:time finishHandle:NULL];
}

/// hud 隐藏
- (void)hudHide
{
    [self.hud hideDelay:0 finishHandle:NULL];
}

@end
