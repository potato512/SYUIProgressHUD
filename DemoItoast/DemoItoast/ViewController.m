//
//  ViewController.m
//  DemoItoast
//
//  Created by zhangshaoyu on 15/7/30.
//  Copyright (c) 2015年 zhangshaoyu. All rights reserved.
//

#import "ViewController.h"
#import "iToast.h"

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
    NSArray *positons = @[[NSNumber numberWithInteger:PositionBottom], [NSNumber numberWithInteger:PositionCenter], [NSNumber numberWithInteger:PositionTop]];
    NSString *message = messages[arc4random() % messages.count];
    NSNumber *position = positons[arc4random() % positons.count];
    [[iToast shareIToast] showText:message postion:position.integerValue];
}

@end
