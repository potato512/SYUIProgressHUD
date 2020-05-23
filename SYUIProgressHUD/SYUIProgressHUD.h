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
    /// 显示风火轮滚动+文本（默认方式）
    SYUIProgressHUDModeDefault = 0,
    /// 自定义显示图标+文本
    SYUIProgressHUDModeCustomView,
    /// 只显示文本信息
    SYUIProgressHUDModeText,
    /// 显示饼图+文本
    SYUIProgressHUDModePie,
    /// 显示圆环+文本
    SYUIProgressHUDModeRing,
    /// 显示进度条+文本
    SYUIProgressHUDModeBar,
    /// 显示风火轮滚动+文本
    SYUIProgressHUDModeActivity = SYUIProgressHUDModeDefault
};

/// 显示动画
typedef NS_ENUM(NSInteger, SYUIProgressHUDAnimation) {
    /// 渐变
    SYUIProgressHUDAnimationFade,
    /// 缩放
    SYUIProgressHUDAnimationZoom,
    /// 缩小
    SYUIProgressHUDAnimationZoomOut,
    /// 放大
    SYUIProgressHUDAnimationZoomIn
};

@interface SYUIProgressHUD : UIView

#pragma mark - 类方法

/// 默认菊花转
+ (instancetype)showHUDWithView:(UIView *)view animated:(BOOL)animated;
/// 隐藏
+ (BOOL)hideHUDWithView:(UIView *)view animated:(BOOL)animated;
///
+ (instancetype)HUDFromView:(UIView *)view;

#pragma mark - 实例方法

/// 初始化
- (instancetype)initWithView:(UIView *)view;

/// 显示
- (void)showAnimated:(BOOL)animated;

///
- (void)hideAnimated:(BOOL)animated;
///
- (void)hideAnimated:(BOOL)animated afterDelay:(NSTimeInterval)delay;
/// 带回调的延迟隐藏
- (void)hideAnimated:(BOOL)animated complete:(void (^)(void))complete;
/// 带回调的隐藏
- (void)hideAnimated:(BOOL)animated afterDelay:(NSTimeInterval)delay complete:(void (^)(void))complete;


@property (nonatomic, assign) SYUIProgressHUDMode hudMode;
@property (nonatomic, assign) SYUIProgressHUDAnimation hudAnimation;

/// 是否多行显示（默认NO单行显示，且模式为SYUIProgressHUDModeText有效）
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
