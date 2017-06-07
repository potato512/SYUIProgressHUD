//
//  SYIToast+SYCategory.h
//  zhangshaoyu
//
//  Created by zhangshaoyu on 15/7/30.
//  Copyright (c) 2015年 zhangshaoyu. All rights reserved.
//

#import "SYIToast.h"

@interface SYIToast (SYCategory)

/// 顶端显示提示iToast
+ (void)alertWithTitle:(NSString *)title;

/// 居中显示提示iToast
+ (void)alertWithTitleCenter:(NSString *)title;

/// 底端显示提示iToast
+ (void)alertWithTitleBottom:(NSString *)title;

/// 隐藏iToast
+ (void)hiddenIToast;

@end
