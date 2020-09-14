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
static CGFloat const kHeightMessage = 48;
static CGFloat const kCorner = 10;
static CGFloat const kMinSize = 102;
#define kMaxWidth (UIScreen.mainScreen.bounds.size.width - kOrigin * 2)
//
static NSString *const keyWidthSelf = @"keyWidthSelf";
static NSString *const keyHeightSelf = @"keyHeightSelf";
static NSString *const keyWidthText = @"keyWidthText";
static NSString *const keyHeightText = @"keyHeightText";

#define HUDMainThreadAssert() NSAssert([NSThread isMainThread], @"SYUIProgressHUD needs to be accessed on the main thread.");

@interface SYUIHUDView : UIView

#pragma mark - 属性

/// 内容视图
@property (nonatomic, strong) UIView *contanerView;
//
@property (nonatomic, strong) UIActivityIndicatorView *activityView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *label;
//
@property (nonatomic, assign) NSTimeInterval delayTime;
@property (nonatomic, weak) NSTimer *delayTimer;

/// 是否点击隐藏（默认否）
@property (nonatomic, assign) BOOL touchHide;
/// 是否动画（默认否）
@property (nonatomic, assign) BOOL isAnimation;

/// 是否自适应字符大小（默认YES）
@property (nonatomic, assign) BOOL autoSize;
/// 最小宽度（默认宽度：40）
@property (nonatomic, assign) CGFloat minWidth;
/// 最大宽度（默认宽度：屏幕宽-20）
@property (nonatomic, assign) CGFloat maxWidth;
/// 大小（默认102*102）
@property (nonatomic, assign) CGSize size;

@property (nonatomic, copy) void (^hideBlock)(void);

@end

@implementation SYUIHUDView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initialize];
        //
        self.backgroundColor = UIColor.clearColor;
        self.alpha = 0.0;
        //
    }
    return self;
}

- (void)initialize
{
    _size = CGSizeMake(kMinSize, kMinSize);
    _autoSize = YES;
    _minWidth = kMinWidth;
    _maxWidth = kMaxWidth;
    
    _touchHide = NO;
}

- (void)reloadUI
{
    CGSize size = [self sizeWithText:self.label.text font:self.label.font constrainedSize:CGSizeMake(self.maxWidth, MAXFLOAT)];
    CGFloat widthMessage = size.width;
    CGFloat heightMessage = size.height;
    
    //
        CGFloat width = self.size.width;
        CGFloat height = self.size.height;
        if (width < minSize) {
            width = minSize;
        }
        if (height < minSize) {
            height = minSize;
        }
        self.hudSize = CGSizeMake(width, height);
        
        self.frame = CGRectMake((self.superview.frame.size.width - self.hudSize.width) / 2, (self.superview.frame.size.height - self.hudSize.height) / 2, self.hudSize.width, self.hudSize.height);
        self.activityView.frame = CGRectMake((self.frame.size.width - self.activityView.frame.size.width) / 2, (self.frame.size.height - heightMessage / 2 - originX - self.activityView.frame.size.height) / 2, self.activityView.frame.size.width, self.activityView.frame.size.height);
        self.iconView.frame = CGRectMake((self.frame.size.width - self.activityView.frame.size.width) / 2, (self.frame.size.height - heightMessage / 2 - originX - self.activityView.frame.size.height) / 2, self.activityView.frame.size.width, self.activityView.frame.size.height);
        self.messageLabel.frame = CGRectMake(originMessage, (self.iconView.frame.origin.y + self.iconView.frame.size.height + originX), (self.frame.size.width - originMessage * 2), heightMessage / 2);
        
        if (self.autoSize && self.mode != SYUIProgressHUDModeText && self.messageLabel.text.length > 0) {
            NSNumber *widthTextNumber = self.textSize[keyWidthText];
            // 文本宽度小于等于hud大小时，不做处理
            if ((widthTextNumber.doubleValue + originMessage * 2) > self.frame.size.width) {
    //            NSNumber *widthNumber = self.textSize[keyWidthSelf];
    //            CGFloat widthSelf = widthNumber.doubleValue;
                CGFloat widthSelf = widthTextNumber.doubleValue + originMessage * 2;
                //
                self.frame = CGRectMake((self.superview.frame.size.width - widthSelf) / 2, (self.superview.frame.size.height - self.hudSize.height) / 2, widthSelf, self.hudSize.height);
                //
                self.activityView.frame = CGRectMake((self.frame.size.width - self.activityView.frame.size.width) / 2, (self.frame.size.height - heightMessage / 2 - originX - self.activityView.frame.size.height) / 2, self.activityView.frame.size.width, self.activityView.frame.size.height);
                self.iconView.frame = CGRectMake((self.frame.size.width - self.activityView.frame.size.width) / 2, (self.frame.size.height - heightMessage / 2 - originX - self.activityView.frame.size.height) / 2, self.activityView.frame.size.width, self.activityView.frame.size.height);
                self.messageLabel.frame = CGRectMake((self.frame.size.width - widthTextNumber.doubleValue) / 2, (self.iconView.frame.origin.y + self.iconView.frame.size.height + originX), widthTextNumber.doubleValue, heightMessage / 2);
            }
        }
        
        [self reloadUI];
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

#pragma mark 延时隐藏计时器

- (void)timerStart
{
    self.delayTimer = [NSTimer scheduledTimerWithTimeInterval:self.delayTime target:self selector:@selector(hide) userInfo:nil repeats:NO];
}

- (void)timerStop
{
    if (self.delayTimer) {
        [self.delayTimer invalidate];
        self.delayTimer = nil;
    }
    //
    [self animationStart];
}

#pragma mark icon动画

- (void)animationStart
{
    [self animationRotationWithView:self.imageView duration:0.5 animation:YES];
}

- (void)animationStop
{
    [self animationRotationWithView:self.imageView duration:0.5 animation:NO];
}

- (void)animationRotationWithView:(UIView *)view duration:(NSTimeInterval)duration animation:(BOOL)isAnimation
{
    if (view == nil) {
        return;
    }
    
    [view.layer removeAllAnimations];
    
    if (isAnimation) {
        CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
        rotationAnimation.duration = duration;
        rotationAnimation.cumulative = YES;
        rotationAnimation.repeatCount = MAXFLOAT;
        [view.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    } else {
        
    }
}

#pragma mark 点击手势

- (void)addTapRecognizer
{
    if (self.contanerView) {
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchHideClick:)];
        self.contanerView.userInteractionEnabled = YES;
        [self.contanerView addGestureRecognizer:tapRecognizer];
    }
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

#pragma mark getter

- (UIView *)contanerView
{
    if (_contanerView == nil) {
        _contanerView = [[UIView alloc] init];
        _contanerView.backgroundColor = [UIColor.blackColor colorWithAlphaComponent:0.8];
        _contanerView.layer.cornerRadius = kCorner;
        _contanerView.layer.masksToBounds = YES;
        _contanerView.autoresizingMask = (UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin);
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

#pragma mark setter

- (void)setTouchHide:(BOOL)touchHide
{
    _touchHide = touchHide;
    if (_touchHide) {
        [self addTapRecognizer];
    } else {
        self.contanerView.userInteractionEnabled = NO;
    }
}

#pragma mark 显示隐藏

/// 显示
- (void)show
{
    if (self.superview == nil) {
        return;
    }
    
    self.alpha = 0;
    self.contanerView.alpha = 0;
    //
    [self reloadUI];
    //
    if (self.isAnimation) {
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            self.contanerView.alpha = 1;
            self.alpha = 1;
        } completion:^(BOOL finished) {

        }];
    } else {
        self.alpha = 1;
        self.contanerView.alpha = 1;
    }
}
/// 显示，自动隐藏 + 提示语 + 回调
- (void)showAutoHide:(NSTimeInterval)time finishHandle:(void (^)(void))handle
{
    [self show];
    if (time > 0) {
        [self hideDelay:time finishHandle:handle];
    }
}

- (void)hideFinish
{
    [self timerStop];
    //
    if (self.superview) {
        [self removeFromSuperview];
    }
    //
    if (self.hideBlock) {
        self.hideBlock();
    }
}
/// 隐藏
- (void)hide
{
    self.userInteractionEnabled = YES;
    
    if (self.isAnimation) {
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.contanerView.alpha = 0;
            self.alpha = 0;
        } completion:^(BOOL finished) {
            [self hideFinish];
        }];
    } else {
        self.alpha = 0;
        //
        [self hideFinish];
    }
}
/// 隐藏，延迟 + 回调
- (void)hideDelay:(NSTimeInterval)time finishHandle:(void (^)(void))handle
{
    self.hideBlock = [handle copy];
    self.delayTime = time;
    if (time > 0) {
        [self timerStart];
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

#pragma mark 显示隐藏

/// 显示
- (void)showInView:(UIView *)view enable:(BOOL)enable message:(NSString *)message delayTime:(NSTimeInterval)time finishHandle:(void (^)(void))handle
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
