//
//  SYUIBaseHUD.h
//  DemoItoast
//
//  Created by zhangshaoyu on 2020/9/12.
//  Copyright © 2020 zhangshaoyu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SYUIBaseHUD : UIView

#pragma mark - 属性

//
@property (nonatomic, strong) UIActivityIndicatorView *activityView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *messageLabel;
//
@property (nonatomic, weak) NSTimer *hideDelayTimer;


/// 大小（默认102*102）
@property (nonatomic, assign) CGSize size;
/// 背景颜色（默认灰色）
@property (nonatomic, strong) UIColor *color;
/// 圆角（默认10）
@property (nonatomic, assign) CGFloat cornerRadius;
/// 风火轮颜色（默认白色）
@property (nonatomic, strong) UIColor *activityColor;


/// 字体大小（默认15）
@property (nonatomic, strong) UIFont *messageFont;
/// 字体颜色（默认黑色）
@property (nonatomic, strong) UIColor *messageColor;


/// 是否自适应字符长度（默认否）
@property (nonatomic, assign) BOOL autoSize;
/// 是否点击隐藏（默认否）
@property (nonatomic, assign) BOOL touchHide;
/// 是否动画（默认否）
@property (nonatomic, assign) BOOL isAmination;

/// 是否多行显示（默认NO，即多行显示）
@property (nonatomic, assign) BOOL isSingleline;
/// 最小宽度（默认宽度：40）
@property (nonatomic, assign) CGFloat minWidth;
/// 最大宽度（默认宽度：屏幕宽-20）
@property (nonatomic, assign) CGFloat maxWidth;

#pragma mark - 显示、隐藏

/// 显示
- (void)show;
/// 显示，提示语
- (void)showWithMessage:(NSString *)msg;
/// 显示，提示语 + 回调
- (void)showWithMessage:(NSString *)msg handle:(void (^)(void))handle;
/// 显示，自动隐藏
- (void)showAutoHide;
/// 显示，自动隐藏 + 提示语
- (void)showAutoHideWithMessage:(NSString *)msg;
/// 显示，自动隐藏 + 提示语 + 回调
- (void)showAutoHideWithMessage:(NSString *)msg handle:(void (^)(void))handle;
/// 隐藏
- (void)hide;
/// 隐藏，延迟
- (void)hideDelay:(NSTimeInterval)time;
/// 隐藏，延迟 + 回调
- (void)hideDelay:(NSTimeInterval)time handle:(void (^)(void))handle;

@end

NS_ASSUME_NONNULL_END
