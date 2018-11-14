//
//  SYIToast.m
//  zhangshaoyu
//
//  Created by zhangshaoyu on 15/7/30.
//  Copyright (c) 2015年 zhangshaoyu. All rights reserved.
//

#import "SYIToast.h"
#import <QuartzCore/QuartzCore.h>

static CGFloat const sizeSpace = 40.0f;
static CGFloat const sizeLabel = 16.0f;
#define maxWidthLabel (self.backView.frame.size.width - 20.0 * 2 - sizeLabel)
static CGFloat const sizeIcon = 30;

@interface SYIToast ()

@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UILabel *textlabel;
@property (nonatomic, strong) UIButton *button;

@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;
@property (nonatomic, strong) UIView *customViewTmp;

@end

@implementation SYIToast

/// 单例
+ (id)shareIToast
{
    static SYIToast *iToastManager;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        iToastManager = [[self alloc] init];
        assert(iToastManager != nil);
    });
    
    return iToastManager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _hideTime = 1.6;
        _bgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
        _textColor = [UIColor whiteColor];
        _textFont = [UIFont systemFontOfSize:16.0f];
        
        self.backgroundColor = _bgroundColor;
        self.layer.cornerRadius = 5.0;
        self.layer.masksToBounds = YES;
    }
    return self;
}

#pragma mark - 显示

/**
 弹窗提示

 @param view 父视图
 @param text 提示语
 @param type 提示类型
 @param position 提示位置
 @param autoHide 是否自动隐藏
 @param isEnabel 父视图是否可交互
 */
- (void)showToastInView:(UIView *)view text:(NSString *)text type:(SYIToastType)type position:(SYIToastPosition)position hide:(BOOL)autoHide enable:(BOOL)isEnabel
{
    if ((text && [text isKindOfClass:[NSString class]] && 0 < text.length) && (view && [view isKindOfClass:[UIView class]])) {
        [self hideView];
        //
        self.alpha = 1.0;
        if (self.superview == nil) {
            self.backView = view;
            [self.backView addSubview:self];
        }
        //
        self.textlabel.text = text;
        //
        CGSize textSize = [text boundingRectWithSize:CGSizeMake(maxWidthLabel, maxWidthLabel) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.textFont} context:nil].size;
        CGFloat labelWidth = textSize.width + sizeLabel;
        CGFloat labelHeight = textSize.height + sizeLabel;
        CGFloat labelX = (self.backView.frame.size.width - labelWidth) / 2;
        CGFloat labelY = 20.0 + 44.0 + sizeSpace;
        self.frame = CGRectMake(labelX, labelY, labelWidth, labelHeight);
        self.textlabel.frame = self.bounds;
        
        //
        if (type == SYIToastTypeIndicato) {
            CGRect rect = self.frame;
            rect.size.height += (sizeSpace + self.indicatorView.frame.size.height);
            self.frame = rect;
            
            CGRect rectIndicator = self.indicatorView.frame;
            rectIndicator.origin = CGPointMake((self.frame.size.width - self.indicatorView.frame.size.width) / 2, sizeSpace / 2);
            self.indicatorView.frame = rectIndicator;
            
            CGRect rectLabel = self.textlabel.frame;
            rectLabel.origin.y = self.indicatorView.frame.origin.y + self.indicatorView.frame.size.height + sizeSpace / 4;
            self.textlabel.frame = rectLabel;
            
            [self.indicatorView startAnimating];
        } else if (type == SYIToastTypeCustom) {
            CGRect rect = self.frame;
            rect.size.height += (sizeSpace + sizeIcon);
            self.frame = rect;
            
            CGRect rectView = self.customViewTmp.frame;
            rectView.origin = CGPointMake((self.frame.size.width - sizeIcon) / 2, sizeSpace / 2);
            rectView.size = CGSizeMake(sizeIcon, sizeIcon);
            self.customViewTmp.frame = rectView;
            
            CGRect rectLabel = self.textlabel.frame;
            rectLabel.origin.y = self.customViewTmp.frame.origin.y + self.customViewTmp.frame.size.height + sizeSpace / 4;
            self.textlabel.frame = rectLabel;
        }
        //
        if (SYIToastPositionCenter == position) {
            labelY = (self.backView.frame.size.height - self.frame.size.height) / 2;
        } else if (SYIToastPositionBottom == position) {
            labelY = (self.backView.frame.size.height - self.frame.size.height - sizeSpace);
        }
        CGRect rect = self.frame;
        rect.origin.y = labelY;
        self.frame = rect;
        //
        self.button.frame = self.bounds;
        
        // 是否可操作父视图
        self.backView.userInteractionEnabled = isEnabel;
        // 自动隐藏
        if (autoHide && [self respondsToSelector:@selector(hideIToast)]) {
            [self performSelector:@selector(hideIToast) withObject:nil afterDelay:_hideTime];
        }
    }
}

#pragma mark - 隐藏

/// 隐藏
- (void)hideToast
{
    [UIView animateWithDuration:0.6 animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self hideView];
    }];
}

- (void)hideView
{
    if (self.superview) {
        [self removeFromSuperview];
    }
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}

#pragma mark - getter

- (UILabel *)textlabel
{
    if (_textlabel == nil) {
        _textlabel = [[UILabel alloc] init];
        [self addSubview:_textlabel];
        _textlabel.font = _textFont;
        _textlabel.textColor = _textColor;
        _textlabel.textAlignment = NSTextAlignmentCenter;
        _textlabel.numberOfLines = 0;
//        _textlabel.shadowColor = _textColor;
//        _textlabel.shadowOffset = CGSizeMake(1.0, 1.0);
        _textlabel.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    }
    return _textlabel;
}

- (UIButton *)button
{
    if (_button == nil) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_button];
        _button.backgroundColor = [UIColor clearColor];
        [_button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}

- (UIActivityIndicatorView *)indicatorView
{
    if (_indicatorView == nil) {
        _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [self addSubview:_indicatorView];
        _indicatorView.hidesWhenStopped = YES;
        _indicatorView.color = [UIColor colorWithWhite:0.5 alpha:0.5];
        [_indicatorView stopAnimating];
    }
    return _indicatorView;
}

- (UIView *)customViewTmp
{
    if (_customViewTmp == nil) {
        _customViewTmp = [[UIView alloc] init];
        [self addSubview:_customViewTmp];
        _customViewTmp.backgroundColor = [UIColor clearColor];
    }
    return _customViewTmp;
}

#pragma mark - setter

- (void)setBgroundColor:(UIColor *)bgroundColor
{
    _bgroundColor = bgroundColor;
    self.backgroundColor = _bgroundColor;
}

- (void)setTextFont:(UIFont *)textFont
{
    _textFont = textFont;
    self.textlabel.font = _textFont;
}

- (void)setTextColor:(UIColor *)textColor
{
    _textColor = textColor;
    self.textlabel.textColor = _textColor;
}

- (void)setIndicatoColor:(UIColor *)indicatoColor
{
    _indicatoColor = indicatoColor;
    self.indicatorView.color = _indicatoColor;
}

- (void)setCustomView:(UIView *)customView
{
    _customView = customView;
    [self.customViewTmp addSubview:_customView];
}

#pragma mark - 响应事件

- (void)buttonClick
{
    [self hideToast];
}

@end

