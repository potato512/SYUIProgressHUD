//
//  SYIToast.m
//  zhangshaoyu
//
//  Created by zhangshaoyu on 15/7/30.
//  Copyright (c) 2015年 zhangshaoyu. All rights reserved.
//

#import "SYIToast.h"
#import <QuartzCore/QuartzCore.h>

#define FontSize ([UIFont systemFontOfSize:16.0])
static CGFloat sizeSpace = 40.0;
static CGFloat sizelabel = 8.0;
#define maxlabel (self.backView.frame.size.width - 20.0 * 2)

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

/// 显示信息（默认位置为居中）
- (void)showText:(NSString *)text
{
    [self showText:text postion:iToastPositionCenter];
}

/// 隐藏
- (void)hiddenIToast
{
    if (self.textlabel.superview)
    {
        [self.textlabel removeFromSuperview];
    }
    
    if (self.button.superview)
    {
        [self.button removeFromSuperview];
    }
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}

/// 显示信息，自定义显示位置
- (void)showText:(NSString *)text postion:(iToastPosition)position
{
    if (text && 0 < text.length)
    {
        [self hiddenIToast];

        [self.backView addSubview:self.textlabel];
        self.textlabel.text = text;

        CGSize textSize = [text sizeWithFont:FontSize constrainedToSize:CGSizeMake(maxlabel, maxlabel)];
        CGFloat labelX = (self.backView.frame.size.width - textSize.width) / 2;
        CGFloat labelY = 20.0 + 44.0 + sizeSpace;
        CGFloat labelWidth = textSize.width + sizelabel;
        CGFloat labelHeight = textSize.height + sizelabel;
        if (iToastPositionCenter == position)
        {
            labelY = (self.backView.frame.size.height - labelHeight) / 2;
        }
        else if (iToastPositionBottom == position)
        {
            labelY = (self.backView.frame.size.height - labelHeight - sizeSpace);
        }
        self.textlabel.frame = CGRectMake(labelX, labelY, labelWidth, labelHeight);
        
        [self.backView addSubview:self.button];
        self.button.frame = self.textlabel.frame;
        
        if ([self respondsToSelector:@selector(hiddenIToast)])
        {
            [self performSelector:@selector(hiddenIToast) withObject:nil afterDelay:1.6];
        }
    }
}

#pragma mark - getter

- (UIView *)backView
{
    if (_backView == nil)
    {
        _backView = [UIApplication sharedApplication].delegate.window;
    }
    return _backView;
}

- (UILabel *)textlabel
{
    if (!_textlabel)
    {
        _textlabel = [[UILabel alloc] init];
        _textlabel.font = FontSize;
        _textlabel.textColor = [UIColor whiteColor];
        _textlabel.textAlignment = NSTextAlignmentCenter;
        _textlabel.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.8];
        _textlabel.layer.cornerRadius = 5.0;
        _textlabel.layer.masksToBounds = YES;
        _textlabel.numberOfLines = 0;
        _textlabel.shadowColor = [UIColor darkGrayColor];
        _textlabel.shadowOffset = CGSizeMake(1.0, 1.0);
        _textlabel.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    }
    return _textlabel;
}

- (UIButton *)button
{
    if (!_button)
    {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.backgroundColor = [UIColor clearColor];
        [_button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _button;
}

#pragma mark - 响应事件

- (void)buttonClick
{
    [self hiddenIToast];
}

@end

