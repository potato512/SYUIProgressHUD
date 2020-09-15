//
//  SYUIHUD.m
//  zhangshaoyu
//
//  Created by zhangshaoyu on 2020/9/12.
//  Copyright © 2020 zhangshaoyu. All rights reserved.
//

#import "SYUIHUD.h"

#pragma mark - hud view

static CGFloat const kOrigin = 10.0;
static CGFloat const kHeightMessage = 30;
static CGFloat const kCorner = 8;
static CGFloat const kMinSize = 102;
#define kMaxWidth (UIScreen.mainScreen.bounds.size.width - kOrigin * 4)

#define HUDMainThreadAssert() NSAssert([NSThread isMainThread], @"SYUIProgressHUD needs to be accessed on the main thread.");

@interface SYUIHUDView : UIView

#pragma mark - 属性

/// 内容视图
@property (nonatomic, strong) UIView *contanerView;
//
@property (nonatomic, strong) UIActivityIndicatorView *activityView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *label;

@property (nonatomic, strong) UIColor *shadowColor;
@property (nonatomic, assign) BOOL imageAnimation;
@property (nonatomic, assign) NSTimeInterval imageDuration;
//
@property (nonatomic, weak) NSTimer *delayTimer;

/// 是否点击隐藏（默认NO）
@property (nonatomic, assign) BOOL touchHide;
/// 是否动画（默认NO）
@property (nonatomic, assign) BOOL isAnimation;

/// 是否自适应字符大小（默认YES）
@property (nonatomic, assign) BOOL autoSize;
/// 最大宽度（默认宽度：屏幕宽-40）
@property (nonatomic, assign) CGFloat maxWidth;
/// 大小（默认102*102）
@property (nonatomic, assign) CGSize size;

@property (nonatomic, assign) CGFloat originY;

@property (nonatomic, assign) SYUIHUDMode mode;

@property (nonatomic, copy) void (^hideBlock)(void);

@end

@implementation SYUIHUDView

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
    _autoSize = YES;
    _size = CGSizeMake(kMinSize, kMinSize);
    _maxWidth = kMaxWidth;
    
    _touchHide = NO;
    _isAnimation = NO;
    
    _imageAnimation = NO;
    _imageDuration = 0.5;
    
    _mode = SYUIHUDModeDefault;
}

- (void)reloadUI
{
    CGSize size = [self sizeWithText:self.label.text font:self.label.font constrainedSize:CGSizeMake((self.maxWidth - kOrigin * 2), MAXFLOAT)];
    CGFloat widthMessage = size.width;
    CGFloat heightMessage = kHeightMessage;
    //
    if (self.autoSize) {
        widthMessage = MAX(widthMessage, (self.size.width - kOrigin * 2));
    } else {
        widthMessage = (self.size.width - kOrigin * 2);
    }
    //
    CGFloat widthTotal = (widthMessage + kOrigin * 2);
    CGFloat heightTotal = self.size.height;
    CGFloat originXTotal = (self.superview.frame.size.width - widthTotal) / 2;
    CGFloat originYTotal = (self.superview.frame.size.height - heightTotal) / 2;
    if (self.originY > 0) {
        originYTotal = self.originY;
    }
    //
    self.frame = self.superview.bounds;
    self.contanerView.frame = CGRectMake(originXTotal, originYTotal, widthTotal, heightTotal);
    //
    CGFloat originXActivity = (self.contanerView.frame.size.width - self.activityView.frame.size.width) / 2;
    CGFloat originYActivity = (self.contanerView.frame.size.height - heightMessage - self.activityView.frame.size.height) / 2;
    //
    self.activityView.frame = CGRectMake(originXActivity, originYActivity, self.activityView.frame.size.width, self.activityView.frame.size.height);
    self.imageView.frame = CGRectMake(originXActivity, originYActivity, self.activityView.frame.size.width, self.activityView.frame.size.height);
    self.label.frame = CGRectMake(kOrigin, (self.imageView.frame.origin.y + self.imageView.frame.size.height + kOrigin), widthMessage, heightMessage);
    //
    self.label.hidden = YES;
    self.activityView.hidden = YES;
    [self.activityView stopAnimating];
    self.imageView.hidden = YES;
    if (self.mode == SYUIHUDModeDefault || self.mode == SYUIHUDModeActivityText || self.mode == SYUIHUDModeCustomViewText) {
        self.label.hidden = NO;
        if (self.mode == SYUIHUDModeDefault || self.mode == SYUIHUDModeActivityText) {
            self.activityView.hidden = NO;
            [self.activityView startAnimating];
        } else if (self.mode == SYUIHUDModeCustomViewText) {
            self.imageView.hidden = NO;
        }
    } else if (self.mode == SYUIHUDModeActivity || self.mode == SYUIHUDModeCustomView) {
        widthTotal = self.size.width;
        originXTotal = (self.superview.frame.size.width - widthTotal) / 2;
        //
        self.contanerView.frame = CGRectMake(originXTotal, originYTotal, widthTotal, heightTotal);
        //
        originXActivity = (self.contanerView.frame.size.width - self.activityView.frame.size.width) / 2;
        originYActivity = (self.contanerView.frame.size.height - self.activityView.frame.size.height) / 2;
        if (self.originY > 0) {
            originYTotal = self.originY;
        }
        //
        self.activityView.frame = CGRectMake(originXActivity, originYActivity, self.activityView.frame.size.width, self.activityView.frame.size.height);
        self.imageView.frame = CGRectMake(originXActivity, originYActivity, self.activityView.frame.size.width, self.activityView.frame.size.height);
        //
        if (self.mode == SYUIHUDModeActivity) {
            self.activityView.hidden = NO;
            [self.activityView startAnimating];
        } else if (self.mode == SYUIHUDModeCustomView) {
            self.imageView.hidden = NO;
        }
    }
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
        _contanerView.autoresizingMask = (UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin);
        _contanerView.layer.cornerRadius = kCorner;
        _contanerView.layer.masksToBounds = YES;
        //
        [self addSubview:_contanerView];
    }
    return _contanerView;
}

- (UIActivityIndicatorView *)activityView
{
    if (_activityView == nil) {
        _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        _activityView.hidesWhenStopped = YES;
        _activityView.color = UIColor.whiteColor;
        //
        [self.contanerView addSubview:_activityView];
    }
    return _activityView;
}

- (UIImageView *)imageView
{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        _imageView.backgroundColor = UIColor.clearColor;
        //
        [self.contanerView addSubview:_imageView];
    }
    return _imageView;
}

- (UILabel *)label
{
    if (_label == nil) {
        _label = [[UILabel alloc] init];
        _label.backgroundColor = UIColor.clearColor;
        _label.font = [UIFont systemFontOfSize:13];
        _label.textColor = UIColor.blackColor;
        _label.textAlignment = NSTextAlignmentCenter;
        _label.numberOfLines = 1;
        //
        [self.contanerView addSubview:_label];
    }
    return _label;
}

#pragma mark 点击手势

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

#pragma mark 动画

- (void)animationStart
{
    [self animationStop];
    if (self.imageAnimation) {
        if (self.mode == SYUIHUDModeCustomViewText || self.mode == SYUIHUDModeCustomView) {
            [self animationRotationWithView:self.imageView duration:self.imageDuration animation:YES];
        }
    }
}

- (void)animationStop
{
    [self animationRotationWithView:self.imageView duration:0 animation:NO];
}

- (void)animationRotationWithView:(UIView *)view duration:(NSTimeInterval)duration animation:(BOOL)isAnimation
{
    if (view == nil) {
        return;
    }
    
    [view.layer removeAllAnimations];
    
    if (isAnimation) {
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        animation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
        animation.duration = duration;
        animation.cumulative = YES;
        animation.repeatCount = MAXFLOAT;
        animation.removedOnCompletion = NO;
        [view.layer addAnimation:animation forKey:@"rotationAnimation"];
    } else {
        
    }
}

#pragma mark 通知

- (void)notificationPostShow
{
    [NSNotificationCenter.defaultCenter postNotificationName:kNotificationHUDDidShow object:nil];
}

- (void)notificationPostHide
{
    [NSNotificationCenter.defaultCenter postNotificationName:kNotificationHUDDidHide object:nil];
}

#pragma mark 显示隐藏

/// 显示
- (void)show
{
    if (self.superview == nil) {
        return;
    }
    
    self.alpha = 0;
    self.backgroundColor = (self.shadowColor ? self.shadowColor : UIColor.clearColor);
    //
    [self timerStop];
    [self reloadUI];
    [self animationStart];
    //
    if (self.isAnimation) {
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            self.alpha = 1;
        } completion:^(BOOL finished) {

        }];
    } else {
        self.alpha = 1;
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
    self.backgroundColor = UIColor.clearColor;
    
    if (self.isAnimation) {
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.alpha = 0.0;
        } completion:^(BOOL finished) {
            [self hideFinish];
        }];
    } else {
        self.alpha = 0.0;
        [self hideFinish];
    }
}
- (void)hideFinish
{
    [self timerStop];
    [self animationStop];
    [self.activityView stopAnimating];
    //
    if (self.superview) {
        [self removeFromSuperview];
    }
    //
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

#pragma mark - hud manager

@interface SYUIHUD ()

@property (nonatomic, strong) SYUIHUDView *hudView;

@end

@implementation SYUIHUD

+ (instancetype)share
{
    static SYUIHUD *hud = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        hud = [[SYUIHUD alloc] init];
    });
    return hud;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

#pragma mark getter

- (SYUIHUDView *)hudView
{
    if (_hudView == nil) {
        _hudView = [[SYUIHUDView alloc] init];
    }
    return _hudView;
}

#pragma mark setter

- (void)setMode:(SYUIHUDMode)mode
{
    _mode = mode;
    self.hudView.mode = _mode;
}

- (void)setSize:(CGSize)size
{
    _size = size;
    self.hudView.size = _size;
}
- (void)setMaxWidth:(CGFloat)maxWidth
{
    _maxWidth = maxWidth;
    self.hudView.maxWidth = _maxWidth;
}
- (void)setAutoSize:(BOOL)autoSize
{
    _autoSize = autoSize;
    self.hudView.autoSize = _autoSize;
}

- (void)setTouchHide:(BOOL)touchHide
{
    _touchHide = touchHide;
    self.hudView.touchHide = _touchHide;
}

-(void)setIsAmination:(BOOL)isAmination
{
    _isAmination = isAmination;
    self.hudView.isAnimation = _isAmination;
}

- (void)setShadowColor:(UIColor *)shadowColor
{
    _shadowColor = shadowColor;
    self.hudView.shadowColor = _shadowColor;
}

- (void)setHudColor:(UIColor *)hudColor
{
    _hudColor = hudColor;
    self.hudView.contanerView.backgroundColor = _hudColor;
}

- (void)setHudCornerRadius:(CGFloat)hudCornerRadius
{
    _hudCornerRadius = hudCornerRadius;
    self.hudView.contanerView.layer.cornerRadius = _hudCornerRadius;
}

- (void)setActivityColor:(UIColor *)activityColor
{
    _activityColor = activityColor;
    self.hudView.activityView.color = _activityColor;
}

- (void)setImageName:(NSString *)imageName
{
    _imageName = imageName;
    self.hudView.imageView.image = [UIImage imageNamed:imageName];
}
- (void)setImageAnimation:(BOOL)imageAnimation
{
    _imageAnimation = imageAnimation;
    self.hudView.imageAnimation = _imageAnimation;
}
- (void)setImageDuration:(NSTimeInterval)imageDuration
{
    _imageDuration = imageDuration;
    self.hudView.imageDuration = _imageDuration;
}

- (void)setMessageFont:(UIFont *)messageFont
{
    _messageFont = messageFont;
    self.hudView.label.font = _messageFont;
}

- (void)setMessageColor:(UIColor *)messageColor
{
    _messageColor = messageColor;
    self.hudView.label.textColor = _messageColor;
}

- (void)setOffsetY:(CGFloat)offsetY
{
    _offsetY = offsetY;
    self.hudView.originY = _offsetY;
}

#pragma mark 显示隐藏

/// 显示
- (void)showInView:(UIView *)view enable:(BOOL)enable message:(NSString *)message autoHide:(NSTimeInterval)time finishHandle:(void (^)(void))handle
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (view && [view isKindOfClass:UIView.class] && [view respondsToSelector:@selector(addSubview:)]) {
            [view addSubview:self.hudView];
            self.hudView.userInteractionEnabled = !enable;
        }
        
        self.hudView.label.text = message;
        if (time > 0) {
            [self.hudView showAutoHide:time finishHandle:handle];
        } else {
            [self.hudView show];
        }
    });
}

/// 隐藏
- (void)hideDelay:(NSTimeInterval)time finishHandle:(void (^)(void))handle
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.hudView hideDelay:time finishHandle:handle];
    });
}

@end
