//
//  SYUIHUD.h
//  zhangshaoyu
//
//  Created by zhangshaoyu on 2020/9/12.
//  Copyright © 2020 zhangshaoyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 显示样式（风火轮、自定义图标）
typedef NS_ENUM(NSInteger, SYUIHUDMode) {
    /// 显示风火轮滚动+文本（默认方式）
    SYUIHUDModeDefault = 0,
    /// 显示风火轮滚动+文本
    SYUIHUDModeActivityText = SYUIHUDModeDefault,
    /// 显示风火轮滚动+无文本（默认方式）
    SYUIHUDModeActivity = 2,
    /// 自定义显示图标+文本
    SYUIHUDModeCustomViewText = 3,
    /// 自定义显示图标+无文本
    SYUIHUDModeCustomView = 4
};

@interface SYUIHUD : NSObject

/// 显示模式（默认SYUIHUDModeDefault）
@property (nonatomic, assign) SYUIHUDMode mode;

/// 大小（默认102*102）
@property (nonatomic, assign) CGSize size;
/// 最大宽度（默认宽度：屏幕宽-40）
@property (nonatomic, assign) CGFloat maxWidth;

/// 是否自适应字符长度（默认NO）
@property (nonatomic, assign) BOOL autoSize;

/// 是否点击隐藏（默认NO）
@property (nonatomic, assign) BOOL touchHide;
/// 是否动画（默认NO）
@property (nonatomic, assign) BOOL isAmination;

/// 阴影背景颜色（默认clear）
@property (nonatomic, strong) UIColor *shadowColor;

/// HUD背景颜色（默认black 0.8）
@property (nonatomic, strong) UIColor *hudColor;
/// HUD圆角（默认8）
@property (nonatomic, assign) CGFloat hudCornerRadius;

/// 风火轮颜色（默认white）
@property (nonatomic, strong) UIColor *activityColor;

/// 图标（默认无）
@property (nonatomic, strong) NSString *imageName;
/// 图标旋转动画（默认NO）
@property (nonatomic, assign) BOOL imageAnimation;
/// 图标旋转动画时间（默认0.5）
@property (nonatomic, assign) NSTimeInterval imageDuration;

/// 字体大小（默认13）
@property (nonatomic, strong) UIFont *messageFont;
/// 字体颜色（默认white）
@property (nonatomic, strong) UIColor *messageColor;

/// y显示位置（默认居中）
@property (nonatomic, assign) CGFloat offsetY;

+ (instancetype)share;

/// 显示
- (void)showInView:(UIView *)view enable:(BOOL)enable message:(NSString *)message autoHide:(NSTimeInterval)time finishHandle:(void (^)(void))handle;

/// 隐藏
- (void)hideDelay:(NSTimeInterval)time finishHandle:(void (^)(void))handle;

@end

NS_ASSUME_NONNULL_END
