//
//  SYIToast.h
//  zhangshaoyu
//
//  Created by zhangshaoyu on 15/7/30.
//  Copyright (c) 2015年 zhangshaoyu. All rights reserved.
//  提示语弹窗视图

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/// 显示位置，居中，偏顶端，偏底端
typedef NS_ENUM(NSInteger, iToastPosition)
{
    /// 居中
    iToastPositionCenter = 1,
    
    /// 偏顶
    iToastPositionTop = 2,
    
    /// 偏底
    iToastPositionBottom = 3,
};

@interface SYIToast : UIView

/// 单例
+ (id)shareIToast;

/// 显示信息（默认位置为居中）
- (void)showText:(NSString *)text;

/// 隐藏
- (void)hiddenIToast;

/// 显示信息，自定义显示位置
- (void)showText:(NSString *)text postion:(iToastPosition)position;

@end
