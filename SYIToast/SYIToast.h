//
//  SYIToast.h
//  zhangshaoyu
//
//  Created by zhangshaoyu on 15/7/30.
//  Copyright (c) 2015年 zhangshaoyu. All rights reserved.
//  https://github.com/potato512/SYToast

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "SYToastView.h"

/// 显示位置，居中，偏顶端，偏底端
typedef NS_ENUM(NSInteger, SYIToastPosition)
{
    /// 居中
    SYIToastPositionCenter = 1,
    
    /// 偏顶
    SYIToastPositionTop = 2,
    
    /// 偏底
    SYIToastPositionBottom = 3,
};

/// 提示类型（默认文本；菊花转、自定义图片）
typedef NS_ENUM(NSInteger, SYIToastType)
{
    /// 提示类型默认文本
    SYIToastTypeDefault = 0,
    
    /// 提示类型 菊花转
    SYIToastTypeIndicato = 1,
    
    /// 提示类型 自定义图片
    SYIToastTypeCustom = 2
};

@interface SYIToast : UIView

/// 单例
+ (id)shareIToast;

/// 延迟隐藏时间（默认1.6秒）
@property (nonatomic, assign) NSTimeInterval hideTime;
/// 背景颜色（默认黑色）
@property (nonatomic, strong) UIColor *bgroundColor;
/// 字体颜色（默认白色）
@property (nonatomic, strong) UIColor *textColor;
/// 字体大小（默认16）
@property (nonatomic, strong) UIFont *textFont;
/// 菊花转颜色（默认灰色）
@property (nonatomic, strong) UIColor *indicatoColor;
/// 自定义视图（默认无，类型为SYIToastTypeCustom时有效）
@property (nonatomic, strong) UIView *customView;

/**
 弹窗提示
 
 @param view 父视图
 @param text 提示语
 @param type 提示类型
 @param position 提示位置
 @param autoHide 是否自动隐藏
 @param isEnabel 父视图是否可交互
 */
- (void)showToastInView:(UIView *)view text:(NSString *)text type:(SYIToastType)type position:(SYIToastPosition)position hide:(BOOL)autoHide enable:(BOOL)isEnabel;

/// 隐藏
- (void)hideToast;

@end
