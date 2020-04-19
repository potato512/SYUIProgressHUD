//
//  SYUIProgressHUD.h
//  zhangshaoyu
//
//  Created by Herman on 2020/4/19.
//  Copyright © 2020 zhangshaoyu. All rights reserved.
//  github:https://github.com/potato512/SYProgressHUD

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SYUIProgressHUD : UIView

/// 显示父视图，默认无
+ (void)setContainerView:(UIView *)view;

/// 背景颜色，默认灰白
+ (void)setHUDBackgroundColor:(UIColor *)backgroundColor;
/// 圆角，默认10
+ (void)setHUDCorner:(CGFloat)corner;
/// 大小，默认120*120
+ (void)setHUDSize:(CGSize)size;
/// 顶端对齐，默认居中
+ (void)setHUDPosition:(CGFloat)top;

/// 字体大小，默认15
+ (void)setTextFont:(UIFont *)font;
/// 字体颜色，默认黑色
+ (void)setTextColor:(UIColor *)color;
/// 字体对齐，默认居中
+ (void)setTextAlignment:(NSTextAlignment)alignment;

/// 活动指示器颜色，默认灰色
+ (void)setActivityColor:(UIColor *)color;

/// 自动隐藏时间，默认3秒
+ (void)setDurationAutoHide:(NSTimeInterval)duratoion;
/// 是否跟随键盘改变位置，默认 YES
+ (void)setPositionFollowKeyboard:(BOOL)isFollow;


/// 显示活动指示器
+ (void)showActivity;
/// 显示活动指示器，自动隐藏
+ (void)showActivityAutoHide;
/// 显示活动指示器和信息
+ (void)showMessageWithActivity:(NSString *)message;
/// 显示活动指示器和信息，自动隐藏
+ (void)showMessageWithActivityAutoHide:(NSString *)message;
/// 显示图标
+ (void)showIcon:(NSArray <UIImage *> *)images;
/// 显示图标，自动隐藏
+ (void)showIconAutoHide:(NSArray <UIImage *> *)images;
/// 显示图标和信息
+ (void)showMessageWithIcon:(NSString *)message icon:(NSArray <UIImage *> *)images;
/// 显示图标和信息，自动隐藏
+ (void)showMessageWithIconAutoHide:(NSString *)message icon:(NSArray <UIImage *> *)images;
/// 显示信息
+ (void)showMessage:(NSString *)message;
/// 显示信息，自动隐藏
+ (void)showMessageAutoHide:(NSString *)message;

/// 隐藏
+ (void)hide;

@end

NS_ASSUME_NONNULL_END
