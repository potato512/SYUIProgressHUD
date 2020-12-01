//
//  SYUIToast.m
//  zhangshaoyu
//
//  Created by zhangshaoyu on 2020/9/12.
//  Copyright © 2020 zhangshaoyu. All rights reserved.
//

#import "SYUIToast.h"

#pragma mark - toast view

static CGFloat const kOrigin = 10;
static CGFloat const kMinWidth = 120;
#define kMaxWidth (UIScreen.mainScreen.bounds.size.width - kOrigin * 4)
static CGFloat const kMinHeight = 40;
static CGFloat const kCorner = 8;

@interface SYUIToastView : UIView

/// 容器内容视图
@property (nonatomic, strong) UIView *contanerView;
/// 标签
@property (nonatomic, strong) UILabel *label;

/// 背景阴影色
@property (nonatomic, strong) UIColor *shadowColor;

/// 最小宽度（默认宽度：120）
@property (nonatomic, assign) CGFloat minWidth;
/// 最大宽度（默认宽度：屏幕宽-40）
@property (nonatomic, assign) CGFloat maxWidth;
/// 最小高度（默认高度：40）
@property (nonatomic, assign) CGFloat minHeight;
/// 是否自适应字符大小（默认NO）
@property (nonatomic, assign) BOOL autoSize;

@property (nonatomic, assign) CGFloat originY;
@property (nonatomic, assign) CGFloat originBottom;

/// 是否点击隐藏（默认NO）
@property (nonatomic, assign) BOOL touchHide;
/// 是否动画（默认NO）
@property (nonatomic, assign) BOOL isAmination;

@property (nonatomic, weak) NSTimer *delayTimer;
@property (nonatomic, copy) void (^hideBlock)(void);

@end

@implementation SYUIToastView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initialize];
        //
        self.autoresizingMask = (UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin);
        self.backgroundColor = UIColor.clearColor;
        self.alpha = 0.0;
    }
    return self;
}

- (void)initialize
{
    _autoSize = NO;
    _minWidth = kMinWidth;
    _maxWidth = kMaxWidth;
    _minHeight = kMinHeight;

    _touchHide = NO;
    _isAmination = NO;
}

- (void)reloadUI
{
    //
    CGSize size = [self sizeWithText:self.label.text font:self.label.font constrainedSize:CGSizeMake((self.maxWidth - kOrigin * 2), MAXFLOAT)];
    CGFloat widthMessage = size.width;
    CGFloat heightMessage = size.height;
    //
    if (self.autoSize) {
        if (heightMessage <= self.minHeight) {
            self.label.numberOfLines = 1;
            self.label.textAlignment = NSTextAlignmentCenter;
            //
            widthMessage = MAX(widthMessage, self.minWidth);
            heightMessage = self.minHeight;
        } else {
            self.label.numberOfLines = 0;
            self.label.textAlignment = NSTextAlignmentLeft;
            //
            widthMessage = (self.maxWidth - kOrigin * 2);
            heightMessage = (size.height + kOrigin * 2);
        }
    } else {
        self.label.numberOfLines = 1;
        self.label.textAlignment = NSTextAlignmentCenter;
        //
        widthMessage = MAX(widthMessage, self.minWidth);
        heightMessage = self.minHeight;
    }
    //
    CGFloat widthTotal = (widthMessage + kOrigin * 2);
    CGFloat heightTotal = heightMessage;
    CGFloat originX = (self.superview.frame.size.width - widthTotal) / 2;
    CGFloat originY = (self.superview.frame.size.height - heightTotal) / 2;
    if (self.originY > 0) {
        originY = self.originY;
    }
    //
    self.frame = self.superview.bounds;
    self.contanerView.frame = CGRectMake(originX, originY, widthTotal, heightTotal);
    self.label.frame = CGRectMake(kOrigin, 0, widthMessage, heightMessage);
}

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font constrainedSize:(CGSize)size
{
    CGSize sizeTmp = CGSizeZero;
    if (text && font) {
        if (7.0 <= [UIDevice currentDevice].systemVersion.floatValue) {
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
            NSDictionary *dict = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy};
            
            sizeTmp = [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
        }
    }
    return sizeTmp;
}

#pragma mark getter

- (UIView *)contanerView
{
    if (_contanerView == nil) {
        _contanerView = [[UIView alloc] init];
        _contanerView.backgroundColor = [UIColor.blackColor colorWithAlphaComponent:0.8];
        _contanerView.autoresizingMask = (UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin);
        _contanerView.layer.cornerRadius = kCorner;
        _contanerView.layer.masksToBounds = YES;
        //
        [self addSubview:_contanerView];
    }
    return _contanerView;
}

- (UILabel *)label
{
    if (_label == nil) {
        _label = [[UILabel alloc] init];
        _label.backgroundColor = UIColor.clearColor;
        _label.font = [UIFont systemFontOfSize:13];
        _label.textColor = UIColor.whiteColor;
        _label.textAlignment = NSTextAlignmentCenter;
        _label.numberOfLines = 1;
        //
        [self.contanerView addSubview:_label];
    }
    return _label;
}

#pragma mark 点击

- (void)setTouchHide:(BOOL)touchHide
{
    _touchHide = touchHide;
    if (_touchHide) {
        [self addTapRecognizer];
    } else {
        self.contanerView.userInteractionEnabled = NO;
    }
}
- (void)addTapRecognizer
{
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchHideClick:)];
    self.contanerView.userInteractionEnabled = YES;
    [self.contanerView addGestureRecognizer:tapRecognizer];
}

- (void)touchHideClick:(UITapGestureRecognizer *)recognizer
{
    if (self.touchHide) {
        UIGestureRecognizerState state = recognizer.state;
        if (state == UIGestureRecognizerStateEnded) {
            [self hide];
        }
    }
}

#pragma mark 定时器

- (void)timerStart:(NSTimeInterval)time
{
    if (time <= 0) {
        return;
    }
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:time target:self selector:@selector(hide) userInfo:nil repeats:NO];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    self.delayTimer = timer;
}

- (void)timerStop
{
    [self.delayTimer invalidate];
}

#pragma mark 通知

- (void)notificationPostShow
{
    [NSNotificationCenter.defaultCenter postNotificationName:kNotificationToastDidShow object:nil];
}

- (void)notificationPostHide
{
    [NSNotificationCenter.defaultCenter postNotificationName:kNotificationToastDidHide object:nil];
}

#pragma mark 显示、隐藏

/// 显示
- (void)show
{
    if (self.superview == nil) {
        return;
    }
    
    self.alpha = 0.0;
    self.backgroundColor = UIColor.clearColor;
    //
    [self timerStop];
    [self reloadUI];
    if (self.isAmination) {
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            self.alpha = 1.0f;
            self.backgroundColor = (self.shadowColor ? self.shadowColor : UIColor.clearColor);
        } completion:^(BOOL finished) {
            
        }];
    } else {
        self.alpha = 1.0;
        self.backgroundColor = (self.shadowColor ? self.shadowColor : UIColor.clearColor);
    }
    [self notificationPostShow];
}
/// 显示，自动隐藏 + 提示语 + 回调
- (void)showAutoHide:(NSTimeInterval)time finishHandle:(void (^)(void))handle
{
    [self show];
    if (time > 0) {
        [self hideDelay:time finishHandle:handle];
    }
}

/// 隐藏
- (void)hide
{
    self.userInteractionEnabled = YES;
    
    if (self.isAmination) {
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.alpha = 0.0;
            self.backgroundColor = UIColor.clearColor;
        } completion:^(BOOL finished) {
            [self hideFinish];
        }];
    } else {
        self.alpha = 0.0;
        self.backgroundColor = UIColor.clearColor;
        [self hideFinish];
    }
}
- (void)hideFinish
{
    [self timerStop];
    if (self.superview) {
        [self removeFromSuperview];
    }
    if (self.hideBlock) {
        self.hideBlock();
    }
    [self notificationPostHide];
}
/// 隐藏，延迟 + 回调
- (void)hideDelay:(NSTimeInterval)time finishHandle:(void (^)(void))handle
{
    self.hideBlock = [handle copy];
    if (time > 0) {
        [self timerStart:time];
    } else {
        [self hide];
    }
}

@end


#pragma mark - toast manager

@interface SYUIToast ()

@property (nonatomic, strong) SYUIToastView *toastView;

@end

@implementation SYUIToast

+ (instancetype)share
{
    static SYUIToast *toast = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        toast = [[SYUIToast alloc] init];
    });
    return toast;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

#pragma mark getter

- (SYUIToastView *)toastView
{
    if (_toastView == nil) {
        _toastView = [[SYUIToastView alloc] init];
    }
    return _toastView;
}

#pragma mark setter

- (void)setMinWidth:(CGFloat)minWidth
{
    _minWidth = minWidth;
    self.toastView.minWidth = _minWidth;
}

- (void)setMaxWidth:(CGFloat)maxWidth
{
    _maxWidth = maxWidth;
    self.toastView.maxWidth = _maxWidth;
}

- (void)setMinHeight:(CGFloat)minHeight
{
    _minHeight = minHeight;
    self.toastView.minHeight = _minHeight;
}

- (void)setAutoSize:(BOOL)autoSize
{
    _autoSize = autoSize;
    self.toastView.autoSize = _autoSize;
}

- (void)setTouchHide:(BOOL)touchHide
{
    _touchHide = touchHide;
    self.toastView.touchHide = _touchHide;
}

- (void)setIsAmination:(BOOL)isAmination
{
    _isAmination = isAmination;
    self.toastView.isAmination = _isAmination;
}

- (void)setMessageFont:(UIFont *)messageFont
{
    _messageFont = messageFont;
    self.toastView.label.font = _messageFont;
}
- (void)setMessageColor:(UIColor *)messageColor
{
    _messageColor = messageColor;
    self.toastView.label.textColor = _messageColor;
}

- (void)setToastColor:(UIColor *)toastColor
{
    _toastColor = toastColor;
    self.toastView.contanerView.backgroundColor = _toastColor;
}
- (void)setToastCornerRadius:(CGFloat)toastCornerRadius
{
    _toastCornerRadius = toastCornerRadius;
    self.toastView.contanerView.layer.cornerRadius = _toastCornerRadius;
}

- (void)setShadowColor:(UIColor *)shadowColor
{
    _shadowColor = shadowColor;
    self.toastView.shadowColor = _shadowColor;
}

- (void)setOffsetY:(CGFloat)offsetY
{
    _offsetY = offsetY;
    self.toastView.originY = _offsetY;
}
- (void)setOffsetYBottom:(CGFloat)offsetYBottom
{
    _offsetYBottom = offsetYBottom;
    self.toastView.originBottom = _offsetYBottom;
}

#pragma mark 显示隐藏

/// 显示，自动隐藏 + 提示语 + 回调
- (void)showInView:(UIView *)view enable:(BOOL)enable message:(NSString *)message autoHide:(NSTimeInterval)time finishHandle:(void (^)(void))handle
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (view && [view isKindOfClass:UIView.class] && [view respondsToSelector:@selector(addSubview:)]) {
            [view addSubview:self.toastView];
            self.toastView.userInteractionEnabled = !enable;
        }
        self.toastView.label.text = message;
        if (time > 0) {
            [self.toastView showAutoHide:time finishHandle:handle];
        } else {
            [self.toastView show];
        }
    });
}

/// 隐藏，延迟 + 回调
- (void)hideDelay:(NSTimeInterval)time finishHandle:(void (^)(void))handle
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.toastView hideDelay:time finishHandle:handle];
    });
}

@end
