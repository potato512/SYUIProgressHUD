//
//  SYHUDProgress.h
//  zhangshaoyu
//
//  Created by zhangshaoyu on 2018/8/15.
//  Copyright © 2018年 zhangshaoyu. All rights reserved.
//  封装 MBProgressHUD:

#import <Foundation/Foundation.h>
// 导入头文件
#import "MBProgressHUD.h"

#define HudManager [SYHUDProgress shareHUDPregress]

@interface SYHUDProgress : NSObject

+ (instancetype)shareHUDPregress;


/// 显示（转圈圈提示信息，需手动停止）
- (void)showIndeterminateMessage:(NSString *)message;
/// 显示（显示父视图；转圈圈提示信息，需手动停止）
- (void)showInView:(UIView *)showView indeterminateMessage:(NSString *)message;


/// 显示（自定义视图；提示信息）
- (void)showCustomView:(UIView *)customView message:(NSString *)message;
/// 显示（显示父视图；自定义视图；提示信息）
- (void)showInView:(UIView *)showView customView:(UIView *)customView message:(NSString *)message;


/// 显示（提示信息）
- (void)showMessage:(NSString *)message;

/// 显示（显示父视图；提示信息）
- (void)showInView:(UIView *)showView message:(NSString *)message;

/// 显示（显示父视图；是否自动隐藏；延迟隐藏时间；是否可交互；提示信息）
- (void)showInView:(UIView *)showView hide:(BOOL)autoHide afterDelay:(NSTimeInterval)timeDelay enabled:(BOOL)isEnable message:(NSString *)message;

/// 显示（显示父视图；显示模式；是否自动隐藏；延迟隐藏时间；是否可交互；提示信息）
- (void)showInView:(UIView *)showView mode:(MBProgressHUDMode)mode hide:(BOOL)autoHide afterDelay:(NSTimeInterval)timeDelay enabled:(BOOL)isEnable message:(NSString *)message;

/// 显示（显示父视图；显示模式；自定义视图；是否自动隐藏；延迟隐藏时间；是否可交互；提示信息）
- (void)showInView:(UIView *)showView mode:(MBProgressHUDMode)mode customView:(UIView *)customView hide:(BOOL)autoHide afterDelay:(NSTimeInterval)timeDelay enabled:(BOOL)isEnable message:(NSString *)message;

/// 显示（显示父视图；显示模式；自定义视图；是否自动隐藏；延迟隐藏时间；是否可交互；提示信息；动画效果）
- (void)showInView:(UIView *)showView mode:(MBProgressHUDMode)mode customView:(UIView *)customView hide:(BOOL)autoHide afterDelay:(NSTimeInterval)timeDelay enabled:(BOOL)isEnable message:(NSString *)message animation:(MBProgressHUDAnimation)animationType;

#pragma mark - 隐藏

- (void)hide;


@end
