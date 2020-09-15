//
//  SYUIToast.h
//  zhangshaoyu
//
//  Created by zhangshaoyu on 2020/9/12.
//  Copyright © 2020 zhangshaoyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


/// Toast显示通知
static NSString *const kNotificationToastDidShow = @"notificationToastDidShow";
/// Toast隐藏通知
static NSString *const kNotificationToastDidHide = @"notificationToastDidHide";


@interface SYUIToast : NSObject

/// 最小宽度（默认宽度：120）
@property (nonatomic, assign) CGFloat minWidth;
/// 最大宽度（默认宽度：屏幕宽-40）
@property (nonatomic, assign) CGFloat maxWidth;
/// 最小高度（默认高度：40）
@property (nonatomic, assign) CGFloat minHeight;
/// 是否自适应字符大小（默认NO）
@property (nonatomic, assign) BOOL autoSize;
 
/// 是否点击隐藏（默认NO）
@property (nonatomic, assign) BOOL touchHide;
/// 是否动画（默认NO）
@property (nonatomic, assign) BOOL isAmination;

/// 字体大小（默认13）
@property (nonatomic, strong) UIFont *messageFont;
/// 字体颜色（默认white）
@property (nonatomic, strong) UIColor *messageColor;

/// toast 背景色（默认black 0.8）
@property (nonatomic, strong) UIColor *toastColor;
/// toast 圆角（默认8）
@property (nonatomic, assign) CGFloat toastCornerRadius;
/// 阴影背景色（默认clear）
@property (nonatomic, strong) UIColor *shadowColor;

/// y显示位置（默认居中）
@property (nonatomic, assign) CGFloat offsetY;

+ (instancetype)share;

/// 显示，自动隐藏 + 提示语 + 回调
- (void)showInView:(UIView *)view enable:(BOOL)enable message:(NSString *)message autoHide:(NSTimeInterval)time finishHandle:(void (^)(void))handle;

/// 隐藏，延迟 + 回调
- (void)hideDelay:(NSTimeInterval)time finishHandle:(void (^)(void))handle;

@end

NS_ASSUME_NONNULL_END
