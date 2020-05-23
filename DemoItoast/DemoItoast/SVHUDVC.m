//
//  SVHUDVC.m
//  DemoItoast
//
//  Created by zhangshaoyu on 2020/5/15.
//  Copyright © 2020 zhangshaoyu. All rights reserved.
//

#import "SVHUDVC.h"

@interface SVHUDVC ()

@end

@implementation SVHUDVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"SVProgressHUD";
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
    
}

@end
