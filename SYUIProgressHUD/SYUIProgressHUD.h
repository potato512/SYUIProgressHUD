//
//  SYUIProgressHUD.h
//  zhangshaoyu
//
//  Created by Herman on 2020/4/19.
//  Copyright © 2020 zhangshaoyu. All rights reserved.
//  github:https://github.com/potato512/SYUIProgressHUD

#import <UIKit/UIKit.h>
#import "SYUIToast.h"
#import "SYUIHUD.h"

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

@interface SYUIProgressHUD : UIView

/// toast
@property (nonatomic, strong) SYUIToast *toast;
/// hud
@property (nonatomic, strong) SYUIHUD *hud;

/// 单例
+ (instancetype)share;

@end

NS_ASSUME_NONNULL_END
