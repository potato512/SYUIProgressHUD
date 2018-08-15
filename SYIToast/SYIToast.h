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
#import "SYHUDProgress.h"

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


/// 显示信息（默认位置为居中）
- (void)showText:(NSString *)text;

/// 显示信息，自定义显示位置
- (void)showText:(NSString *)text postion:(SYIToastPosition)position;

/// 隐藏
- (void)hideIToast;

@end
