//
//  SYUIToast.h
//  DemoItoast
//
//  Created by zhangshaoyu on 2020/9/12.
//  Copyright © 2020 zhangshaoyu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// toast类型（仅一个，多个）
typedef NS_ENUM(NSInteger, SYUIToastType) {
    /// toast类型（默认，仅一个）
    SYUIToastTypeDefault = 0,
    /// toast类型（多个）
    SYUIToastTypeMore = 1,
    /// toast类型（仅一个）
    SYUIToastTypeSingle = SYUIToastTypeDefault
};

@interface SYUIToast : UIView

@end

NS_ASSUME_NONNULL_END
