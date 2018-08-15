//
//  HUDVC.m
//  DemoItoast
//
//  Created by Herman on 2018/8/15.
//  Copyright © 2018年 zhangshaoyu. All rights reserved.
//

#import "HUDVC.h"

#import "SYHUDProgress.h"

@interface HUDVC () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation HUDVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"SYNetworkStatusView";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"hide" style:UIBarButtonItemStyleDone target:self action:@selector(buttonClick)];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tableFooterView = [UIView new];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadView
{
    [super loadView];
    self.view.backgroundColor = [UIColor whiteColor];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }
}


- (void)buttonClick
{
    [HudManager hide];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    }
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"showMessage";
    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"showIndeterminateMessage";
    } else if (indexPath.row == 2) {
        cell.textLabel.text = @"showInView: hide: afterDelay: enabled: message: 自动隐藏，可交互";
    } else if (indexPath.row == 3) {
        cell.textLabel.text = @"showInView: hide: afterDelay: enabled: message: 手动隐藏，不可交互";
    } else if (indexPath.row == 4) {
        cell.textLabel.text = @"showCustomView: message:";
    } else if (indexPath.row == 5) {
        cell.textLabel.text = @"PshowCustomView: message:";
    } else if (indexPath.row == 6) {
        cell.textLabel.text = @"showInView: mode: customView: hide: afterDelay: enabled: message: animation: 手动隐藏，可交互";
    } else if (indexPath.row == 7) {
        cell.textLabel.text = @"showInView: mode: customView: hide: afterDelay: enabled: message: animation: 手动隐藏，不可交互";
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        [HudManager showMessage:@"有网了..."];
    } else if (indexPath.row == 1) {
        [HudManager showIndeterminateMessage:@"正在登录..."];
    } else if (indexPath.row == 2) {
        [HudManager showInView:self.view hide:YES afterDelay:1.2 enabled:YES message:@"自动隐藏，可交互"];
    } else if (indexPath.row == 3) {
        [HudManager showInView:self.view hide:NO afterDelay:1.2 enabled:NO message:@"手动隐藏，不可交互"];
    } else if (indexPath.row == 4) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"withNetwork"]];
        imageView.frame = CGRectMake(0.0, 0.0, 60.0, 60.0);
        [HudManager showCustomView:imageView message:@"加载成功"];
    } else if (indexPath.row == 5) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"withoutNetwork"]];
        imageView.frame = CGRectMake(0.0, 0.0, 60.0, 60.0);
        [HudManager showCustomView:imageView message:@"断网了..."];
    } else if (indexPath.row == 6) {
        [HudManager showInView:self.view mode:MBProgressHUDModeText customView:nil hide:NO afterDelay:3.0 enabled:YES message:@"手动隐藏，可交互" animation:MBProgressHUDAnimationFade];
    } else if (indexPath.row == 7) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"withNetwork"]];
        imageView.frame = CGRectMake(0.0, 0.0, 60.0, 60.0);
        [HudManager showInView:self.view mode:MBProgressHUDModeCustomView customView:imageView hide:NO afterDelay:3.0 enabled:NO message:@"手动隐藏，不可交互" animation:MBProgressHUDAnimationZoom];
    }
}

@end
