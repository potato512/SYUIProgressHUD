//
//  SYUIBaseHUD.m
//  DemoItoast
//
//  Created by zhangshaoyu on 2020/9/12.
//  Copyright © 2020 zhangshaoyu. All rights reserved.
//

#import "SYUIBaseHUD.h"

//static CGFloat const originX = 10.0;
//static CGFloat const originMessage = 20.0;
//static CGFloat const heightMessage = 48;
//static CGFloat const minSize = 102;
//
static NSString *const keyWidthSelf = @"keyWidthSelf";
static NSString *const keyHeightSelf = @"keyHeightSelf";
static NSString *const keyWidthText = @"keyWidthText";
static NSString *const keyHeightText = @"keyHeightText";

@interface SYUIBaseHUD ()

//@property (nonatomic, assign) BOOL isAnimation;
////
//@property (nonatomic, strong) UIView *shadowView;
////
//@property (nonatomic, strong) UIActivityIndicatorView *activityView;
//@property (nonatomic, strong) UIImageView *iconView;
//@property (nonatomic, strong) UILabel *messageLabel;
////
//@property (nonatomic, weak) NSTimer *hideDelayTimer;

@end

@implementation SYUIBaseHUD

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initializeDefault];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initializeDefault];
    }
    return self;
}

- (void)initializeDefault
{
    _size = CGSizeMake(102, 102);
    _color = [UIColor colorWithWhite:0.0 alpha:0.2];
    _cornerRadius = 10;
    _activityColor = UIColor.whiteColor;
    _messageFont = [UIFont systemFontOfSize:15.0];
    _messageColor = [UIColor blackColor];
    _autoSize = NO;
    //
    self.contentView.backgroundColor = _color;
    self.contentView.layer.cornerRadius = _cornerRadius;
    self.contentView.layer.masksToBounds = YES;
    
    [self addTapRecognizer];
}

#pragma mark - UI设置

/*
- (void)loadUI
{
    if (self.activityView.superview == nil) {
        [self addSubview:self.activityView];
    }
    if (self.iconView.superview == nil) {
        [self addSubview:self.iconView];
    }
    if (self.messageLabel.superview == nil) {
        [self addSubview:self.messageLabel];
    }
    
    // 最小值不能小于102
    CGFloat width = self.hudSize.width;
    CGFloat height = self.hudSize.height;
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
 */

/*
- (void)reloadUI
{
    self.activityView.hidden = NO;
    self.iconView.hidden = NO;
    self.messageLabel.hidden = NO;

    if (self.mode == SYUIProgressHUDModeDefault) {
        self.iconView.hidden = YES;
        [self.activityView startAnimating];
        if (self.messageLabel.text.length <= 0.0) {
            self.messageLabel.hidden = YES;
            self.activityView.frame = CGRectMake((self.frame.size.width - self.activityView.frame.size.width) / 2, (self.frame.size.height - self.activityView.frame.size.height) / 2, self.activityView.frame.size.width, self.activityView.frame.size.height);
        }
    } else if (self.mode == SYUIProgressHUDModeCustomView) {
        self.activityView.hidden = YES;
        if (self.messageLabel.text.length <= 0.0) {
            self.messageLabel.hidden = YES;
            self.iconView.frame = CGRectMake((self.frame.size.width - self.activityView.frame.size.width) / 2, (self.frame.size.height - self.activityView.frame.size.height) / 2, self.activityView.frame.size.width, self.activityView.frame.size.height);
        }
    } else if (self.mode == SYUIProgressHUDModeText) {
        self.activityView.hidden = YES;
        self.iconView.hidden = YES;
        //
        NSNumber *widthNumber = self.textSize[keyWidthSelf];
        NSNumber *heightNumber = self.textSize[keyHeightSelf];
        NSNumber *widthTextNumber = self.textSize[keyWidthText];
        NSNumber *heightTextNumber = self.textSize[keyHeightText];
        self.frame = CGRectMake((self.superview.frame.size.width - widthNumber.doubleValue) / 2, (self.superview.frame.size.height - (heightMessage + originX * 2)) / 2, widthNumber.doubleValue, heightNumber.doubleValue);
        self.messageLabel.frame = CGRectMake((self.frame.size.width - widthTextNumber.doubleValue) / 2, originX, widthTextNumber.doubleValue, heightTextNumber.doubleValue);
    }
}
*/

/*
- (NSDictionary *)textSize
{
    self.minWidth = (self.minWidth <= 0 ? self.hudSize.width : self.minWidth);
    self.maxWidth = (self.maxWidth <= 0 ? (self.superview.frame.size.width - originX * 2) : self.maxWidth);
    CGSize minSize = [self sizeWithText:self.messageLabel.text font:self.messageLabel.font constrainedSize:CGSizeMake((self.minWidth - originMessage * 2), MAXFLOAT)];
    CGSize maxSize = [self sizeWithText:self.messageLabel.text font:self.messageLabel.font constrainedSize:CGSizeMake((self.maxWidth - originMessage * 2), MAXFLOAT)];
    //
    CGFloat width = 0;
    CGFloat height = 0;
    CGFloat widthText = 0;
    CGFloat heightText = 0;
    
    //
    if ((minSize.height + originX * 2) <= heightMessage) {
        width = self.minWidth;
//        width = MIN(self.minWidth, minSize.width);
        height = heightMessage;
        widthText = minSize.width;
        heightText = (heightMessage - originX * 2);
    } else {
        if ((maxSize.height + originX * 2) <= heightMessage) {
            width = self.maxWidth;
//            width = MAX(self.maxWidth, maxSize.width);
            height = heightMessage;
            widthText = maxSize.width;
            heightText = (heightMessage - originX * 2);
        } else {
            width = self.maxWidth;
//            width = MAX(self.maxWidth, maxSize.width);
            height = (maxSize.height + originX * 2);
            widthText = maxSize.width;
            heightText = maxSize.height;
        }
    }
    //
    if (self.isSingleline) {
        self.messageLabel.textAlignment = NSTextAlignmentCenter;
        self.messageLabel.numberOfLines = 1;
        height = heightMessage;
        heightText = (heightMessage - originX * 2);
    } else {
        self.messageLabel.textAlignment = NSTextAlignmentLeft;
        self.messageLabel.numberOfLines = 0;
    }
    return @{keyWidthSelf:[NSNumber numberWithFloat:width],
             keyHeightSelf:[NSNumber numberWithFloat:height],
             keyWidthText:[NSNumber numberWithFloat:widthText],
             keyHeightText:[NSNumber numberWithFloat:heightText]};
}
*/

/*
- (void)showWithView:(UIView *)view type:(SYUIProgressHUDMode)type image:(UIImage *)image message:(NSString *)message hide:(BOOL)autoHide delay:(NSTimeInterval)delayTime enabled:(BOOL)isEnabled shadow:(BOOL)showShadow animation:(BOOL)animation
{
    HUDMainThreadAssert();
    
    // 如果已存在，则从父视图移除
    if (self.superview) {
        [self removeFromSuperview];
        if (self.shadowView.superview) {
            [self.shadowView removeFromSuperview];
        }
    }
    [self stopTimer];
    
    if (view) {
        //
        [view addSubview:self.shadowView];
        self.shadowView.frame = view.bounds;
        //
        [view addSubview:self];
    }
    //
    self.mode = type;
    self.isAnimation = animation;
    //
    self.messageLabel.text = message;
    if (image) {
        self.iconView.image = image;
    }
    // 显示视图
    [self loadUI];
    //
    [self showHUD];
    [self startIconAnimation];

    if (showShadow) {
        self.shadowView.hidden = NO;
    } else {
        self.shadowView.hidden = YES;
    }
    self.hudEnable = isEnabled;
    
    if (autoHide) {
        [self startTimerDelay:delayTime];
    }
}

- (void)hide:(BOOL)animation
{
    HUDMainThreadAssert();
    self.isAnimation = animation;
    [self hideHUD];
}

- (void)hide:(BOOL)animation delay:(NSTimeInterval)delayTime
{
    HUDMainThreadAssert();
    self.isAnimation = animation;
    [self startTimerDelay:delayTime];
}
*/


#pragma mark - 动画样式

- (void)animationDefault:(BOOL)show
{
    HUDMainThreadAssert();
    if (show) {
        self.alpha = 0.0;
        self.shadowView.alpha = 0.0;
        if (self.isAnimation) {
            [UIView animateWithDuration:0.3 animations:^{
                self.alpha = 1.0;
                self.shadowView.alpha = 1.0;
            } completion:^(BOOL finished) {
                
            }];
        } else {
            self.alpha = 1.0;
            self.shadowView.alpha = 1.0;
        }
    } else {
        [self animationHide];
    }
}

- (void)animationScale:(BOOL)show
{
    HUDMainThreadAssert();
    if (show) {
        self.alpha = 1.0;
        self.shadowView.alpha = 1.0;
        self.transform = CGAffineTransformMakeScale(0.3, 0.3);
        if (self.isAnimation) {
            // 放大缩小动画
            [UIView animateWithDuration:0.3 animations:^{
                // 放大
                self.transform = CGAffineTransformMakeScale(1.2, 1.2);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.3 animations:^{
                    // 缩小
                    self.transform = CGAffineTransformMakeScale(0.8, 0.8);
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.3 animations:^{
                        // 还原
                        self.transform = CGAffineTransformMakeScale(1.0, 1.0);
                    }];
                }];
            }];
        } else {
            self.transform = CGAffineTransformMakeScale(1.0, 1.0);
            self.shadowView.alpha = 1.0;
        }
    } else {
        [self animationHide];
    }
}

- (void)animationTopToDown:(BOOL)show
{
    HUDMainThreadAssert();
    if (show) {
        self.alpha = 1.0;
        self.shadowView.alpha = 1.0;
        self.frame = CGRectMake(self.frame.origin.x, -self.hudSize.height, self.hudSize.width, self.hudSize.height);
        if (self.isAnimation) {
            // 下坠上移
            [UIView animateWithDuration:0.3 animations:^{
                // 下坠
                self.frame = CGRectMake(self.frame.origin.x, (self.superview.frame.size.height - self.hudSize.height) / 2 + originX * 2, self.hudSize.width, self.hudSize.height);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.3 animations:^{
                    // 上移
                    self.frame = CGRectMake(self.frame.origin.x, (self.superview.frame.size.height - self.hudSize.height) / 2 - originX, self.hudSize.width, self.hudSize.height);
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.3 animations:^{
                        // 还原
                        self.frame = CGRectMake(self.frame.origin.x, (self.superview.frame.size.height - self.hudSize.height) / 2, self.hudSize.width, self.hudSize.height);
                    }];
                }];
            }];
            
        } else {
            self.frame = CGRectMake(self.frame.origin.x, (self.superview.frame.size.height - self.hudSize.height) / 2, self.hudSize.width, self.hudSize.height);
            self.shadowView.alpha = 1.0;
        }
    } else {
        [self animationHide];
    }
}

- (void)animationHide
{
    HUDMainThreadAssert();
    if (self.isAnimation) {
        [UIView animateWithDuration:0.3 animations:^{
            self.alpha = 0.0;
            self.shadowView.alpha = 0.0;
        } completion:^(BOOL finished) {
            if (self.mode == SYUIProgressHUDModeCustomView) {
                if (self.activityView.isAnimating) {
                    [self.activityView stopAnimating];
                }
            }
            if (self.superview) {
                [self removeFromSuperview];
                self.shadowView.hidden = YES;
            }
        }];
    } else {
        self.alpha = 0.0;
        self.shadowView.alpha = 0.0;
        
        if (self.mode == SYUIProgressHUDModeCustomView) {
            if (self.activityView.isAnimating) {
                [self.activityView stopAnimating];
            }
        }
        self.hidden = YES;
        self.shadowView.hidden = YES;
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

#pragma mark - 延时隐藏计时器

- (void)startTimerDelay:(NSTimeInterval)time
{
    HUDMainThreadAssert();
    if (time <= 0) {
        return;
    }
    
    NSTimer *timer = [NSTimer timerWithTimeInterval:time target:self selector:@selector(hideHUD) userInfo:nil repeats:NO];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    self.hideDelayTimer = timer;
    
    self.dismissTimer = [NSTimer scheduledTimerWithTimeInterval:duration target:self selector:@selector(didDismiss) userInfo:nil repeats:NO];
}

- (void)stopTimer
{
    HUDMainThreadAssert();
    if (self.hideDelayTimer.isValid) {
        [self.hideDelayTimer invalidate];
    }
    
    //
    [self stopIconAnimation];
}

#pragma mark - icon动画

- (void)startIconAnimation
{
    HUDMainThreadAssert();
    [self animationRotationWithView:self.iconView duration:0.5 animation:self.iconAnimationEnable];
}

- (void)stopIconAnimation
{
    HUDMainThreadAssert();
    [self animationRotationWithView:self.iconView duration:0.5 animation:NO];
}

/// 旋转动画 add by zhangshaoyu 20190731
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

#pragma mark - 点击手势

- (void)addTapRecognizer
{
    if (self.contentView) {
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchHideClick:)];
        self.contentView.userInteractionEnabled = YES;
        [self.contentView addGestureRecognizer:tapRecognizer];
    }
}

- (void)touchHideClick:(UITapGestureRecognizer *)recognizer
{
    if (self.touchHide) {
        UIGestureRecognizerState state = recognizer.state;
        if (state == UIGestureRecognizerStateEnded) {
            [self hideHUD];
        }
    }
}

#pragma mark - getter

- (UIView *)contentView
{
    if (_contentView == nil) {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
        //
        [self addSubview:_contentView];
    }
    return _contentView;
}

- (UIActivityIndicatorView *)activityView
{
    if (_activityView == nil) {
        _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        _activityView.hidesWhenStopped = YES;
        _activityView.color = _activityColor;
        //
        [self.contentView addSubview:_activityView];
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
        [self.contentView addSubview:_imageView];
    }
    return _imageView;
}

- (UILabel *)messageLabel
{
    if (_messageLabel == nil) {
        _messageLabel = [[UILabel alloc] init];
        _messageLabel.backgroundColor = UIColor.clearColor;
        _messageLabel.font = _messageFont;
        _messageLabel.textColor = _messageColor;
        _messageLabel.textAlignment = NSTextAlignmentLeft;
        _messageLabel.numberOfLines = 0;
        //
        [self.contentView addSubview:_messageLabel];
    }
    return _messageLabel;
}

#pragma mark - setter

- (void)setHudColor:(UIColor *)hudColor
{
    HUDMainThreadAssert();
    _hudColor = hudColor;
    self.backgroundColor = _hudColor;
}

- (void)setHudCornerRadius:(CGFloat)hudCornerRadius
{
    HUDMainThreadAssert();
    _hudCornerRadius = hudCornerRadius;
    self.layer.cornerRadius = _hudCornerRadius;
}

- (void)setActivityColor:(UIColor *)activityColor
{
    HUDMainThreadAssert();
    _activityColor = activityColor;
    self.activityView.color = _activityColor;
}

- (void)setMessageFont:(UIFont *)messageFont
{
    HUDMainThreadAssert();
    _messageFont = messageFont;
    self.messageLabel.font = _messageFont;
}

- (void)setMessageColor:(UIColor *)messageColor
{
    HUDMainThreadAssert();
    _messageColor = messageColor;
    self.messageLabel.textColor= _messageColor;
}

- (void)setHudEnable:(BOOL)hudEnable
{
    HUDMainThreadAssert();
    _hudEnable = hudEnable;
    self.superview.userInteractionEnabled = _hudEnable;
}

#pragma mark - 显示隐藏

- (void)showHUD
{
//    if (self.animationMode == SYUIProgressHUDAnimationModeDefault) {
//        [self animationDefault:YES];
//    } else if (self.animationMode == SYUIProgressHUDAnimationModeScale) {
//        [self animationScale:YES];
//    } else if (self.animationMode == SYUIProgressHUDAnimationModeTopToDown) {
//        [self animationTopToDown:YES];
//    }
}

- (void)hideHUD
{
//    HUDMainThreadAssert();
//    if (self.animationMode == SYUIProgressHUDAnimationModeDefault) {
//        [self animationDefault:NO];
//    } else if (self.animationMode == SYUIProgressHUDAnimationModeScale) {
//        [self animationScale:NO];
//    } else if (self.animationMode == SYUIProgressHUDAnimationModeTopToDown) {
//        [self animationTopToDown:NO];
//    }
//    [self stopTimer];
//    self.hudEnable = YES;
//    self.iconAnimationEnable = NO;
}

/// 显示
- (void)show
{
    
}
/// 显示，提示语
- (void)showWithMessage:(NSString *)msg
{
    
}
/// 显示，提示语 + 回调
- (void)showWithMessage:(NSString *)msg handle:(void (^)(void))handle
{
    
}
/// 显示，自动隐藏
- (void)showAutoHide
{
    
}
/// 显示，自动隐藏 + 提示语
- (void)showAutoHideWithMessage:(NSString *)msg
{
    
}
/// 显示，自动隐藏 + 提示语 + 回调
- (void)showAutoHideWithMessage:(NSString *)msg handle:(void (^)(void))handle
{
    
}
/// 隐藏
- (void)hide
{
    
}
/// 隐藏，延迟
- (void)hideDelay:(NSTimeInterval)time
{
    
}
/// 隐藏，延迟 + 回调
- (void)hideDelay:(NSTimeInterval)time handle:(void (^)(void))handle
{
    
}

@end
