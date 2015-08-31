//
//  iToast.m
//  iToast
//
//  Created by zhangshaoyu on 15/7/30.
//  Copyright (c) 2015年 zhangshaoyu. All rights reserved.
//

#import "iToast.h"
#import <QuartzCore/QuartzCore.h>

#define FontSize ([UIFont systemFontOfSize:16.0])
static CGFloat sizeSpace = 40.0;
static CGFloat sizelabel = 8.0;
#define maxlabel (windowView.frame.size.width - 20.0 * 2)

@interface iToast ()

@property (nonatomic, strong) UILabel *textlabel;
@property (nonatomic, strong) UIButton *button;

@end

@implementation iToast

/// 单例
+ (id)shareIToast
{
    static iToast *iToastManager;
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
    [self showText:text postion:PositionCenter];
}

/// 隐藏
- (void)hidden
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
        [self hidden];
        
        UIView *windowView = [UIApplication sharedApplication].delegate.window;
        
        [windowView addSubview:self.textlabel];
        self.textlabel.text = text;

        CGSize textSize = [text sizeWithFont:FontSize constrainedToSize:CGSizeMake(maxlabel, maxlabel)];
        CGFloat labelX = (windowView.frame.size.width - textSize.width) / 2;
        CGFloat labelY = 20.0 + 44.0 + sizeSpace;
        CGFloat labelWidth = textSize.width + sizelabel;
        CGFloat labelHeight = textSize.height + sizelabel;
        if (PositionCenter == position)
        {
            labelY = (windowView.frame.size.height - labelHeight) / 2;
        }
        else if (PositionBottom == position)
        {
            labelY = (windowView.frame.size.height - labelHeight - sizeSpace);
        }
        self.textlabel.frame = CGRectMake(labelX, labelY, labelWidth, labelHeight);
        
        [windowView addSubview:self.button];
        self.button.frame = self.textlabel.frame;
        
        [self performSelector:@selector(hidden) withObject:nil afterDelay:1.2];
    }
}

#pragma mark - setter

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
    [self hidden];
}

@end

