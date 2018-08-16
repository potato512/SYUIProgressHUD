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

@interface SYIToast ()

@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UILabel *textlabel;
@property (nonatomic, strong) UIButton *button;

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
        _bgroundColor = [UIColor blackColor];
        _textColor = [UIColor whiteColor];
        _textFont = [UIFont systemFontOfSize:16.0f];
    }
    return self;
}

#pragma mark - 显示

/// 显示信息（默认位置为居中）
- (void)showText:(NSString *)text
{
    [self showText:text postion:SYIToastPositionCenter];
}

/// 显示信息，自定义显示位置
- (void)showText:(NSString *)text postion:(SYIToastPosition)position
{
    if (text && 0 < text.length) {
        [self hideView];

        self.alpha = 1.0;
        [self.backView addSubview:self.textlabel];
        self.textlabel.text = text;

        CGSize textSize = [text boundingRectWithSize:CGSizeMake(maxWidthLabel, maxWidthLabel) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.textFont} context:nil].size;
        CGFloat labelX = (self.backView.frame.size.width - textSize.width) / 2;
        CGFloat labelY = 20.0 + 44.0 + sizeSpace;
        CGFloat labelWidth = textSize.width + sizeLabel;
        CGFloat labelHeight = textSize.height + sizeLabel;
        if (SYIToastPositionCenter == position) {
            labelY = (self.backView.frame.size.height - labelHeight) / 2;
        } else if (SYIToastPositionBottom == position) {
            labelY = (self.backView.frame.size.height - labelHeight - sizeSpace);
        }
        self.textlabel.frame = CGRectMake(labelX, labelY, labelWidth, labelHeight);
        
        [self.backView addSubview:self.button];
        self.button.frame = self.textlabel.frame;
        // 自动隐藏
        if ([self respondsToSelector:@selector(hideIToast)]) {
            [self performSelector:@selector(hideIToast) withObject:nil afterDelay:_hideTime];
        }
    }
}

#pragma mark - 隐藏

/// 隐藏
- (void)hideIToast
{
    [UIView animateWithDuration:0.6 animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self hideView];
    }];
}

- (void)hideView
{
    if (self.textlabel.superview) {
        [self.textlabel removeFromSuperview];
    }
    if (self.button.superview) {
        [self.button removeFromSuperview];
    }
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}

#pragma mark - getter

- (UIView *)backView
{
    if (_backView == nil) {
        _backView = [UIApplication sharedApplication].delegate.window;
    }
    return _backView;
}

- (UILabel *)textlabel
{
    if (_textlabel == nil) {
        _textlabel = [[UILabel alloc] init];
        _textlabel.font = _textFont;
        _textlabel.textColor = _textColor;
        _textlabel.textAlignment = NSTextAlignmentCenter;
        _textlabel.backgroundColor = _bgroundColor;
        _textlabel.layer.cornerRadius = 5.0;
        _textlabel.layer.masksToBounds = YES;
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
        _button.backgroundColor = [UIColor clearColor];
        [_button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}

#pragma mark - setter

- (void)setBgroundColor:(UIColor *)bgroundColor
{
    _bgroundColor = bgroundColor;
    self.textlabel.backgroundColor = _bgroundColor;
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

#pragma mark - 响应事件

- (void)buttonClick
{
    [self hideIToast];
}

@end

