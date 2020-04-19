//
//  SYProgressHUD.m
//  DemoItoast
//
//  Created by Herman on 2020/4/19.
//  Copyright © 2020 zhangshaoyu. All rights reserved.
//

#import "SYProgressHUD.h"

static CGFloat const originX = 40;
static CGFloat const originXYInset = 10;
static CGFloat const heightLabel = 30;

@interface SYProgressHUD ()

+ (instancetype)share;

@property (nonatomic, strong) UIView *selfSupperView;
@property (nonatomic, assign) CGFloat keyboardHeight;
@property (nonatomic, assign) CGFloat topPosition;
//
@property (nonatomic, strong) UIView *ringView;
@property (nonatomic, strong) UIActivityIndicatorView *activityView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *label;
//
@property (nonatomic, strong) UIColor *hudColor;
@property (nonatomic, assign) CGFloat hudCorner;
@property (nonatomic, assign) CGSize hudSize;
//
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIFont *textFont;
//
@property (nonatomic, strong) UIColor *activityColor;
//
@property (nonatomic, assign) NSTimeInterval durationTime;
//
@property (nonatomic, assign) BOOL isFollowKeyboard;

@property (nonatomic, copy) void (^hideComplete)(void);

@end

@implementation SYProgressHUD

+ (instancetype)share
{
    static SYProgressHUD *shareHUD;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareHUD = [[self alloc] init];
    });
    return shareHUD;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _hudColor = [UIColor.blackColor colorWithAlphaComponent:0.3];
        _hudCorner = 10;
        _hudSize = CGSizeMake(120, 120);
        _textColor = UIColor.blackColor;
        _textFont = [UIFont systemFontOfSize:15];
        _activityColor = [UIColor.whiteColor colorWithAlphaComponent:1];
        _durationTime = 3;
        _isFollowKeyboard = YES;
        //
        self.frame = CGRectMake(0, 0, self.hudSize.width, self.hudSize.height);
        self.backgroundColor = _hudColor;
        self.layer.cornerRadius = _hudCorner;
        self.layer.masksToBounds = YES;
        self.alpha = 0.0;
        self.userInteractionEnabled = YES;
    }
    return self;
}

#pragma mark - 方法

- (void)reloadUI
{
    if (self.label.hidden) {
        [self reloadUIWithoutMessage];
        return;
    }
    
    if (self.activityView.hidden && self.imageView.hidden) {
        [self reloadUIWithoutActivity];
        return;
    }

    [self reloadUIAll];
}

- (void)reloadUIAll
{
    if (self.superview == nil) {
        return;
    }
    
    self.backgroundColor = self.hudColor;
    self.layer.cornerRadius = self.hudCorner;
    //
    self.label.textColor = self.textColor;
    self.label.font = self.textFont;
    //
    self.activityView.color = self.activityColor;
    
    //
    UIView *view = self.superview;
    CGFloat width = view.frame.size.width;
    CGFloat height = (view.frame.size.height - self.keyboardHeight);
    //
    CGRect textRect = [self.label.text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.label.font} context:nil];
    CGFloat widthText = textRect.size.width;
    if (widthText > (width - originX * 2)) {
        widthText = (width - originX * 2);
    }
    if (widthText < self.hudSize.width) {
        widthText = self.hudSize.width;
    }
    // hud 视图 frame 设置
    CGRect rect = self.frame;
    rect.origin.x = (width - widthText) / 2;
    rect.origin.y = (self.topPosition > 0 ? self.topPosition : (height - self.hudSize.height) / 2);
    rect.size.width = widthText;
    rect.size.height = self.hudSize.height;
    self.frame = rect;
    //
    CGRect rectActivity = self.activityView.frame;
    rectActivity.origin.x = (self.frame.size.width - self.activityView.frame.size.width) / 2;
    rectActivity.origin.y = (self.frame.size.height - originXYInset * 3 - self.activityView.frame.size.height) / 2;
    self.activityView.frame = rectActivity;
    self.imageView.frame = rectActivity;
    //
    self.label.frame = CGRectMake(originXYInset, (self.imageView.frame.origin.y + self.imageView.frame.size.height + originXYInset), (self.frame.size.width - originXYInset * 2), heightLabel);
    //
    if (!self.activityView.hidden) {
        [self.activityView startAnimating];
    }
    if (!self.imageView.hidden) {
        if (self.imageView.animationImages.count) {
            [self.imageView startAnimating];
        }
    }
}

- (void)reloadUIWithoutMessage
{
    if (self.superview == nil) {
        return;
    }
    
    self.backgroundColor = self.hudColor;
    self.layer.cornerRadius = self.hudCorner;
    //
    UIView *view = self.superview;
    CGFloat width = view.frame.size.width;
    CGFloat height = (view.frame.size.height - self.keyboardHeight);
    // hud 视图 frame 设置
    CGRect rect = self.frame;
    rect.origin.x = (width - self.hudSize.width) / 2;
    rect.origin.y = (self.topPosition > 0 ? self.topPosition : (height - self.hudSize.height) / 2);
    rect.size.width = self.hudSize.width;
    rect.size.height = self.hudSize.height;
    self.frame = rect;
    //
    CGRect rectActivity = self.activityView.frame;
    rectActivity.origin.x = (self.frame.size.width - self.activityView.frame.size.width) / 2;
    rectActivity.origin.y = (self.frame.size.height - self.activityView.frame.size.height) / 2;
    self.activityView.frame = rectActivity;
    self.imageView.frame = rectActivity;
    //
    if (self.activityView.hidden) {
        
    } else {
        self.activityView.color = self.activityColor;
        [self.activityView startAnimating];
    }
}

- (void)reloadUIWithoutActivity
{
    if (self.superview == nil) {
        return;
    }
    
    self.backgroundColor = self.hudColor;
    self.layer.cornerRadius = self.hudCorner;
    //
    UIView *view = self.superview;
    CGFloat width = view.frame.size.width;
    CGFloat height = (view.frame.size.height - self.keyboardHeight);
    //
    CGRect textRect = [self.label.text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.label.font} context:nil];
    CGFloat widthText = textRect.size.width;
    if (widthText > (width - originX * 2)) {
        widthText = (width - originX * 2);
    }
    if (widthText < self.hudSize.width) {
        widthText = self.hudSize.width;
    }
    // hud 视图 frame 设置
    CGRect rect = self.frame;
    rect.origin.x = (width - widthText) / 2;
    rect.origin.y = (self.topPosition > 0 ? self.topPosition : (height - (heightLabel + originXYInset * 2)) / 2);
    rect.size.width = widthText;
    rect.size.height = (heightLabel + originXYInset * 2);
    self.frame = rect;
    //
    self.label.textColor = self.textColor;
    self.label.font = self.textFont;
    //
    self.label.frame = CGRectMake(originXYInset, originXYInset, (self.frame.size.width - originXYInset * 2), heightLabel);
}

- (void)showHUD
{
    [self addNotification];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self reloadUI];
        UIViewAnimationOptions options = UIViewAnimationOptionAllowUserInteraction | UIViewAnimationCurveEaseOut;
//        self.transform = CGAffineTransformScale(self.transform, 1.4, 1.4);
        [UIView animateWithDuration:0.3 delay:0 options:options animations:^{
//            self.transform = CGAffineTransformScale(self.transform, 1/1.4, 1/1.4);
            self.alpha = 1.0;
        } completion:^(BOOL finished) {
//            self.transform = CGAffineTransformScale(self.transform, 1, 1);
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
//        self.transform = CGAffineTransformScale(self.transform, 1, 1);
        [UIView animateWithDuration:0.3 delay:0 options:options animations:^{
//            self.transform = CGAffineTransformScale(self.transform, 0.7, 0.7);
            self.alpha = 0.0;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
            self.selfSupperView.userInteractionEnabled = YES;
            if (self.activityView.isAnimating) {
                [self.activityView stopAnimating];
            }
            if (self.imageView.isAnimating) {
                [self.imageView stopAnimating];
            }
//            self.transform = CGAffineTransformScale(self.transform, 1, 1);
        }];
    });
}

- (void)hideHUDImmediately
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    //
    self.selfSupperView.userInteractionEnabled = YES;
    if (self.activityView.isAnimating) {
        [self.activityView stopAnimating];
    }
}

/// hud 显示
- (void)showMessage:(NSString *)message activity:(BOOL)isActivity icon:(NSArray <UIImage *> *)images view:(UIView *)view autoHide:(BOOL)isAuto duration:(NSTimeInterval)duration enable:(BOOL)isEnable
{
    if (view == nil || ![view isKindOfClass:UIView.class]) {
        NSAssert(view, @"View must not be nil and must be the class of UIView, use setContainerView:.");
        return;
    } else if (view && [view respondsToSelector:@selector(addSubview:)]) {
        view.userInteractionEnabled = isEnable;
        [view addSubview:self];
    }
    
    [self hideHUDImmediately];
    
    //
    self.label.text = message;
    
    //
    if (images.count > 1) {
        self.imageView.animationImages = images;
        [self.imageView startAnimating];
    } else if (images.count > 0) {
        self.imageView.image = images.lastObject;
    }
    
    //
    if (isAuto) {
        [self hideDelay:duration complete:NULL];
    }
    //
    self.label.hidden = NO;
    self.activityView.hidden = NO;
    self.imageView.hidden = NO;
    if (message == nil || ([message isKindOfClass:NSString.class] && message.length <= 0)) {
        self.label.hidden = YES;
    }
    if (!isActivity) {
        self.activityView.hidden = YES;
    }
    if (images == nil || ([images isKindOfClass:NSArray.class] && images.count <= 0)) {
        self.imageView.hidden = YES;
    }
    //
    [self showHUD];
}

///  带回调的延迟隐藏
- (void)hideDelay:(NSTimeInterval)delay complete:(void (^)(void))complete
{
    if ([self respondsToSelector:@selector(hideHUD)]) {
        self.hideComplete = [complete copy];
        [self performSelector:@selector(hideHUD) withObject:nil afterDelay:delay];
    }
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
    
    CGRect screen = self.superview.bounds;
    CGPoint center = CGPointMake(screen.size.width / 2, (screen.size.height - heightKeyboard) / 2);
    //
    if (self.shouldReloadTopWhileEdit) {
        //
        [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            self.center = CGPointMake(center.x, center.y);
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
        CGFloat top = (self.superview.frame.size.height - self.keyboardHeight - self.frame.size.height) / 2;
        if (self.topPosition > top) {
            return YES;
        }
        return NO;
    }
    return YES;
}

#pragma mark - getter/setter

#pragma mark getter

- (UIActivityIndicatorView *)activityView
{
    if (_activityView == nil) {
        _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        _activityView.backgroundColor = UIColor.clearColor;
        _activityView.hidesWhenStopped = YES;
        [_activityView stopAnimating];
        //
        [self addSubview:_activityView];
    }
    return _activityView;
}

- (UIView *)ringView
{
    if (_ringView == nil) {
        
    }
    return _ringView;
}

- (UIImageView *)imageView
{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _imageView.backgroundColor = UIColor.clearColor;
        //
        [self addSubview:_imageView];
    }
    return _imageView;
}

- (UILabel *)label
{
    if (_label == nil) {
        _label = [[UILabel alloc] initWithFrame:CGRectZero];
        _label.backgroundColor = UIColor.clearColor;
        _label.textAlignment = NSTextAlignmentCenter;
        //
        [self addSubview:_label];
    }
    return _label;
}

#pragma mark setter

- (void)setHudColor:(UIColor *)hudColor
{
    _hudColor = hudColor;
    self.backgroundColor = _hudColor;
}
- (void)setHudCorner:(CGFloat)hudCorner
{
    _hudCorner = hudCorner;
    self.layer.cornerRadius = _hudCorner;
}
- (void)setHudSize:(CGSize)hudSize
{
    _hudSize = hudSize;
    CGRect rect = self.frame;
    rect.size = _hudSize;
    self.frame = rect;
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

- (void)setActivityColor:(UIColor *)activityColor
{
    _activityColor = activityColor;
    self.activityView.color = _activityColor;
}

#pragma mark - 类方法

#pragma mark 属性定义

/// 显示父视图
+ (void)setContainerView:(UIView *)view
{
    SYProgressHUD.share.selfSupperView = view;
}

/// 背景颜色
+ (void)setHUDBackgroundColor:(UIColor *)backgroundColor
{
    SYProgressHUD.share.hudColor = backgroundColor;
}
/// 圆角
+ (void)setHUDCorner:(CGFloat)corner
{
    SYProgressHUD.share.hudCorner = corner;
}
/// 大小
+ (void)setHUDSize:(CGSize)size
{
    CGFloat minSize = (originXYInset + SYProgressHUD.share.activityView.frame.size.width + originXYInset + heightLabel + originXYInset);
    if (MIN(size.width, size.height) < minSize) {
        size.width = minSize;
        size.height = minSize;
    }
    CGFloat maxSize = (SYProgressHUD.share.selfSupperView.frame.size.width - originX * 2);
    if (MAX(size.width, size.height) > maxSize) {
        size.width = maxSize;
        size.height = maxSize;
    }
    SYProgressHUD.share.hudSize = size;
}
/// 顶端对齐，默认居中
+ (void)setHUDPosition:(CGFloat)top
{
    SYProgressHUD.share.topPosition = top;
}

/// 字体大小
+ (void)setTextFont:(UIFont *)font
{
    SYProgressHUD.share.textFont = font;
}
/// 字体颜色
+ (void)setTextColor:(UIColor *)color
{
    SYProgressHUD.share.textColor = color;
}
/// 字体对齐
+ (void)setTextAlignment:(NSTextAlignment)alignment
{
    SYProgressHUD.share.label.textAlignment = alignment;
}

/// 活动指示器颜色
+ (void)setActivityColor:(UIColor *)color
{
    SYProgressHUD.share.activityColor = color;
}

/// 自动隐藏时间，默认3秒
+ (void)setDurationAutoHide:(NSTimeInterval)duratoion
{
    SYProgressHUD.share.durationTime = duratoion;
}

/// 是否跟随键盘改变位置，默认 YES
+ (void)setPositionFollowKeyboard:(BOOL)isFollow
{
    SYProgressHUD.share.isFollowKeyboard = isFollow;
}

#pragma mark 显示或隐藏

#pragma mark 显示
/// 显示
+ (void)showMessage:(NSString *)message activitty:(BOOL)showActivity images:(NSArray <UIImage *> *)images view:(UIView *)view autoHide:(BOOL)isAuto duration:(NSTimeInterval)duration enable:(BOOL)isEnable
{
    [SYProgressHUD.share showMessage:message activity:showActivity icon:images view:view autoHide:isAuto duration:duration enable:isEnable];
}

/// 显示活动指示器
+ (void)showActivity
{
    UIView *view = SYProgressHUD.share.selfSupperView;
    [SYProgressHUD showMessage:@"" activitty:YES images:nil view:view autoHide:NO duration:0 enable:YES];
}
/// 显示活动指示器，自动隐藏
+ (void)showActivityAutoHide
{
    UIView *view = SYProgressHUD.share.selfSupperView;
    NSTimeInterval duration = SYProgressHUD.share.durationTime;
    [SYProgressHUD showMessage:@"" activitty:YES images:nil view:view autoHide:YES duration:duration enable:YES];
}

/// 显示活动指示器和信息
+ (void)showMessageWithActivity:(NSString *)message
{
    UIView *view = SYProgressHUD.share.selfSupperView;
    [SYProgressHUD showMessage:message activitty:YES images:nil view:view autoHide:NO duration:0 enable:YES];
}
/// 显示活动指示器和信息，自动隐藏
+ (void)showMessageWithActivityAutoHide:(NSString *)message
{
    UIView *view = SYProgressHUD.share.selfSupperView;
    NSTimeInterval duration = SYProgressHUD.share.durationTime;
    [SYProgressHUD showMessage:message activitty:YES images:nil view:view autoHide:YES duration:duration enable:YES];
}

/// 显示图标
+ (void)showIcon:(NSArray <UIImage *> *)images
{
    UIView *view = SYProgressHUD.share.selfSupperView;
    [SYProgressHUD showMessage:@"" activitty:NO images:images view:view autoHide:NO duration:0 enable:YES];
}
/// 显示图标，自动隐藏
+ (void)showIconAutoHide:(NSArray <UIImage *> *)images
{
    UIView *view = SYProgressHUD.share.selfSupperView;
    NSTimeInterval duration = SYProgressHUD.share.durationTime;
    [SYProgressHUD showMessage:@"" activitty:NO images:images view:view autoHide:YES duration:duration enable:YES];
}

/// 显示图标和信息
+ (void)showMessageWithIcon:(NSString *)message icon:(NSArray <UIImage *> *)images
{
    UIView *view = SYProgressHUD.share.selfSupperView;
    [SYProgressHUD showMessage:message activitty:NO images:images view:view autoHide:NO duration:0 enable:YES];
}
/// 显示图标和信息，自动隐藏
+ (void)showMessageWithIconAutoHide:(NSString *)message icon:(NSArray <UIImage *> *)images
{
    UIView *view = SYProgressHUD.share.selfSupperView;
    NSTimeInterval duration = SYProgressHUD.share.durationTime;
    [SYProgressHUD showMessage:message activitty:NO images:images view:view autoHide:YES duration:duration enable:YES];
}

/// 显示信息
+ (void)showMessage:(NSString *)message
{
    UIView *view = SYProgressHUD.share.selfSupperView;
    [SYProgressHUD showMessage:message activitty:NO images:nil view:view autoHide:NO duration:0 enable:YES];
}
/// 显示信息，自动隐藏
+ (void)showMessageAutoHide:(NSString *)message
{
    UIView *view = SYProgressHUD.share.selfSupperView;
    NSTimeInterval duration = SYProgressHUD.share.durationTime;
    [SYProgressHUD showMessage:message activitty:NO images:nil view:view autoHide:YES duration:duration enable:YES];
}

#pragma mark 隐藏

/// 隐藏
+ (void)hide
{
    [SYProgressHUD.share hideDelay:0 complete:NULL];
}

/// 带回调的隐藏
+ (void)hideComplete:(void (^)(void))complete
{
    [SYProgressHUD.share hideDelay:0 complete:complete];
}

///  带回调的延迟隐藏
+ (void)hideDelay:(NSTimeInterval)delay complete:(void (^)(void))complete
{
    [SYProgressHUD.share hideDelay:delay complete:complete];
}


@end
