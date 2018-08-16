//
//  SYHUDProgress.m
//  zhangshaoyu
//
//  Created by zhangshaoyu on 2018/8/15.
//  Copyright © 2018年 zhangshaoyu. All rights reserved.
//

#import "SYHUDProgress.h"

static NSTimeInterval const timeDelay = 3.0f;

@interface SYHUDProgress ()

@property (nonatomic, strong) MBProgressHUD *hudProgress;
@property (nonatomic, assign) NSTimeInterval delayTime;

@end

@implementation SYHUDProgress

+ (instancetype)shareHUDPregress
{
    static SYHUDProgress *statusView = nil;
    static dispatch_once_t predicate;
    if (statusView == nil) {
        dispatch_once(&predicate, ^{
            statusView = [[self alloc] init];
        });
    }
    return statusView;
}

#pragma mark - 显示

/// 显示（转圈圈提示信息，需手动停止）
- (void)showIndeterminateMessage:(NSString *)message
{
    UIView *view = [[UIApplication sharedApplication].delegate window];
    [self showInView:view mode:MBProgressHUDModeIndeterminate customView:nil hide:NO afterDelay:timeDelay enabled:YES message:message animation:MBProgressHUDAnimationZoom];
}

/// 显示（显示父视图；转圈圈提示信息，需手动停止）
- (void)showInView:(UIView *)showView indeterminateMessage:(NSString *)message
{
    [self showInView:showView mode:MBProgressHUDModeIndeterminate customView:nil hide:NO afterDelay:timeDelay enabled:YES message:message animation:MBProgressHUDAnimationZoom];
}

/// 显示（自定义视图；提示信息）
- (void)showCustomView:(UIView *)customView message:(NSString *)message
{
    UIView *view = [[UIApplication sharedApplication].delegate window];
    [self showInView:view mode:MBProgressHUDModeCustomView customView:customView hide:YES afterDelay:timeDelay enabled:YES message:message animation:MBProgressHUDAnimationZoom];
}

/// 显示（显示父视图；自定义视图；提示信息）
- (void)showInView:(UIView *)showView customView:(UIView *)customView message:(NSString *)message
{
    [self showInView:showView mode:MBProgressHUDModeCustomView customView:customView hide:YES afterDelay:timeDelay enabled:YES message:message animation:MBProgressHUDAnimationZoom];
}

/// 显示（提示信息）
- (void)showMessage:(NSString *)message
{
    UIView *view = [[UIApplication sharedApplication].delegate window];
    [self showInView:view mode:MBProgressHUDModeText customView:nil hide:YES afterDelay:3.0 enabled:YES message:message animation:MBProgressHUDAnimationZoom];
}

/// 显示（显示父视图；提示信息）
- (void)showInView:(UIView *)showView message:(NSString *)message
{
    [self showInView:showView mode:MBProgressHUDModeText customView:nil hide:YES afterDelay:3.0 enabled:YES message:message animation:MBProgressHUDAnimationZoom];
}

/// 显示（显示父视图；是否自动隐藏；延迟隐藏时间；是否可交互；提示信息）
- (void)showInView:(UIView *)showView hide:(BOOL)autoHide afterDelay:(NSTimeInterval)timeDelay enabled:(BOOL)isEnable message:(NSString *)message
{
    [self showInView:showView mode:MBProgressHUDModeText customView:nil hide:autoHide afterDelay:timeDelay enabled:isEnable message:message animation:MBProgressHUDAnimationZoom];
}

/// 显示（显示父视图；显示模式；是否自动隐藏；延迟隐藏时间；是否可交互；提示信息）
- (void)showInView:(UIView *)showView mode:(MBProgressHUDMode)mode hide:(BOOL)autoHide afterDelay:(NSTimeInterval)timeDelay enabled:(BOOL)isEnable message:(NSString *)message
{
    [self showInView:showView mode:mode customView:nil hide:autoHide afterDelay:timeDelay enabled:isEnable message:message animation:MBProgressHUDAnimationZoom];
}

/// 显示（显示父视图；显示模式；自定义视图；是否自动隐藏；延迟隐藏时间；是否可交互；提示信息）
- (void)showInView:(UIView *)showView mode:(MBProgressHUDMode)mode customView:(UIView *)customView hide:(BOOL)autoHide afterDelay:(NSTimeInterval)timeDelay enabled:(BOOL)isEnable message:(NSString *)message
{
    [self showInView:showView mode:mode customView:customView hide:autoHide afterDelay:timeDelay enabled:isEnable message:message animation:MBProgressHUDAnimationZoom];
}

/// 显示（显示父视图；显示模式；自定义视图；是否自动隐藏；延迟隐藏时间；是否可交互；提示信息；动画效果）
- (void)showInView:(UIView *)showView mode:(MBProgressHUDMode)mode customView:(UIView *)customView hide:(BOOL)autoHide afterDelay:(NSTimeInterval)timeDelay enabled:(BOOL)isEnable message:(NSString *)message animation:(MBProgressHUDAnimation)animationType
{
    // 如果已存在，则从父视图移除
    if (self.hudProgress.superview) {
        [self.hudProgress removeFromSuperview];
        self.hudProgress = nil;
    }
    
    // 创建显示视图
    self.hudProgress = [MBProgressHUD showHUDAddedTo:showView animated:YES];
    /*
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    // 方法1
    self.hudProgress = [[MBProgressHUD alloc] initWithWindow:delegate.window];
    //[delegate.window addSubview:mbProgressHUD];
    // 方法2
    self.hudProgress = [MBProgressHUD showHUDAddedTo:delegate.window animated:YES];
    */
    
    
    // 设置显示模式
    self.hudProgress.mode = mode;
    /*
     MBProgressHUDModeIndeterminate            // 显示风火轮滚动（默认方式）
     MBProgressHUDModeDeterminate              // 显示圆形填充
     MBProgressHUDModeAnnularDeterminate       // 显示环形填充
     MBProgressHUDModeDeterminateHorizontalBar // 显示进度条
     MBProgressHUDModeCustomView               // 自定义显示图标
     MBProgressHUDModeText                     // 只显示标签
     */
    
    // 如果是自定义图标模式，则显示
    if (mode == MBProgressHUDModeCustomView) {
        // 设置自定义视图
        if (customView) {
            self.hudProgress.customView = customView;
        }
    }
    
    // 如果是填充模式
//    if (mode == MBProgressHUDModeDeterminate || mode == MBProgressHUDModeAnnularDeterminate || mode == MBProgressHUDModeDeterminateHorizontalBar)
//    {
//        [self.hudProgress showWhileExecuting:@selector(showProgress) onTarget:self withObject:nil animated:YES];
//    }
    
    // 设置标示标签
    self.hudProgress.label.text = message;
    
    // 设置显示类型 出现或消失
    self.hudProgress.animationType = animationType;
    
    // 显示
    [self.hudProgress showAnimated:YES];
    
    // 加上这个属性才能在HUD还没隐藏的时候点击到别的view
    // 取反，即!autoEnabled
    self.hudProgress.userInteractionEnabled = !isEnable;
    
    // 隐藏后从父视图移除
    self.hudProgress.removeFromSuperViewOnHide = YES;
    
    // 设置自动隐藏
    self.delayTime = timeDelay;
    if (autoHide) {
        [self.hudProgress hideAnimated:YES afterDelay:timeDelay];
    }
}

#pragma mark - 隐藏

- (void)hide
{
    if (self.hudProgress) {
        [self.hudProgress hideAnimated:YES afterDelay:0.0];
    }
}

- (void)showProgress
{
    float progress = 0.0f;
    while (progress < 1.0f) {
        progress += 0.05f;
        [self.hudProgress setProgress:progress];
        usleep(50000);
    }
}

@end
