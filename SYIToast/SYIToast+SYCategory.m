//
//  SYIToast+SYCategory.m
//  zhangshaoyu
//
//  Created by zhangshaoyu on 15/7/30.
//  Copyright (c) 2015年 zhangshaoyu. All rights reserved.
//

#import "SYIToast+SYCategory.h"

@implementation SYIToast (SYCategory)

// 实例化iToast
+ (void)alertWithTitle:(NSString *)title
{
    if ([self isNullNSStringWithText:title]) {
        return ;
    }
    
    UIView *view = [UIApplication sharedApplication].delegate.window;
    [[SYIToast shareIToast] showToastInView:view text:title type:SYIToastTypeDefault position:SYIToastPositionTop hide:YES enable:YES];
}

+ (void)alertWithTitleCenter:(NSString *)title
{
    if ([self isNullNSStringWithText:title]) {
        return ;
    }
    
    UIView *view = [UIApplication sharedApplication].delegate.window;
    [[SYIToast shareIToast] showToastInView:view text:title type:SYIToastTypeDefault position:SYIToastPositionCenter hide:YES enable:YES];
}

+ (void)alertWithTitleBottom:(NSString *)title
{
    if ([self isNullNSStringWithText:title]) {
        return ;
    }
    
    UIView *view = [UIApplication sharedApplication].delegate.window;
    [[SYIToast shareIToast] showToastInView:view text:title type:SYIToastTypeDefault position:SYIToastPositionBottom hide:YES enable:YES];
}

// 隐藏iToast
+ (void)hideToast
{
    [[SYIToast shareIToast] hideToast];
}

// 字符非空判断（可以是空格字符串）
+ (BOOL)isNullNSStringWithText:(NSString *)text
{
    if (!text || [text isEqualToString:@""] || 0 == text.length) {
        return YES;
    }
    
    return NO;
}

@end
