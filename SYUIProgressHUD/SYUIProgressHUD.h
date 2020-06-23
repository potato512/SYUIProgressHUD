//
//  SYUIProgressHUD.h
//  zhangshaoyu
//
//  Created by Herman on 2020/4/19.
//  Copyright © 2020 zhangshaoyu. All rights reserved.
//  github:https://github.com/potato512/SYUIProgressHUD

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 显示样式
typedef NS_ENUM(NSInteger, SYUIProgressHUDMode) {
    /// 显示风火轮滚动（默认方式）
    SYUIProgressHUDModeDefault = 0,
    /// 自定义显示图标
    SYUIProgressHUDModeCustomView,
    /// 只显示标签
    SYUIProgressHUDModeText
};

/// 动画样式
typedef NS_ENUM(NSInteger, SYUIProgressHUDAnimationMode) {
    /// 显示淡入淡出（默认方式）
    SYUIProgressHUDAnimationModeDefault = 0,
    /// 放大缩小
    SYUIProgressHUDAnimationModeScale,
    /// 从上往下
    SYUIProgressHUDAnimationModeTopToDown
};


#define HUDUtil (SYUIProgressHUD.shareHUD)
#define ToastMessage(tips) [HUDUtil showAutoHideWithMessage:tips]

@interface SYUIProgressHUD : UIView

/// 单例
+ (instancetype)shareHUD;

/// HUD大小（默认102*102）
@property (nonatomic, assign) CGSize hudSize;
/// HUD背景颜色（默认灰色）
@property (nonatomic, strong) UIColor *hudColor;
/// HUD圆角（默认10）
@property (nonatomic, assign) CGFloat hudCornerRadius;
/// 风火轮颜色（默认白色）
@property (nonatomic, strong) UIColor *activityColor;

/// 字体大小（默认15）
@property (nonatomic, strong) UIFont *messageFont;
/// 字体颜色（默认黑色）
@property (nonatomic, strong) UIColor *messageColor;

/// 动画样式（默认淡入淡出）
@property (nonatomic, assign) SYUIProgressHUDAnimationMode animationMode;

/// 是否手动点击消失（默认NO）
@property (nonatomic, assign) BOOL touchHide;
/// 是否自适应字符长度（默认否，HUDModeText模式无效）
@property (nonatomic, assign) BOOL autoSize;
/// 界面是否可操作（默认YES）
@property (nonatomic, assign) BOOL hudEnable;
/// 图标动画是否开启（默认NO）
@property (nonatomic, assign) BOOL iconAnimationEnable;

/// 是否多行显示（默认NO，即多行显示）
@property (nonatomic, assign) BOOL isSingleline;
/// 最小宽度（默认宽度：40）
@property (nonatomic, assign) CGFloat minWidth;
/// 最大宽度（默认宽度：屏幕宽-20）
@property (nonatomic, assign) CGFloat maxWidth;


/// 显示（在window层，淡入淡出）
- (void)showWithView:(UIView *)view message:(NSString *)message;
/// 显示（在window层，淡入淡出）
- (void)showWithActivityView:(UIView *)view;
/// 显示（在window层，淡入淡出）
- (void)showWithView:(UIView *)view icon:(UIImage *)image animation:(BOOL)animation;

/// 显示（在window层，淡入淡出）
- (void)showWithActivityView:(UIView *)view message:(NSString *)message;
/// 显示（在window层，淡入淡出）
- (void)showWithIconView:(UIView *)view message:(NSString *)message icon:(UIImage *)image animation:(BOOL)animation;

/// 显示（在window层，淡入淡出，3秒后自动消失）
- (void)showAutoHideWithView:(UIView *)view message:(NSString *)message;
/// 显示（在window层，淡入淡出，n秒后自动消失）
- (void)showAutoHideWithView:(UIView *)view message:(NSString *)message delayTime:(NSTimeInterval)delayTime;


/// 显示
- (void)showWithView:(UIView *)view type:(SYUIProgressHUDMode)type image:(UIImage *)image message:(NSString *)message hide:(BOOL)autoHide delay:(NSTimeInterval)delayTime enabled:(BOOL)isEnabled shadow:(BOOL)showShadow animation:(BOOL)animation;
/// 隐藏
- (void)hide:(BOOL)animation;
/// 隐藏（延时隐藏）
- (void)hide:(BOOL)animation delay:(NSTimeInterval)delayTime;

@end

NS_ASSUME_NONNULL_END

/**
使用示例
1、导入头文件
#import "SYUIProgressHUD.h"

2、初始化
HUDUtil.hudColor = UIColorHexAndAlpha(#000000, 1.0);
HUDUtil.hudCornerRadius = 8.0;
HUDUtil.messageFont = UIFontAutoSize(16);
HUDUtil.messageColor = UIColorHex(#FFFFFF);
HUDUtil.minWidth = 158;
HUDUtil.maxWidth = 260;
HUDUtil.autoSize = YES;

3、使用
 父视图：
 UIView *view = UIApplication.sharedApplication.delegate.window;
 
1）单行文本显示
HUDUtil.isSingleline = YES;
[HUDUtil showWithMessage:@"请求成功"];
 
2）多行文本显示
HUDUtil.isSingleline = NO;
[HUDUtil showWithView:view message:@"此时此刻，你正在使用wifi进行网络请求"];
 
3）自动隐藏
[HUDUtil showAutoHideWithView:view message:text];
 
4）只显示指示符
[HUDUtil showWithActivityView:view];
 
5）指示符+文本，延时5秒自动隐藏
[HUDUtil showWithActivityView:view message:text];
[HUDUtil hide:YES delay:5];
 
6）自定义图标+旋转动画
[HUDUtil showWithView:view icon:kImageWithName(@"refresh_loading_white") animation:YES];
 
7）自定义图标+旋转动画+文本
[HUDUtil showWithIconView:view message:text icon:kImageWithName(@"refresh_loading_white") animation:YES];
 
8）界面不可交互
HUDUtil.hudEnable = NO;
[HUDUtil showWithView:view message:@"加载中..."];
 
9）
 [HUDUtil showWithView:view type:SYUIProgressHUDModeText image:nil message:message hide:YES delay:3 enabled:YES shadow:YES animation:YES];
 
 10）隐藏
 [HUDUtil hide:YES];
 [HUDUtil hide:YES delay:5];

*/
