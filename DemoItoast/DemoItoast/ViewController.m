//
//  ViewController.m
//  DemoItoast
//
//  Created by zhangshaoyu on 15/7/30.
//  Copyright (c) 2015年 zhangshaoyu. All rights reserved.
//

#import "ViewController.h"
#import "iToast+SYCategory.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"iToast";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"iToast" style:UIBarButtonItemStyleDone target:self action:@selector(buttonClick)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)buttonClick
{
    NSArray *messages = @[@"出错了，赶紧找问题吧！", @"正确！", @"因为你的不努力，现在发现了很多存在的隐患，你必须在规定的时间点完成所有的工作。否则后果很严重！"];
    NSArray *positons = @[[NSNumber numberWithInteger:iToastPositionBottom], [NSNumber numberWithInteger:iToastPositionCenter], [NSNumber numberWithInteger:iToastPositionTop]];
    NSString *message = messages[arc4random() % messages.count];
    NSNumber *position = positons[arc4random() % positons.count];
    // 方法1
//    [[iToast shareIToast] showText:message postion:position.integerValue];
    // 方法2 扩展类方法
    if (iToastPositionTop == position.integerValue)
    {
        [iToast alertWithTitle:message];
    }
    else if (iToastPositionCenter == position.integerValue)
    {
        [iToast alertWithTitleCenter:message];
    }
    else if (iToastPositionBottom == position.integerValue)
    {
        [iToast alertWithTitleBottom:message];
    }
}

@end
