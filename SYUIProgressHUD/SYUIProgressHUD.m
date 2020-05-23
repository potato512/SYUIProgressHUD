//
//  SYUIProgressHUD.m
//  zhangshaoyu
//
//  Created by Herman on 2020/4/19.
//  Copyright © 2020 zhangshaoyu. All rights reserved.
//

#import "SYUIProgressHUD.h"

static CGFloat const originX = 40;
static CGFloat const originXYInset = 10;
static CGFloat const heightLabel = 30;

@interface SYUIProgressHUD ()

+ (instancetype)share;

@property (nonatomic, strong) UIView *hudView;
@property (nonatomic, strong) UIActivityIndicatorView *activityView;
@property (nonatomic, strong) UIView *customView;
@property (nonatomic, strong) UILabel *label;
//
@property (nonatomic, assign) CGFloat keyboardHeight;
//
@property (nonatomic, assign) BOOL isAnimation;
@property (nonatomic, assign, getter=isFinished) BOOL finished;
@property (nonatomic, assign) NSTimeInterval durationTime;
@property (nonatomic, strong) NSTimer *durationTimer;
//
@property (nonatomic, copy) void (^hideComplete)(void);

@end

@implementation SYUIProgressHUD


#pragma mark - 类方法

/// 默认菊花转
+ (instancetype)showHUDWithView:(UIView *)view animated:(BOOL)animated
{
    SYUIProgressHUD *hud = [[SYUIProgressHUD alloc] initWithView:view];
    [hud showAnimated:animated];
    return hud;
}
/// 隐藏
+ (BOOL)hideHUDWithView:(UIView *)view animated:(BOOL)animated
{
    SYUIProgressHUD *hud = [self HUDFromView:view];
    if (hud && [hud isKindOfClass:SYUIProgressHUD.class]) {
        [hud hideAnimated:animated];
        return YES;
    }
    return NO;
}
///
+ (instancetype)HUDFromView:(UIView *)view
{
    NSEnumerator *subviewsEnum = [view.subviews reverseObjectEnumerator];
    for (UIView *subview in subviewsEnum) {
        if ([subview isKindOfClass:SYUIProgressHUD.class]) {
            return (SYUIProgressHUD *)subview;
        }
    }
    return nil;
}

#pragma mark - 实例方法

- (instancetype)init
{
    self = [super init];
    if (self) {
        _hudColor = [UIColor.blackColor colorWithAlphaComponent:0.3];
        _hudCorner = 10;
        _hudSize = CGSizeMake(120, 120);
        _isAutoSize = YES;
        _textColor = UIColor.blackColor;
        _textFont = [UIFont systemFontOfSize:15];
        _activityColor = [UIColor.whiteColor colorWithAlphaComponent:1];
        _durationTime = 3;
        _isFollowKeyboard = YES;
        //
        self.hudView.frame = CGRectMake(0, 0, self.hudSize.width, self.hudSize.height);
        self.hudView.backgroundColor = _hudColor;
        self.hudView.layer.cornerRadius = _hudCorner;
        self.hudView.alpha = 0.0;
        //
        self.alpha = 0.0;
        self.backgroundColor = UIColor.clearColor;
    }
    return self;
}

/// 初始化
- (instancetype)initWithView:(UIView *)view
{
    if (view == nil || ![view respondsToSelector:@selector(addSubview:)]) {
        NSAssert(view, @"View must not be nil and must be the class of UIView");
        return nil;
    }
    
    self = [super init];
    if (self) {
        [view addSubview:self];
    }
    return self;
}

// - (void)setNeedsLayout;
- (void)layoutSubviews
{
    [super layoutSubviews];
}

// - (void)setNeedsUpdateConstraints
- (void)updateConstraints
{
    [super updateConstraints];
    
}

#pragma mark - UI视图

- (void)reloadUI
{
    if (self.hudMode == HUDModeDefault || self.hudMode == HUDModeActivity) {
        [self reloadUIActivity];
    } else if (self.hudMode == HUDModeText) {
        [self reloadUIText];
    } else if (self.hudMode == HUDModeActivityWithText) {
        [self reloadUIActivityText];
    } else if (self.hudMode == HUDModeCustomView) {
        [self reloadUICustom];
    } else if (self.hudMode == HUDModeCustomViewWithText) {
        [self reloadUICustomText];
    }
}

// 活动指示器
- (void)reloadUIActivity
{
    self.hudView.backgroundColor = self.hudColor;
    self.hudView.layer.cornerRadius = self.hudCorner;
    //
    [self.activityView startAnimating];
    self.customView.hidden = YES;
    self.label.hidden = YES;
    //
    CGFloat width = self.frame.size.width;
    CGFloat height = (self.frame.size.height - self.keyboardHeight);
    CGFloat hudWidth = self.sizeWidth;
    CGFloat hudHeight = self.sizeHeight;
    // hud 视图 frame 设置
    CGRect rect = self.hudView.frame;
    rect.origin.x = (width - hudWidth) / 2;
    rect.origin.y = (self.topPosition > 0 ? self.topPosition : (height - self.hudSize.height) / 2);
    rect.size.width = hudWidth;
    rect.size.height = hudHeight;
    self.hudView.frame = rect;
    //
    self.activityView.color = self.activityColor;
    CGRect rectActivity = self.activityView.frame;
    rectActivity.origin.x = (self.hudView.frame.size.width - self.activityView.frame.size.width) / 2;
    rectActivity.origin.y = (self.hudView.frame.size.height - self.activityView.frame.size.height) / 2;
    self.activityView.frame = rectActivity;
}

// 活动指示器+文本
- (void)reloadUIActivityText
{
    self.hudView.backgroundColor = self.hudColor;
    self.hudView.layer.cornerRadius = self.hudCorner;
    //
    [self.activityView startAnimating];
    self.customView.hidden = YES;
    self.label.hidden = NO;
    //
    CGFloat width = self.frame.size.width;
    CGFloat height = (self.frame.size.height - self.keyboardHeight);
    CGFloat hudWidth = self.sizeWidth;
    CGFloat hudHeight = self.sizeHeight;
    if (self.isAutoSize) {
        if (hudWidth < hudHeight) {
            hudWidth = hudHeight;
        }
    } else {
        CGFloat value = MAX(hudHeight, hudWidth);
        hudWidth = value;
        hudHeight = value;
    }
    // hud 视图 frame 设置
    CGRect rect = self.hudView.frame;
    rect.origin.x = (width - hudWidth) / 2;
    rect.origin.y = (self.topPosition > 0 ? self.topPosition : (height - self.hudSize.height) / 2);
    rect.size.width = hudWidth;
    rect.size.height = hudHeight;
    self.hudView.frame = rect;
    //
    self.activityView.color = self.activityColor;
    CGRect rectActivity = self.activityView.frame;
    rectActivity.origin.x = (self.hudView.frame.size.width - self.activityView.frame.size.width) / 2;
    rectActivity.origin.y = (self.hudView.frame.size.height - originXYInset * 3 - self.activityView.frame.size.height) / 2;
    self.activityView.frame = rectActivity;
    //
    self.label.textColor = self.textColor;
    self.label.font = self.textFont;
    self.label.frame = CGRectMake(originXYInset, (self.activityView.frame.origin.y + self.activityView.frame.size.height + originXYInset), (self.hudView.frame.size.width - originXYInset * 2), heightLabel);
}

// 文本
- (void)reloadUIText
{
    self.hudView.backgroundColor = self.hudColor;
    self.hudView.layer.cornerRadius = self.hudCorner;
    //
    [self.activityView stopAnimating];
    self.customView.hidden = YES;
    self.label.hidden = NO;
    //
    CGFloat width = self.frame.size.width;
    CGFloat height = (self.frame.size.height - self.keyboardHeight);
    CGFloat hudWidth = self.sizeWidth;
    CGFloat hudHeight = self.sizeHeight;
    // hud 视图 frame 设置
    CGRect rect = self.hudView.frame;
    rect.origin.x = (width - hudWidth) / 2;
    rect.origin.y = (self.topPosition > 0 ? self.topPosition : (height - (heightLabel + originXYInset * 2)) / 2);
    rect.size.width = hudWidth;
    rect.size.height = hudHeight;
    self.hudView.frame = rect;
    //
    self.label.textColor = self.textColor;
    self.label.font = self.textFont;
    self.label.frame = CGRectMake(originXYInset, originXYInset, (self.hudView.frame.size.width - originXYInset * 2), (self.hudView.frame.size.height - originXYInset * 2));
}

// 图标
- (void)reloadUICustom
{
    self.hudView.backgroundColor = self.hudColor;
    self.hudView.layer.cornerRadius = self.hudCorner;
    //
    [self.activityView stopAnimating];
    self.customView.hidden = NO;
    self.label.hidden = YES;
    //
    CGFloat width = self.frame.size.width;
    CGFloat height = (self.frame.size.height - self.keyboardHeight);
    CGFloat hudWidth = self.sizeWidth;
    CGFloat hudHeight = self.sizeHeight;
    // hud 视图 frame 设置
    CGRect rect = self.hudView.frame;
    rect.origin.x = (width - hudWidth) / 2;
    rect.origin.y = (self.topPosition > 0 ? self.topPosition : (height - self.hudSize.height) / 2);
    rect.size.width = hudWidth;
    rect.size.height = hudHeight;
    self.hudView.frame = rect;
    //
    CGRect rectActivity = self.activityView.frame;
    rectActivity.origin.x = (self.hudView.frame.size.width - self.activityView.frame.size.width) / 2;
    rectActivity.origin.y = (self.hudView.frame.size.height - self.activityView.frame.size.height) / 2;
    self.activityView.frame = rectActivity;
    self.customView.frame = rectActivity;
}

// 图标+文本
- (void)reloadUICustomText
{
    self.hudView.backgroundColor = self.hudColor;
    self.hudView.layer.cornerRadius = self.hudCorner;
    //
    [self.activityView stopAnimating];
    self.customView.hidden = NO;
    self.label.hidden = NO;
    //
    CGFloat width = self.frame.size.width;
    CGFloat height = (self.frame.size.height - self.keyboardHeight);
    CGFloat hudWidth = self.sizeWidth;
    CGFloat hudHeight = self.sizeHeight;
    if (self.isAutoSize) {
        if (hudWidth < hudHeight) {
            hudWidth = hudHeight;
        }
    } else {
        CGFloat value = MAX(hudHeight, hudWidth);
        hudWidth = value;
        hudHeight = value;
    }
    // hud 视图 frame 设置
    CGRect rect = self.hudView.frame;
    rect.origin.x = (width - hudWidth) / 2;
    rect.origin.y = (self.topPosition > 0 ? self.topPosition : (height - self.hudSize.height) / 2);
    rect.size.width = hudWidth;
    rect.size.height = hudHeight;
    self.hudView.frame = rect;
    //
    CGRect rectActivity = self.activityView.frame;
    rectActivity.origin.x = (self.hudView.frame.size.width - self.activityView.frame.size.width) / 2;
    rectActivity.origin.y = (self.hudView.frame.size.height - originXYInset * 3 - self.activityView.frame.size.height) / 2;
    self.activityView.frame = rectActivity;
    self.customView.frame = rectActivity;
    //
    self.label.textColor = self.textColor;
    self.label.font = self.textFont;
    self.label.frame = CGRectMake(originXYInset, (self.activityView.frame.origin.y + self.activityView.frame.size.height + originXYInset), (self.hudView.frame.size.width - originXYInset * 2), heightLabel);
}

- (CGRect)widthRect
{
    CGRect rect = [self.label.text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.label.font} context:nil];
    return rect;
}

- (CGFloat)sizeWidth
{
    CGFloat width = self.hudSize.width;
    if (self.isAutoSize && (self.hudMode == HUDModeText || self.hudMode == HUDModeActivityWithText || self.hudMode == HUDModeCustomViewWithText)) {
        //
        width = self.widthRect.size.width;
        width += originXYInset * 2; // 左右两边间距
        //
        if (width > (self.frame.size.width - originX * 2)) {
            width = (self.frame.size.width - originX * 2);
        }
        if (width < self.hudSize.width) {
            width = self.hudSize.width;
        }
    }
    return width;
}

- (CGFloat)sizeHeight
{
    CGFloat height = self.hudSize.height;
    if (self.hudMode == HUDModeText) {
        if (self.isSingleline) {
            self.label.numberOfLines = 1;
            height = heightLabel;
        } else {
            self.label.numberOfLines = 0;
            CGRect rect = [self.label.text boundingRectWithSize:CGSizeMake(self.sizeWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.label.font} context:nil];
            height = rect.size.height;
            if (height < heightLabel) {
                height = heightLabel;
            }
        }
        height += (originXYInset * 2);
    } else if (self.hudMode == HUDModeActivityWithText || self.hudMode == HUDModeCustomViewWithText) {
        height = (originXYInset + self.activityView.frame.size.height + originXYInset + heightLabel + originXYInset);
        //
        if (height > (self.frame.size.width - originX * 2)) {
            height = (self.frame.size.width - originX * 2);
        }
        if (height < self.hudSize.height) {
            height = self.hudSize.height;
        }
    }
    return height;
}

#pragma mark - 显示隐藏方法

/// 显示
- (void)showAnimated:(BOOL)animated
{
    NSAssert([NSThread isMainThread], @"SYUIProgressHUD needs to be accessed on the main thread.");
    //
    self.isAnimation = animated;
    self.finished = NO;
    [self showHUD];
}

///
- (void)hideAnimated:(BOOL)animated
{
    [self hideAnimated:animated afterDelay:0 complete:NULL];
}
///
- (void)hideAnimated:(BOOL)animated afterDelay:(NSTimeInterval)delay
{
    [self hideAnimated:animated afterDelay:delay complete:NULL];
}
/// 带回调的延迟隐藏
- (void)hideAnimated:(BOOL)animated complete:(void (^)(void))complete
{
    [self hideAnimated:animated afterDelay:0 complete:complete];
}
/// 带回调的隐藏
- (void)hideAnimated:(BOOL)animated afterDelay:(NSTimeInterval)delay complete:(void (^)(void))complete
{
    self.durationTime = delay;
    if (self.durationTime > 0.0) {
        NSTimer *timer = [NSTimer timerWithTimeInterval:self.durationTime target:self selector:@selector(hideHUD) userInfo:nil repeats:NO];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
        self.durationTimer = timer;
    } else {
        [self hideHUD];
    }
}







- (void)showHUD
{
    [self addNotification];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self reloadUI];
        
        UIViewAnimationOptions options = UIViewAnimationOptionAllowUserInteraction | UIViewAnimationCurveEaseOut;
        [UIView animateWithDuration:0.3 delay:0 options:options animations:^{
            self.hudView.alpha = 1.0;
            self.alpha = 1.0;
        } completion:^(BOOL finished) {
        }];
    });
}

- (void)hideHUD
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [self removeNotification];
    //
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.hideComplete) {
            self.hideComplete();
        }
        UIViewAnimationOptions options = UIViewAnimationOptionAllowUserInteraction | UIViewAnimationCurveEaseIn;
        [UIView animateWithDuration:0.3 delay:0 options:options animations:^{
            self.hudView.alpha = 0.0;
            self.alpha = 0.0;
        } completion:^(BOOL finished) {
            self.superview.userInteractionEnabled = YES;
            [self removeFromSuperview];
            if (self.activityView.isAnimating) {
                [self.activityView stopAnimating];
            }
        }];
    });
}

- (void)hideHUDImmediately
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    //
    self.superview.userInteractionEnabled = YES;
    if (self.activityView.isAnimating) {
        [self.activityView stopAnimating];
    }
}

/// hud 显示
- (void)showMessage:(NSString *)message customView:(UIView *)customView view:(UIView *)view mode:(HUDMode)mode autoHide:(BOOL)isAuto duration:(NSTimeInterval)duration enable:(BOOL)isEnable
{
    if (view == nil || ![view isKindOfClass:UIView.class]) {
        NSAssert(view, @"View must not be nil and must be the class of UIView, use setContainerView:.");
        return;
    }
    
    //
    [view addSubview:self];
    self.frame = view.bounds;
    //
    [self hideHUDImmediately];
    //
    self.label.text = message;
    self.hudMode = mode;
    self.superview.userInteractionEnabled = isEnable;
    self.userInteractionEnabled = (isEnable ? NO : YES);
    if (customView && [customView isKindOfClass:UIView.class]) {
        if (self.customView) {
            [self.customView removeFromSuperview];
        }
        self.customView = customView;
        [self.hudView addSubview:self.customView];
    }
    //
    [self showHUD];
    //
    if (isAuto) {
        [self hideDelay:duration complete:NULL];
    }
}
/// hud 显示 活动指示器
- (void)showActivity:(UIView *)view
{
    [self showMessage:nil customView:nil view:view mode:HUDModeActivity autoHide:NO duration:0 enable:YES];
}
/// hud 显示 文本
- (void)showMessage:(NSString *)message view:(UIView *)view
{
    [self showMessage:message customView:nil view:view mode:HUDModeText autoHide:NO duration:0 enable:YES];
}
/// hud 显示 活动指示器+文本
- (void)showActivityWithMessage:(NSString *)message view:(UIView *)view
{
    [self showMessage:message customView:nil view:view mode:HUDModeActivityWithText autoHide:NO duration:0 enable:YES];
}

/// 带回调的延迟隐藏
- (void)hideDelay:(NSTimeInterval)delay complete:(void (^)(void))complete
{
    if ([self respondsToSelector:@selector(hideHUD)]) {
        self.hideComplete = [complete copy];
        [self performSelector:@selector(hideHUD) withObject:nil afterDelay:delay];
    }
}
/// 带回调的隐藏
- (void)hideComplete:(void (^)(void))complete
{
    [self hideDelay:0 complete:complete];
}
/// 隐藏
- (void)hide
{
    [self hideDelay:0 complete:NULL];
}

#pragma mark 通知类

- (void)addNotification
{
    if (self.isFollowKeyboard) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hudPosition:) name:UIDeviceOrientationDidChangeNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hudPosition:) name:UIKeyboardWillHideNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hudPosition:) name:UIKeyboardWillShowNotification object:nil];
    }
}

- (void)removeNotification
{
    if (self.isFollowKeyboard) {
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
}

- (void)hudPosition:(NSNotification *)notification
{
    CGFloat heightKeyboard = 0;
    NSTimeInterval duration = 0;

    if (notification) {
        NSDictionary *info = [notification userInfo];
        CGRect keyboard = [[info valueForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
        duration = [[info valueForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
        if ((notification.name == UIKeyboardWillShowNotification) || (notification.name == UIKeyboardDidShowNotification)) {
            heightKeyboard = keyboard.size.height;
        }
    } else {
        heightKeyboard = self.heightFromKeyboard;
    }
    //
    self.keyboardHeight = heightKeyboard;
    
    CGRect screen = self.hudView.superview.bounds;
    CGPoint center = CGPointMake(screen.size.width / 2, (screen.size.height - heightKeyboard) / 2);
    //
    if (self.shouldReloadTopWhileEdit) {
        //
        [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            self.hudView.center = CGPointMake(center.x, center.y);
        } completion:^(BOOL finished) {
            
        }];
    }
}

- (CGFloat)heightFromKeyboard
{
    for (UIWindow *testWindow in UIApplication.sharedApplication.windows) {
        if (![testWindow.class isEqual:UIWindow.class]) {
            for (UIView *possibleKeyboard in testWindow.subviews) {
                if ([possibleKeyboard.description hasPrefix:@"<UIPeripheralHostView"]) {
                    return possibleKeyboard.bounds.size.height;
                } else if ([possibleKeyboard.description hasPrefix:@"<UIInputSetContainerView"]) {
                    for (UIView *hostKeyboard in possibleKeyboard.subviews) {
                        if ([hostKeyboard.description hasPrefix:@"<UIInputSetHost"]) {
                            return hostKeyboard.frame.size.height;
                        }
                    }
                }
            }
        }
    }
    return 0;
}

- (CGFloat)shouldReloadTopWhileEdit
{
    if (self.topPosition > 0) {
        CGFloat top = (self.hudView.superview.frame.size.height - self.keyboardHeight - self.hudView.frame.size.height) / 2;
        if (self.topPosition > top) {
            return YES;
        }
        return NO;
    }
    return YES;
}

#pragma mark - getter/setter

#pragma mark getter

- (UIView *)hudView
{
    if (_hudView == nil) {
        _hudView = [[UIView alloc] init];
        _hudView.layer.masksToBounds = YES;
        //
        [self addSubview:_hudView];
    }
    return _hudView;
}

- (UIActivityIndicatorView *)activityView
{
    if (_activityView == nil) {
        _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        _activityView.backgroundColor = UIColor.clearColor;
        _activityView.hidesWhenStopped = YES;
        [_activityView stopAnimating];
        //
        [self.hudView addSubview:_activityView];
    }
    return _activityView;
}

- (UILabel *)label
{
    if (_label == nil) {
        _label = [[UILabel alloc] initWithFrame:CGRectZero];
        _label.backgroundColor = UIColor.clearColor;
        _label.textAlignment = NSTextAlignmentCenter;
        //
        [self.hudView addSubview:_label];
    }
    return _label;
}

#pragma mark setter

- (void)setHudColor:(UIColor *)hudColor
{
    _hudColor = hudColor;
    self.hudView.backgroundColor = _hudColor;
}
- (void)setHudCorner:(CGFloat)hudCorner
{
    _hudCorner = hudCorner;
    self.hudView.layer.cornerRadius = _hudCorner;
}
- (void)setHudSize:(CGSize)hudSize
{
    _hudSize = hudSize;
    CGRect rect = self.hudView.frame;
    rect.size = _hudSize;
    self.hudView.frame = rect;
}

- (void)setTextFont:(UIFont *)textFont
{
    _textFont = textFont;
    self.label.font = _textFont;
}
- (void)setTextColor:(UIColor *)textColor
{
    _textColor = textColor;
    self.label.textColor = _textColor;
}
- (void)setTextAlign:(NSTextAlignment)textAlign
{
    _textAlign = textAlign;
    self.label.textAlignment = _textAlign;
}

- (void)setActivityColor:(UIColor *)activityColor
{
    _activityColor = activityColor;
    self.activityView.color = _activityColor;
}

@end
