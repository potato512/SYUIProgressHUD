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

#pragma mark - getter

- (SYUIToast *)toast
{
    if (_toast == nil) {
        _toast = [[SYUIToast alloc] init];
    }
    return _toast;
}

- (SYUIHUD *)hud
{
    if (_hud == nil) {
        _hud = [[SYUIHUD alloc] init];
    }
    return _hud;
}

@end
