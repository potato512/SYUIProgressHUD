//
//  SYToastView.h
//  zhangshaoyu
//
//  Created by zhangshaoyu on 2018/8/15.
//  Copyright © 2018年 zhangshaoyu. All rights reserved.
//  网络状态提示视图

#import <UIKit/UIKit.h>

#define ToastView [SYToastView shareToastView]

/// 显示位置模式（偏上，居中，偏下）
typedef NS_ENUM(NSInteger, PositionMode)
{
    /// 居上（无圆角）
    PositionTop = 0,
    
    /// 居上（圆角，自适应）
    PositionTopRountAdjust = 1,
    
    /// 居中（圆角，自适应）
    PositionCenterRountAdjust = 2,
    
    /// 居下（圆角，自适应）
    PositionBottomRountAdjust = 3,
};

@interface SYToastView : UIView

/// 单例
+ (instancetype)shareToastView;

/// 延迟隐藏时间（默认3.0秒）
@property (nonatomic, assign) NSTimeInterval hideTime;
/// 背景颜色（默认黑色）
@property (nonatomic, strong) UIColor *bgroundColor;
/// 字体颜色（默认白色）
@property (nonatomic, strong) UIColor *textColor;
/// 字体大小（默认16）
@property (nonatomic, strong) UIFont *textFont;


/// 显示无网络状态提示
- (void)showInView:(UIView *)view position:(PositionMode)posttion message:(NSString *)message image:(UIImage *)image animation:(BOOL)animation;

/// 隐藏
- (void)hide;

@end
