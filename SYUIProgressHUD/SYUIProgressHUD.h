//
//  SYUIProgressHUD.h
//  zhangshaoyu
//
//  Created by Herman on 2020/4/19.
//  Copyright © 2020 zhangshaoyu. All rights reserved.
//  github:https://github.com/potato512/SYProgressHUD

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 显示样式
typedef NS_ENUM(NSInteger, HUDMode) {
    /// 显示风火轮滚动（默认方式）
    HUDModeDefault = 0,
    /// 自定义显示图标
    HUDModeCustomView,
    /// 只显示文本信息
    HUDModeText,
    /// 显示风火轮滚动和文本信息
    HUDModeActivityWithText,
    /// 显示自定义图标和文本信息
    HUDModeCustomViewWithText,
    /// 显示风火轮滚动和文本信息
    HUDModeActivity = HUDModeDefault
};

#define SYHUDUtil (SYUIProgressHUD.share)

@interface SYUIProgressHUD : UIView

+ (instancetype)share;


/// hud 显示
- (void)showMessage:(NSString *)message customView:(UIView *)customView view:(UIView *)view mode:(HUDMode)mode autoHide:(BOOL)isAuto duration:(NSTimeInterval)duration enable:(BOOL)isEnable;
/// hud 显示 活动指示器，非自动隐藏
- (void)showActivity:(UIView *)view;
/// hud 显示 文本，非自动隐藏
- (void)showMessage:(NSString *)message view:(UIView *)view;
/// hud 显示 活动指示器+文本，非自动隐藏
- (void)showActivityWithMessage:(NSString *)message view:(UIView *)view;

/// 带回调的延迟隐藏
- (void)hideDelay:(NSTimeInterval)delay complete:(void (^)(void))complete;
/// 带回调的隐藏
- (void)hideComplete:(void (^)(void))complete;
/// 隐藏
- (void)hide;


/// 是否多行显示（默认NO单行显示，且模式为HUDModeText有效）
@property (nonatomic, assign) BOOL isSingleline;

/// 默认居中显示
@property (nonatomic, assign) CGFloat topPosition;
/// HUD颜色
@property (nonatomic, strong) UIColor *hudColor;
/// HUD圆角，默认10
@property (nonatomic, assign) CGFloat hudCorner;
/// 是否自适应大小，默认YES
@property (nonatomic, assign) BOOL isAutoSize;
/// HUD大小，默认120
@property (nonatomic, assign) CGSize hudSize;
/// 字体颜色
@property (nonatomic, strong) UIColor *textColor;
/// 字体大小
@property (nonatomic, strong) UIFont *textFont;
/// 字体对齐方式
@property (nonatomic, assign) NSTextAlignment textAlign;
/// 活动指示器颜色
@property (nonatomic, strong) UIColor *activityColor;
/// 是否随键盘适配位置，默认YES
@property (nonatomic, assign) BOOL isFollowKeyboard;


@end

NS_ASSUME_NONNULL_END
