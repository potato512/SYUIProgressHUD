//
//  SYToastView.m
//  zhangshaoyu
//
//  Created by zhangshaoyu on 2018/8/15.
//  Copyright © 2018年 zhangshaoyu. All rights reserved.
//

#import "SYToastView.h"

#define widthMainScreen  [UIScreen mainScreen].bounds.size.width
#define heightMainScreen [UIScreen mainScreen].bounds.size.height

static CGFloat const cornerRadius = 5.0;
static CGFloat const originXY = 10.0;
static CGFloat const heightStatusView = 44.0;
static NSTimeInterval const dutationTime = 0.3;
static CGFloat const originYStatus = 64.0;

@interface SYToastView ()

@property (nonatomic, strong) UIView *superView;
@property (nonatomic, assign) BOOL isWindow;
@property (nonatomic, assign) PositionMode positionMode;
@property (nonatomic, assign) BOOL animation;

@property (nonatomic, strong) UILabel *messagelabel;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation SYToastView

+ (instancetype)shareToastView
{
    static SYToastView *statusView = nil;
    static dispatch_once_t predicate;
    if (statusView == nil) {
        dispatch_once(&predicate, ^{
            statusView = [[self alloc] init];
        });
    }    
    return statusView;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _hideTime = 3.0f;
        _bgroundColor = [UIColor blackColor];
        _textFont = [UIFont systemFontOfSize:16.0f];
        _textColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setSelf:(UIView *)view
{
    self.hidden = YES;
    
    self.frame = CGRectMake(originXY, 0.0, (widthMainScreen - originXY * 2), heightStatusView);
    self.backgroundColor = _bgroundColor;
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:tapRecognizer];
    
    if (self.superView == nil) {
        self.superView = view;
        [self.superView addSubview:self];
    }
    
    self.isWindow = (view ? NO : YES);
}

- (void)resetUI:(CGFloat)width image:(UIImage *)image
{
    if (PositionTop == self.positionMode) {
        
        CGFloat widthTotal = width;
        if (image) {
            widthTotal += (CGRectGetHeight(self.imageView.frame) + originXY);
        }
        CGFloat originXImage = (widthMainScreen - widthTotal) / 2;
    
        if (image) {
            CGRect rectImage = self.imageView.frame;
            rectImage.origin.x = originXImage;
            self.imageView.frame = rectImage;
        }
        
        CGRect rectlabel = self.messagelabel.frame;
        rectlabel.origin.x = (originXImage + (image ? (originXY + CGRectGetHeight(self.imageView.frame)) : 0.0));
        rectlabel.size.width = width;
        self.messagelabel.frame = rectlabel;
    } else {
        CGRect rectlabel = self.messagelabel.frame;
        rectlabel.size.width = width;
        self.messagelabel.frame = rectlabel;
        
        CGFloat widthSelf = originXY * 2 + width;
        widthSelf += (!image ? 0.0 : (originXY + CGRectGetHeight(self.imageView.frame)));
        CGRect rectSelf = self.frame;
        rectSelf.origin.x = ((widthMainScreen - widthSelf) / 2);
        rectSelf.size.width = widthSelf;
        self.frame = rectSelf;
    }
    
    [self layoutSubviews];
}

- (void)showInView:(UIView *)view position:(PositionMode)posttion message:(NSString *)message image:(UIImage *)image animation:(BOOL)animation
{
    [self setSelf:view];
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    
    self.positionMode = posttion;
    self.animation = animation;
    
    [self show:message image:image animation:animation];
}

- (void)show:(NSString *)message image:(UIImage *)image animation:(BOOL)animation
{
    self.imageView.frame = CGRectMake(originXY, originXY, (CGRectGetHeight(self.bounds) - originXY * 2), (CGRectGetHeight(self.bounds) - originXY * 2));
    if (self.imageView.superview == nil) {
        [self addSubview:self.imageView];
    }
    self.imageView.image = image;
    
    self.messagelabel.frame = CGRectMake((self.imageView.frame.origin.x + self.imageView.frame.size.width + originXY), 0.0, (CGRectGetWidth(self.bounds) - (self.imageView.frame.origin.x + self.imageView.frame.size.width + originXY) - originXY), CGRectGetHeight(self.bounds));
    if (self.messagelabel.superview == nil) {
        [self addSubview:self.messagelabel];
    }
    self.messagelabel.text = message;
    self.messagelabel.textAlignment = NSTextAlignmentLeft;
    
    CGSize sizeMessage = [self.messagelabel.text sizeWithFont:self.messagelabel.font forWidth:widthMainScreen lineBreakMode:self.messagelabel.lineBreakMode];
    CGFloat widthMessage = sizeMessage.width;
    CGFloat widthMax = (CGRectGetWidth(self.bounds) - originXY * 3 - self.imageView.frame.size.width);
    
    if (image == nil) {
        widthMax = (CGRectGetWidth(self.bounds) - originXY * 2);
        
        CGRect rectImage = self.imageView.frame;
        rectImage.size.width = 0.0;
        rectImage.size.height = 0.0;
        self.imageView.frame = rectImage;
        
        CGRect rectlabel = self.messagelabel.frame;
        rectlabel.origin.x = originXY;
        rectlabel.size.width = (CGRectGetWidth(self.bounds) - originXY);
        self.messagelabel.frame = rectlabel;
        self.messagelabel.textAlignment = NSTextAlignmentCenter;
    }
    
    widthMessage = (widthMessage >= widthMax ? widthMax : widthMessage);
    [self resetUI:widthMessage image:image];
    
    if (self.animation) {
        self.alpha = 0.0;
        self.hidden = NO;
        
        [UIView animateWithDuration:dutationTime animations:^{
            self.alpha = 1.0;
        } completion:^(BOOL finished) {
            [self performSelector:@selector(hide) withObject:nil afterDelay:_hideTime];
        }];
    } else {
        self.hidden = NO;
        [self performSelector:@selector(hide) withObject:nil afterDelay:_hideTime];
    }
}

- (void)hide
{
    [UIView animateWithDuration:dutationTime animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        self.hidden = YES;
    }];
}

#pragma mark - setter

- (void)setPositionMode:(PositionMode)positionMode
{
    _positionMode = positionMode;
    
    CGRect rectSelf = self.frame;
    
    if (PositionTop == _positionMode) {
        rectSelf.origin.x = 0.0;
        CGFloat originY = (self.isWindow ? (originYStatus + 0.0) : 0.0);
        rectSelf.origin.y = originY;
        rectSelf.size.width = widthMainScreen;
        
        self.layer.cornerRadius = 0.0;
        self.layer.masksToBounds = NO;
    }
    
    if (PositionTopRountAdjust == _positionMode) {
        CGFloat originY = (self.isWindow ? (originYStatus + originXY) : originXY);
        rectSelf.origin.y = originY;
    } else if (PositionCenterRountAdjust == _positionMode) {
        CGFloat originY = ((CGRectGetHeight(self.superView.bounds) - heightStatusView) / 2);
        rectSelf.origin.y = originY;
        
        [self layoutSubviews];
    } else if (PositionBottomRountAdjust == _positionMode) {
        CGFloat originY = ((CGRectGetHeight(self.superView.bounds) - heightStatusView) - originYStatus);
        rectSelf.origin.y = originY;
        
        [self layoutSubviews];
    }
    
    self.frame = rectSelf;
}

- (void)setBgroundColor:(UIColor *)bgroundColor
{
    _bgroundColor = bgroundColor;
    self.backgroundColor = _bgroundColor;
}

- (void)setTextFont:(UIFont *)textFont
{
    _textFont = textFont;
    self.messagelabel.font = _textFont;
}

- (void)setTextColor:(UIColor *)textColor
{
    _textColor = textColor;
    self.messagelabel.textColor = _textColor;
}

#pragma mark - getter

- (UILabel *)messagelabel
{
    if (_messagelabel == nil) {
        _messagelabel = [[UILabel alloc] init];
        _messagelabel.backgroundColor = [UIColor clearColor];
        _messagelabel.textColor = _textColor;
        _messagelabel.font = _textFont;
    }
    return _messagelabel;
}

- (UIImageView *)imageView
{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        _imageView.backgroundColor = [UIColor clearColor];
    }
    return _imageView;
}

@end
