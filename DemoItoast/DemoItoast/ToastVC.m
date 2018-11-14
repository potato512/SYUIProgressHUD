//
//  ToastVC.m
//  DemoItoast
//
//  Created by Herman on 2018/8/15.
//  Copyright © 2018年 zhangshaoyu. All rights reserved.
//

#import "ToastVC.h"
#import "SYIToast+SYCategory.h"

@interface ToastVC ()

@end

@implementation ToastVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.navigationItem.title = @"SYIToast";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"SYToast" style:UIBarButtonItemStyleDone target:self action:@selector(buttonClick)];
    
    [[SYIToast shareIToast] setTextColor:[UIColor purpleColor]];
//    [[SYIToast shareIToast] setBgroundColor:[UIColor greenColor]];
    [[SYIToast shareIToast] setTextFont:[UIFont systemFontOfSize:20.0]];
    [[SYIToast shareIToast] setIndicatoColor:[UIColor redColor]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)buttonClick
{
    NSArray *messages = @[@"出错了，赶紧找问题吧！", @"正确！", @"因为你的不努力，现在发现了很多存在的隐患，你必须在规定的时间点完成所有的工作。否则后果很严重！"];
    NSArray *positons = @[[NSNumber numberWithInteger:SYIToastPositionBottom], [NSNumber numberWithInteger:SYIToastPositionCenter], [NSNumber numberWithInteger:SYIToastPositionTop]];
    NSString *message = messages[arc4random() % messages.count];
    NSNumber *position = positons[arc4random() % positons.count];
    // 方法1
//    [[iToast shareIToast] showText:message postion:position.integerValue];
    // 方法2 扩展类方法
//    if (SYIToastPositionTop == position.integerValue) {
//        [SYIToast alertWithTitle:message];
//    } else if (SYIToastPositionCenter == position.integerValue) {
//        [SYIToast alertWithTitleCenter:message];
//    } else if (SYIToastPositionBottom == position.integerValue) {
//        [SYIToast alertWithTitleBottom:message];
//    }
    
    // 方法3
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"withNetwork"]];
    imageView.frame = CGRectMake(0.0, 0.0, 50, 50.0);
    [[SYIToast shareIToast] setCustomView:imageView];
    [[SYIToast shareIToast] showToastInView:self.view text:message type:SYIToastTypeCustom position:position.integerValue hide:NO enable:YES];
}

@end
