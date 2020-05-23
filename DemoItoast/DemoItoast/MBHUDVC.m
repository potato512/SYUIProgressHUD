//
//  MBHUDVC.m
//  DemoItoast
//
//  Created by zhangshaoyu on 2020/5/15.
//  Copyright © 2020 zhangshaoyu. All rights reserved.
//

#import "MBHUDVC.h"
#import <MBProgressHUD/MBProgressHUD.h>

@interface MBHUDVC ()

@end

@implementation MBHUDVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"MBProgressHUD";
    //
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"click" style:UIBarButtonItemStyleDone target:self action:@selector(click)];
}

- (void)loadView
{
    [super loadView];
    self.view.backgroundColor = [UIColor whiteColor];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }
}

- (void)dealloc
{
//    [SYHUDUtil hide];
}

- (void)click
{
    // 小菊花
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [MBProgressHUD hideHUDForView:self.view animated:YES];
//    });
    
    
    // 小菊花
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:hud];
    hud.removeFromSuperViewOnHide = YES;
    //
    hud.offset = CGPointMake(10, 10);
    hud.minSize = CGSizeMake(120, 120);
    hud.contentColor = UIColor.greenColor;
//    hud.backgroundColor = [UIColor.yellowColor colorWithAlphaComponent:0.3];
    hud.animationType = MBProgressHUDAnimationFade;
//    hud.backgroundView.color = UIColor.brownColor;
//    hud.backgroundView.style = MBProgressHUDBackgroundStyleBlur;
    //
    [hud showAnimated:YES];
    [hud hideAnimated:YES afterDelay:3];
    
    
    // 环形进度
//    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
//    [self.view addSubview:hud];
//    hud.removeFromSuperViewOnHide = YES;
//    //
//    hud.mode = MBProgressHUDModeDeterminate;
//    hud.progress = 0.4;
//    //
//    [hud showAnimated:YES];
//    [hud hideAnimated:YES afterDelay:3];
    
    
    // 水平进度条
//    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
//    [self.view addSubview:hud];
//    hud.removeFromSuperViewOnHide = YES;
//    //
//    hud.mode = MBProgressHUDModeAnnularDeterminate;
//    hud.progress = 0.7;
//    //
//    [hud showAnimated:YES];
//    [hud hideAnimated:YES afterDelay:3];
    
    
    // 水平进度条
//    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
//    [self.view addSubview:hud];
//    hud.removeFromSuperViewOnHide = YES;
//    //
//    hud.mode = MBProgressHUDModeDeterminateHorizontalBar;
//    hud.progress = 0.7;
//    //
//    [hud showAnimated:YES];
//    [hud hideAnimated:YES afterDelay:3];
    
    
    // 文本+详情
//    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
//    [self.view addSubview:hud];
//    hud.removeFromSuperViewOnHide = YES;
//    hud.mode = MBProgressHUDModeText;
//    //
//    hud.label.text = @"user loading request.......................";
//    hud.label.textColor = UIColor.redColor;
//    hud.label.textAlignment = NSTextAlignmentRight;
//    hud.label.backgroundColor = UIColor.greenColor;
//    //
//    hud.detailsLabel.text = @"登录";
//    hud.detailsLabel.font = [UIFont systemFontOfSize:20];
//    //
//    [hud showAnimated:YES];
//    [hud hideAnimated:YES afterDelay:5];
    
    
    // 自定义视图
//    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
//    [self.view addSubview:hud];
//    hud.removeFromSuperViewOnHide = YES;
//    hud.mode = MBProgressHUDModeCustomView;
//    //
//    UIImage *image = [UIImage imageNamed:@"withoutNetwork"];
//    UIImageView *imageview = [[UIImageView alloc] initWithImage:image];
//    hud.customView = imageview;
//    //
//    [hud showAnimated:YES];
//    [hud hideAnimated:YES afterDelay:5];
    
    
    
    // 小菊花+文本+详情
//    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
//    MBProgressHUD *hud = [[MBProgressHUD alloc] init];
//    [self.view addSubview:hud];
//    hud.removeFromSuperViewOnHide = YES;
//    // MBProgressHUDModeIndeterminate, MBProgressHUDModeDeterminate, MBProgressHUDModeDeterminateHorizontalBar, MBProgressHUDModeAnnularDeterminate, MBProgressHUDModeCustomView, MBProgressHUDModeText
//    hud.mode = MBProgressHUDModeIndeterminate;
//    hud.square = YES;
//    //
//    hud.label.text = @"loading";
//    hud.label.textColor = UIColor.redColor;
//    hud.label.textAlignment = NSTextAlignmentRight;
//    hud.label.backgroundColor = UIColor.greenColor;
//    //
//    hud.detailsLabel.text = @"登录请求";
//    hud.detailsLabel.font = [UIFont systemFontOfSize:20];
//    //
//    [hud showAnimated:YES];
//    [hud hideAnimated:YES afterDelay:5];
//    hud.completionBlock = ^{
//        NSLog(@"隐藏了");
//    };
    
    


 
    
}

@end
