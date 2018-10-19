//
//  SYIToast+SYCategory.h
//  zhangshaoyu
//
//  Created by zhangshaoyu on 15/7/30.
//  Copyright (c) 2015年 zhangshaoyu. All rights reserved.
//  https://github.com/potato512/SYToast

#import "SYIToast.h"

@interface SYIToast (SYCategory)

/**
 顶端显示提示iToast

 @param title 提示信息
 */
+ (void)alertWithTitle:(NSString *)title;

/**
 居中显示提示iToast

 @param title 提示信息
 */
+ (void)alertWithTitleCenter:(NSString *)title;

/**
 底端显示提示iToast

 @param title 提示信息
 */
+ (void)alertWithTitleBottom:(NSString *)title;

/// 隐藏iToast
+ (void)hideIToast;

@end
